import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/core/network/remote_request.dart';

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

  /// إضافة عملية إلى جدول المزامنة.
  ///
  /// [entityType] مثال: 'league', 'team', 'player'...
  /// [entityId] هو الـ id المحلي في قاعدة البيانات.
  /// [operation] أحد القيم: create / update / delete.
  /// [payload] هو البيانات التي سيتم إرسالها للخادم على شكل JSON.
  Future<int> enqueueOperation({
    required String entityType,
    required int entityId,
    required String operation,
    required Map<String, dynamic> payload,
  }) async {
    return await db.into(db.syncQueue).insert(
          SyncQueueCompanion.insert(
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: jsonEncode(payload),
          ),
        );
  }

  /// استرجاع كل العمليات غير المزامنة مرتبة حسب تاريخ الإنشاء.
  Future<List<SyncQueueData>> getPendingOperations() {
    return (db.select(db.syncQueue)
          ..where((tbl) => tbl.synced.equals(false))
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.asc),
          ]))
        .get();
  }

  /// تنفيذ كل العمليات غير المزامنة.
  ///
  /// [entityEndpointResolver] دالة مسؤولة عن تحويل [entityType]
  /// إلى معلومات الاستدعاء البعيد (مسار الـ API وطريقة الطلب).
  /// بهذه الطريقة، تبقى [SyncService] عامة وغير مرتبطة بنقاط نهاية محددة.
  Future<void> syncPendingOperations({
    required Future<EntitySyncEndpoint> Function(
            String entityType, String operation)
        entityEndpointResolver,
  }) async {
    final pending = await getPendingOperations();

    for (final item in pending) {
      try {
        final endpoint =
            await entityEndpointResolver(item.entityType, item.operation);

        final Map<String, dynamic> data =
            jsonDecode(item.payload) as Map<String, dynamic>;

        await _sendToRemote(
          endpoint: endpoint,
          data: data,
        );

        // عند النجاح نحدّث حالة السجل إلى synced = true
        await (db.update(db.syncQueue)..where((tbl) => tbl.id.equals(item.id)))
            .write(const SyncQueueCompanion(synced: Value(true)));
      } catch (e) {
        // في حال الفشل لا نحذف السجل، ليتم إعادة المحاولة لاحقاً
        // يمكن لاحقاً إضافة منطق لعدد محاولات محدد أو تخزين رسالة الخطأ.
      }
    }
  }

  /// إرسال البيانات إلى الخادم حسب نوع العملية (create / update / delete)
  Future<void> _sendToRemote({
    required EntitySyncEndpoint endpoint,
    required Map<String, dynamic> data,
  }) async {
    switch (endpoint.method) {
      case HttpMethod.post:
        await RemoteRequest.postData(path: endpoint.path, data: data);
        break;
      case HttpMethod.put:
        await RemoteRequest.putData(path: endpoint.path, data: data);
        break;
      case HttpMethod.delete:
        await RemoteRequest.deleteData(path: endpoint.path, data: data);
        break;
      case HttpMethod.get:
        await RemoteRequest.getData(url: endpoint.path, query: data);
        break;
    }
  }
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
