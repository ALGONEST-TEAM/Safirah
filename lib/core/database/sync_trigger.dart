import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../network/connectivity_service.dart';
import 'sync_orchestrator.dart';

class SyncTrigger {
  SyncTrigger({
    required ConnectivityService connectivity,
    required SyncOrchestrator orchestrator,
  })  : _connectivity = connectivity,
        _orchestrator = orchestrator;

  final ConnectivityService _connectivity;
  final SyncOrchestrator _orchestrator;

  bool _running = false;

  /// await version (blocking)
  Future<void> syncIfOnline({bool throwOnFirstError = true}) async {
    if (_running) return;
    _running = true;
    try {
      if (await _connectivity.isOnline()) {
        await _orchestrator.syncAll(throwOnFirstError: throwOnFirstError);
      }
    } finally {
      _running = false;
    }
  }

  /// non-blocking version (fire-and-forget)
  void syncIfOnlineInBackground({bool throwOnFirstError = false}) {
    if (_running) return;

    // schedule after current frame/microtask (يقلل jank)
    scheduleMicrotask(() async {
      if (_running) return;
      _running = true;

      try {
        if (await _connectivity.isOnline()) {
          await _orchestrator.syncAll(throwOnFirstError: throwOnFirstError);
        }
      } on DioException catch (e) {
        // لا نرمي الخطأ هنا حتى لا نكسر الـ UI
        if (kDebugMode) {
          // ignore: avoid_print
          print('[SyncTrigger] background sync DioException: ${e.message}');
        }
        // TODO: optional: send to a global error notifier
      } catch (e) {
        if (kDebugMode) {
          // ignore: avoid_print
          print('[SyncTrigger] background sync error: $e');
        }
      } finally {
        _running = false;
      }
    });
  }
}