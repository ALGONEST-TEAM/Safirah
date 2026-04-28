import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import '../helpers/flash_bar_helper.dart';
import 'safirah_database.dart';
import 'table/sync_queue_table.dart';

/// يراقب طابور المزامنة ويُظهر رسالة للمستخدم فقط عندما تصبح العملية FAILED:
/// - خطأ دائم (4xx/409) -> تُصبح failed حسب سياسة SyncService.
/// - أو تجاوزت maxAttempts.
///
/// ملاحظات:
/// - يُظهر التنبيه مرة واحدة فقط لكل row (حسب id) لتجنب الإزعاج.
/// - يعتمد على lastError + response في DioException إن توفرت.
class SyncFailedNotifier {
  SyncFailedNotifier({
    required Safirah db,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _db = db,
        _navigatorKey = navigatorKey;

  final Safirah _db;
  final GlobalKey<NavigatorState> _navigatorKey;

  StreamSubscription<List<SyncQueueData>>? _sub;
  final Set<int> _shown = <int>{};

  void start() {
    _sub ??= (_db.select(_db.syncQueue)
          ..where((t) => t.status.equals(SyncQueueStatus.failed))
          ..orderBy([
            (t) => OrderingTerm(expression: t.lastAttemptAt, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .watch()
        .listen(_onFailedRows);
  }

  void _onFailedRows(List<SyncQueueData> rows) {
    if (rows.isEmpty) return;

    final newlyFailed = <SyncQueueData>[];

    for (final row in rows) {
      if (_shown.contains(row.id)) continue;
      _shown.add(row.id);
      newlyFailed.add(row);

      // ✅ Rollback محلي (احترافي) لحالات فشل دائم
      _handleRollbackIfNeeded(row);
    }

    if (newlyFailed.isEmpty) return;

    final ctx = _navigatorKey.currentContext;
    if (ctx == null) return;

    final failedCount = newlyFailed.length;
    final sampleError = newlyFailed
        .map((e) => (e.lastError ?? '').trim())
        .firstWhere((e) => e.isNotEmpty, orElse: () => '');

    final title = failedCount == 1 ? 'تعذر رفع بعض البيانات' : 'توجد عمليات مزامنة تحتاج مراجعة';
    final text = sampleError.isNotEmpty && failedCount == 1
        ? '$sampleError\nيمكنك إعادة الإرسال من الإعدادات > حالة المزامنة.'
        : 'يوجد $failedCount من عمليات المزامنة التي تحتاج مراجعة. يمكنك إعادة الإرسال من الإعدادات > حالة المزامنة.';

    showFlashBarError(context: ctx, title: title, text: text);
  }

  Future<void> _handleRollbackIfNeeded(SyncQueueData row) async {
    // حالياً نطبق rollback فقط على invitations لأنها "قبول دعوة" ولا يصح أن تبقى محلياً إذا رفضها السيرفر.
    if (row.entityType != 'invitations') return;

    try {
      final decoded = jsonDecode(row.payload);
      if (decoded is! Map) return;

      final leaguePlayerSyncId = decoded['league_player_sync_id'];
      if (leaguePlayerSyncId is! String || leaguePlayerSyncId.trim().isEmpty) return;

      // حذف اللاعب المحلي الذي تم إضافته كتأثير جانبي
      await (_db.delete(_db.leaguePlayers)
            ..where((t) => t.syncId.equals(leaguePlayerSyncId)))
          .go();
    } catch (_) {
      // لا تقتل التدفق
    }
  }

  Future<void> dispose() async {
    await _sub?.cancel();
    _sub = null;
    _shown.clear();
  }
}
