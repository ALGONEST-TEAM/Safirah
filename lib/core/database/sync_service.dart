import 'dart:convert';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/core/network/remote_request.dart';
import 'package:safirah/core/database/table/sync_queue_table.dart';

import 'maltipart_payload.dart';

/// خدمة عامة لإدارة المزامنة بين قاعدة البيانات المحلية والخادم.
///
/// الفكرة:
/// - عند أي عملية (إضافة / تعديل / حذف) على أي جدول مدعوم
///   نقوم بإضافة سجل في جدول [SyncQueue].
/// - في وقت لاحق (عند الاتصال بالإنترنت) نستدعي [syncPendingOperations]
///   ليقوم بإرسال كل العمليات غير المزامنة للخادم، وعند نجاحها نحدّث السجل كـ synced.
class SyncService {
  final Safirah db;

  SyncService({required this.db});

  /// أنواع العمليات المدعومة في طابور المزامنة
  static const String operationCreate = 'create';
  static const String operationUpdate = 'update';
  static const String operationDelete = 'delete';

  /// تهدئة بسيطة بين كل عملية sync (حتى لو ناجحة) لتقليل ضغط الطلبات على السيرفر
  /// وتقليل احتمالية 429.
  static const Duration _interItemDelay = Duration(milliseconds: 250);

  /// سقف انتظار مناسب لإعادة المحاولة (خصوصاً مع 429/5xx)
  static const Duration _maxBackoff = Duration(seconds: 60);

  bool _isSyncing = false;

  /// إضافة عملية إلى جدول المزامنة.
  ///
  /// [entityType] مثال: 'league', 'team', 'player'...
  /// [entityId] هو الـ id المحلي في قاعدة البيانات.
  /// [operation] أحد القيم: create / update / delete.
  /// [payload] هو البيانات التي سيتم إرسالها للخادم على شكل JSON.
  Future<int> enqueueOperation({
    required String entityType,
    int entityId = 0,
    required String operation,
    required Map<String, dynamic> payload,
  }) async {
    return await db.into(db.syncQueue).insert(
          SyncQueueCompanion.insert(
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: jsonEncode(payload),
            status: const Value(SyncQueueStatus.pending),
          ),
        );
  }

