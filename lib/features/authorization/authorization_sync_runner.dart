import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:safirah/core/network/connectivity_service.dart';
import 'package:safirah/features/authorization/authorization_service.dart';

class AuthorizationSyncRunner {
  AuthorizationSyncRunner({
    required ConnectivityService connectivity,
    required AuthorizationService service,
    this.debounce = const Duration(milliseconds: 800),
  })  : _connectivity = connectivity,
        _service = service;

  final ConnectivityService _connectivity;
  final AuthorizationService _service;
  final Duration debounce;

  StreamSubscription<bool>? _sub;
  Timer? _debounceTimer;
  bool _started = false;

  Future<void> _runSync(String tag) async {
    try {
      if (!await _connectivity.isOnline()) return;

      final r = await _service.syncUserAccessForAllLeagues();
      r.fold(
            (e) {
          if (kDebugMode) {
            // ignore: avoid_print
            print('[AuthorizationSyncRunner] $tag sync error: $e');
          }
        },
            (_) {
          if (kDebugMode) {
            // ignore: avoid_print
            print('[AuthorizationSyncRunner] $tag sync success');
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('[AuthorizationSyncRunner] $tag sync exception: $e');
      }
    }
  }

  void _debouncedSync(String tag) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(debounce, () async {
      await _runSync(tag);
    });
  }

  /// ✅ استدعِها عند فتح صفحة تفاصيل الدوري
  /// - تعمل debounced
  /// - تتحقق من الانترنت
  Future<void> syncNow({String tag = 'details_open'}) async {
    // لو تحب مباشرة بدون debounce:
    // await _runSync(tag);

    // أو الأفضل: debounce (حتى لا تتكرر كثيراً)
    _debouncedSync(tag);
  }

  Future<void> start() async {
    if (_started) return;
    _started = true;

    // 1) عند التشغيل
    await _runSync('initial');

    // 2) عند رجوع النت
    _sub = _connectivity.onOnline.listen((_) {
      _debouncedSync('onOnline');
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
