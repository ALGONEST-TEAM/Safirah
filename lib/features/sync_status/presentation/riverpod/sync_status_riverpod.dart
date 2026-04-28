import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/core/database/sync_service.dart';
import 'package:safirah/core/database/sync_trigger.dart';
import 'package:safirah/injection.dart' as di;

final syncStatusQueueProvider = StreamProvider<List<SyncQueueData>>((ref) {
  final service = di.sl<SyncService>();
  return service.watchActionableQueue();
});

final syncStatusActionsProvider = Provider<SyncStatusActions>((ref) {
  return SyncStatusActions(
    service: di.sl<SyncService>(),
    trigger: di.sl<SyncTrigger>(),
  );
});

class SyncStatusActions {
  final SyncService service;
  final SyncTrigger trigger;

  const SyncStatusActions({
    required this.service,
    required this.trigger,
  });

  Future<bool> retryOne(int id) async {
    final updated = await service.retryFailedOperation(id);
    if (updated) {
      await trigger.syncIfOnline(throwOnFirstError: false);
    }
    return updated;
  }

  Future<int> retryAll() async {
    final updated = await service.retryAllFailedOperations();
    if (updated > 0) {
      await trigger.syncIfOnline(throwOnFirstError: false);
    }
    return updated;
  }

  Future<void> syncNow() {
    return trigger.syncIfOnline(throwOnFirstError: false);
  }
}