  /// استرجاع كل العمليات غير المزامنة مرتبة حسب تاريخ الإنشاء.
  Future<List<SyncQueueData>> getPendingOperations({int maxAttempts = 5}) {
    return (db.select(db.syncQueue)
          ..where(
            (tbl) =>
                // الحالة الأساسية
                tbl.status.equals(SyncQueueStatus.pending) &
                // تجنب إعادة المحاولة للأبد
                tbl.attemptCount.isSmallerThanValue(maxAttempts),
          )
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.asc),
          ]))
        .get();
  }

  /// تنفيذ كل العمليات غير المزامنة.
  ///
  /// [maxAttempts] عدد المحاولات قبل اعتبار العملية failed.
  Future<void> syncPendingOperations({
    required Future<EntitySyncEndpoint> Function(
            String entityType, String operation)
        entityEndpointResolver,
    int maxAttempts = 5,
    bool throwOnFirstError = false,
  }) async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final pending = await getPendingOperations(maxAttempts: maxAttempts);

      for (var i = 0; i < pending.length; i++) {
        final item = pending[i];

        // تهدئة ثابتة بين العناصر (تقلل 429 حتى لو لم يكن هناك فشل سابق)
        if (i > 0 && _interItemDelay != Duration.zero) {
          await Future<void>.delayed(_interItemDelay);
        }

        // Backoff بسيط: إذا كان هناك محاولات سابقة، انتظر مدة قصيرة قبل إعادة المحاولة.
        final wait = _computeBackoff(item.attemptCount);
        if (wait != Duration.zero) {
          await Future<void>.delayed(wait);
        }

        await (db.update(db.syncQueue)..where((tbl) => tbl.id.equals(item.id)))
            .write(
          SyncQueueCompanion(
            status: const Value(SyncQueueStatus.inProgress),
            lastAttemptAt: Value(DateTime.now()),
            lastError: const Value(null),
          ),
        );

        try {
          final endpoint =
              await entityEndpointResolver(item.entityType, item.operation);

          final Map<String, dynamic> data =
              jsonDecode(item.payload) as Map<String, dynamic>;

          await _sendToRemote(
            endpoint: endpoint,
            data: data,
          );

          await (db.update(db.syncQueue)..where((tbl) => tbl.id.equals(item.id)))
              .write(
            const SyncQueueCompanion(
              synced: Value(true),
              status: Value(SyncQueueStatus.synced),
            ),
          );
        } catch (e) {
          final decision = _decideRetry(
            e,
            attemptCount: item.attemptCount,
            maxAttempts: maxAttempts,
          );

          // إذا السيرفر رجّع Retry-After (خصوصاً 429)، احترمه قبل تحديث السجل
          // حتى لا نضرب السيرفر مرة ثانية بسرعة.
          if (decision.recommendedWait != null &&
              decision.recommendedWait != Duration.zero) {
            await Future<void>.delayed(decision.recommendedWait!);
          }

          await (db.update(db.syncQueue)..where((tbl) => tbl.id.equals(item.id)))
              .write(
            SyncQueueCompanion(
              attemptCount: Value(decision.nextAttemptCount),
              status: Value(decision.status),
              lastError: Value(_truncateError(decision.message)),
              lastAttemptAt: Value(DateTime.now()),
            ),
          );

          if (throwOnFirstError) {
            if (e is DioException) {
              // ignore: avoid_print
              print(
                  '[SyncService] immediate sync failed: ${e.response?.statusCode} ${e.response?.data}');
              rethrow;
            }
            // ignore: avoid_print
            print('[SyncService] immediate sync failed: $e');
            throw e;
          }
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  Duration _computeBackoff(int attemptCount) {
    // 0 => لا انتظار.
    // 1 => ~800ms. 2 => ~1.6s. 3 => ~3.2s ... مع jitter وبحد أقصى 60s
    if (attemptCount <= 0) return Duration.zero;

    final baseMs = (800 * math.pow(2, attemptCount - 1)).toInt();

    // jitter: +/- 20% لتجنب تزامن الأجهزة على نفس اللحظة
    final jitterFactor = 0.8 + (_rand.nextDouble() * 0.4); // 0.8..1.2
    final withJitter = (baseMs * jitterFactor).round();

    final capped = withJitter.clamp(0, _maxBackoff.inMilliseconds);
    return Duration(milliseconds: capped);
  }

  static final math.Random _rand = math.Random();

  Duration? _parseRetryAfter(DioException error) {
    final headers = error.response?.headers;
    if (headers == null) return null;

    // Dio headers values are List<String>
    String? raw;
    final values = headers.map['retry-after'] ?? headers.map['Retry-After'];
    if (values != null && values.isNotEmpty) {
      raw = values.first;
    }
    if (raw == null) return null;

    // Retry-After can be seconds or HTTP-date.
    final seconds = int.tryParse(raw.trim());
    if (seconds != null) {
      // حد أقصى حتى لا نعلق طويلاً لو السيرفر يرسل رقم كبير.
      final capped = seconds.clamp(0, _maxBackoff.inSeconds);
      return Duration(seconds: capped);
    }

    // محاولة تفسيره كتاريخ
    final date = DateTime.tryParse(raw);
    if (date != null) {
      final diff = date.toUtc().difference(DateTime.now().toUtc());
      if (diff.isNegative) return Duration.zero;
      if (diff > _maxBackoff) return _maxBackoff;
      return diff;
    }

    return null;
  }

  _RetryDecision _decideRetry(
    Object error, {
    required int attemptCount,
    required int maxAttempts,
  }) {
    final nextAttemptCount = attemptCount + 1;

    if (error is DioException) {
      final status = error.response?.statusCode;

      // 1) أخطاء شبكة/انقطاع/timeout => مؤقتة
      final isTimeout = error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout;

      final isConnection = error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.unknown;

      if (isTimeout || isConnection) {
        return _RetryDecision.pending(
          nextAttemptCount: nextAttemptCount,
          maxAttempts: maxAttempts,
          message: 'Network error: ${error.message ?? error.type.name}',
        );
      }

      // 2) 429 => rate limit (مؤقتة) مع احترام Retry-After إن توفر
      if (status == 429) {
        final retryAfter = _parseRetryAfter(error);
        final wait = retryAfter ?? _computeBackoff(nextAttemptCount);

        return _RetryDecision.pending(
          nextAttemptCount: nextAttemptCount,
          maxAttempts: maxAttempts,
          message: 'Rate limited (429). Will retry after ${wait.inSeconds}s.',
          recommendedWait: wait,
        );
      }

      // 3) 5xx => مؤقتة
      if (status != null && status >= 500) {
        return _RetryDecision.pending(
          nextAttemptCount: nextAttemptCount,
          maxAttempts: maxAttempts,
          message: 'Server error ($status): ${error.message ?? ''}',
        );
      }

      // 4) 409 => تعارض (غالباً دائم) => failed
      if (status == 409) {
        return _RetryDecision.failed(
          nextAttemptCount: nextAttemptCount,
          message: 'Conflict (409): request already processed or data conflict.',
        );
      }

      // 5) 4xx => غالباً دائم (payload/صلاحيات/endpoint)
      if (status != null && status >= 400 && status < 500) {
        return _RetryDecision.failed(
          nextAttemptCount: nextAttemptCount,
          message: 'Client error ($status): ${error.message ?? ''}',
        );
      }

      // 6) باقي الحالات: نعاملها كمؤقتة حتى maxAttempts
      return _RetryDecision.pending(
        nextAttemptCount: nextAttemptCount,
        maxAttempts: maxAttempts,
        message: 'Dio error: ${error.message ?? error.type.name}',
      );
    }

    return _RetryDecision.pending(
      nextAttemptCount: nextAttemptCount,
      maxAttempts: maxAttempts,
      message: 'Unexpected error: $error',
    );
  }

  String _truncateError(String message, {int max = 500}) {
    if (message.length <= max) return message;
    return message.substring(0, max);
  }

  /// إرسال البيانات إلى الخادم حسب نوع العملية (create / update / delete)
  // Future<void> _sendToRemote({
  //   required EntitySyncEndpoint endpoint,
  //   required Map<String, dynamic> data,
  // }) async {
  //   switch (endpoint.method) {
  //     case HttpMethod.post:
  //       await RemoteRequest.postData(path: endpoint.path, data: data);
  //       break;
  //     case HttpMethod.put:
  //       await RemoteRequest.putData(path: endpoint.path, data: data);
  //       break;
  //     case HttpMethod.delete:
  //       await RemoteRequest.deleteData(path: endpoint.path, data: data);
  //       break;
  //     case HttpMethod.get:
  //       await RemoteRequest.getData(url: endpoint.path, query: data);
  //       break;
  //   }
  // }
  Future<void> _sendToRemote({
    required EntitySyncEndpoint endpoint,
    required Map<String, dynamic> data,
  }) async {
    // ✅ يتحول لـ FormData فقط إذا يوجد __files
    final body = await MultipartPayload.maybeToFormData(data);
    if (body is FormData) {
      // ignore: avoid_print
      print('FORM fields=${body.fields.length} files=${body.files.length}');
      for (final f in body.files) {
        // ignore: avoid_print
        print('FILE key=${f.key} filename=${f.value.filename} len=${f.value.length}');
      }
    }
    switch (endpoint.method) {
      case HttpMethod.post:
        await RemoteRequest.postData(path: endpoint.path, data: body);
        break;

      case HttpMethod.put:
        await RemoteRequest.putData(path: endpoint.path, data: body);
        break;

      case HttpMethod.delete:
        await RemoteRequest.deleteData(path: endpoint.path, data: body);
        break;

      case HttpMethod.get:
        await RemoteRequest.getData(url: endpoint.path, query: data);
        break;
    }
  }
  /// مراقبة جدول المزامنة بالكامل (للاستخدام في UI/Debug).
  Stream<List<SyncQueueData>> watchQueue({
    String? entityType,
    int? entityId,
  }) {
    final q = db.select(db.syncQueue);
    if (entityType != null) {
      q.where((t) => t.entityType.equals(entityType));
    }
    if (entityId != null) {
      q.where((t) => t.entityId.equals(entityId));
    }
    q.orderBy([
      (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
    ]);
    return q.watch();
  }

  /// جلب آخر سجل لهذه العملية لمعرفة هل نجح (synced) أم فشل (failed) وما هو الخطأ.
  Future<SyncQueueData?> getLatestForEntity({
    required String entityType,
    required int entityId,
  }) {
    return (db.select(db.syncQueue)
          ..where((t) => t.entityType.equals(entityType))
          ..where((t) => t.entityId.equals(entityId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  bool isSynced(SyncQueueData row) =>
      row.status == SyncQueueStatus.synced || row.synced == true;

  bool isFailed(SyncQueueData row) => row.status == SyncQueueStatus.failed;
}

/// تمثيل بسيط لنوع الطلب HTTP الذي سيتم استخدامه في المزامنة.
enum HttpMethod { get, post, put, delete }

/// معلومات نقطة النهاية الخاصة بمزامنة كيان معيّن.
///
/// هذا الكلاس يجعل [SyncService] عامة وقابلة لإعادة الاستخدام مع أي كيان.
class EntitySyncEndpoint {
  final String path; // مثال: '/leagues', '/teams/{id}' ...
  final HttpMethod method;

  const EntitySyncEndpoint({
    required this.path,
    required this.method,
  });
}

class _RetryDecision {
  final String status;
  final int nextAttemptCount;
  final String message;
  final Duration? recommendedWait;

  const _RetryDecision({
    required this.status,
    required this.nextAttemptCount,
    required this.message,
    this.recommendedWait,
  });

  factory _RetryDecision.pending({
    required int nextAttemptCount,
    required int maxAttempts,
    required String message,
    Duration? recommendedWait,
  }) {
    final st = nextAttemptCount >= maxAttempts
        ? SyncQueueStatus.failed
        : SyncQueueStatus.pending;
    return _RetryDecision(
      status: st,
      nextAttemptCount: nextAttemptCount,
      message: message,
      recommendedWait: recommendedWait,
    );
  }

  factory _RetryDecision.failed({
    required int nextAttemptCount,
    required String message,
  }) {
    return _RetryDecision(
      status: SyncQueueStatus.failed,
      nextAttemptCount: nextAttemptCount,
      message: message,
    );
  }
}
