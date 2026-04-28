import 'dart:async';

import 'package:flutter/foundation.dart';

import '../network/connectivity_service.dart';
import 'sync_orchestrator.dart';

/// يشغّل المزامنة تلقائياً:
/// 1) مرة عند التشغيل إذا كان النت متاح.
/// 2) فور رجوع النت أثناء بقاء المستخدم داخل التطبيق.
///
/// مزايا هذا الأسلوب:
/// - كود أنظف (main.dart ما يحمل منطق مزامنة).
/// - Single-flight: لن يشغل مزامنتين بالتوازي.
/// - Debounce بسيط يمنع تكرار syncAll بسبب تذبذب الشبكة.
class SyncAutoRunner {
  SyncAutoRunner({
    required ConnectivityService connectivity,
    required SyncOrchestrator orchestrator,
    this.debounce = const Duration(milliseconds: 800),
  })  : _connectivity = connectivity,
        _orchestrator = orchestrator;

  final ConnectivityService _connectivity;
  final SyncOrchestrator _orchestrator;
  final Duration debounce;

  StreamSubscription<bool>? _sub;
  Timer? _debounceTimer;
  bool _started = false;

  Future<void> start() async {
    if (_started) return;
    _started = true;

    // 1) عند التشغيل: استرجاع أي صفوف قديمة عالقة بسبب crash / force close.
    try {
      await _orchestrator.recoverStaleQueue();
      await _orchestrator.resolveBenignFailedQueue();
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('[SyncAutoRunner] stale queue recovery error: $e');
      }
    }

    // 2) عند التشغيل: مزامنة مرة واحدة إذا كان النت متاح
    try {
      if (await _connectivity.isOnline()) {
        await _orchestrator.syncAll();
      }
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('[SyncAutoRunner] initial sync error: $e');
      }
    }

    // 3) عند رجوع النت: مزامنة فورية (مع debounce)
    _sub = _connectivity.onOnline.listen((_) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(debounce, () async {
        try {
          await _orchestrator.syncAll();
        } catch (e) {
          if (kDebugMode) {
            // ignore: avoid_print
            print('[SyncAutoRunner] onOnline sync error: $e');
          }
        }
      });
    });
  }

  Future<void> dispose() async {
    _debounceTimer?.cancel();
    _debounceTimer = null;
    await _sub?.cancel();
    _sub = null;
    _started = false;
  }
}

