import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// Navigation Observer that records all screen movements as Breadcrumbs in Crashlytics
class FirebaseMonitoringNavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logRoute(route, 'Opened Screen');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) _logRoute(newRoute, 'Replaced Screen');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) _logRoute(previousRoute, 'Returned Back to');
  }

  void _logRoute(Route<dynamic> route, String action) {
    final name = route.settings.name ?? route.runtimeType.toString();
    FirebaseMonitoringService.setCurrentScreen(name);
    FirebaseMonitoringService.log('📍 [$action]: $name');
  }
}

/// Custom Exception representing UI Lag / Freezing events
class AppLagException implements Exception {
  final String screenName;
  final String action;
  final int durationMs;
  final String reason;

  AppLagException({
    required this.screenName,
    required this.action,
    required this.durationMs,
    required this.reason,
  });

  @override
  String toString() =>
      'AppLagException: [$screenName] $action (${durationMs}ms) - $reason';
}

/// Professional APM and Crash Tracking Service using Firebase.
/// Fully integrated with Google's zero-downtime, unblocked global infrastructure.
class FirebaseMonitoringService {
  FirebaseMonitoringService._();

  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  static final FirebasePerformance _performance = FirebasePerformance.instance;

  static final NavigatorObserver navigationObserver =
      FirebaseMonitoringNavigationObserver();

  static String currentScreen = 'AppStartup';
  static DateTime _lastLagReport = DateTime.fromMillisecondsSinceEpoch(0);

  /// Set the currently active screen for accurate context in lag and crash reports
  static void setCurrentScreen(String screenName) {
    currentScreen = screenName;
    try {
      _crashlytics.setCustomKey('current_screen', screenName);
    } catch (_) {}
  }

  /// Initialize Firebase Crashlytics & Performance monitoring.
  static Future<void> init() async {
    try {
      // 1. Configure Crashlytics collection
      // Always enabled in release, and enabled in debug for testing if desired
      await _crashlytics.setCrashlyticsCollectionEnabled(true);

      // 2. Catch all synchronous & widget tree Flutter errors
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.dumpErrorToConsole(details);
        _crashlytics.recordFlutterFatalError(details);
      };

      // 3. Catch all asynchronous / platform dispatcher errors
      PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
        _crashlytics.recordError(error, stack, fatal: true);
        return true;
      };

      // 4. Set initial guest metadata
      await _crashlytics.setCustomKey('is_logged_in', false);
      await _crashlytics.setCustomKey('user_type', 'guest');
      await _crashlytics.setCustomKey('current_screen', currentScreen);

      // 5. Enable Firebase Performance automatic screen & network tracing
      await _performance.setPerformanceCollectionEnabled(true);

      // 6. Monitor Frozen Frames (>700ms) automatically across the app
      SchedulerBinding.instance.addTimingsCallback((List<FrameTiming> timings) {
        for (final timing in timings) {
          final totalMs = timing.totalSpan.inMilliseconds;
          // 700ms is the standard Android/Google threshold for a "Frozen Frame"
          if (totalMs >= 700) {
            reportLag(
              screenName: currentScreen,
              action: 'UI Frame Freeze (Frozen Frame)',
              durationMs: totalMs,
              reason:
                  'Frame rendering was blocked for ${totalMs}ms (Build: ${timing.buildDuration.inMilliseconds}ms, Raster: ${timing.rasterDuration.inMilliseconds}ms)',
              stackTrace: StackTrace.current,
            );
          }
        }
      });

      if (kDebugMode) {
        debugPrint(
          '🔥 [FirebaseMonitoringService]: Crashlytics, Performance & Lag Detector initialized successfully.',
        );
      }
    } catch (e, stack) {
      debugPrint('⚠️ [FirebaseMonitoringService] Init failed: $e\n$stack');
    }
  }

  /// Explicitly report a UI lag or slow execution to Crashlytics
  /// with exact file, code line (stackTrace), user identity, and duration.
  static Future<void> reportLag({
    required String screenName,
    required String action,
    required int durationMs,
    required String reason,
    StackTrace? stackTrace,
  }) async {
    try {
      final now = DateTime.now();
      // Throttle: avoid spamming multiple alerts in rapid succession (minimum 10s between reports)
      if (now.difference(_lastLagReport).inSeconds < 10) return;
      _lastLagReport = now;

      await _crashlytics.setCustomKey('lag_screen', screenName);
      await _crashlytics.setCustomKey('lag_action', action);
      await _crashlytics.setCustomKey('lag_duration_ms', durationMs);
      await _crashlytics.setCustomKey('lag_reason', reason);

      final exception = AppLagException(
        screenName: screenName,
        action: action,
        durationMs: durationMs,
        reason: reason,
      );

      await _crashlytics.recordError(
        exception,
        stackTrace ?? StackTrace.current,
        reason: '[Lag Alert] $screenName - $action (${durationMs}ms)',
        fatal: false,
      );

      if (kDebugMode) {
        debugPrint('⚠️ [Lag Alert Dispatched to Firebase]: $exception');
      }
    } catch (_) {}
  }

  /// Associate crashes and performance metrics with a specific user.
  static Future<void> setUser({
    required String id,
    String? name,
    String? phone,
  }) async {
    try {
      await _crashlytics.setUserIdentifier(id);
      await _crashlytics.setCustomKey('is_logged_in', true);
      await _crashlytics.setCustomKey('user_type', 'registered');
      if (name != null && name.isNotEmpty) {
        await _crashlytics.setCustomKey('user_name', name);
      }
      if (phone != null && phone.isNotEmpty) {
        await _crashlytics.setCustomKey('user_phone', phone);
      }
    } catch (_) {}
  }

  /// Clear user identification upon logout.
  static Future<void> clearUser() async {
    try {
      await _crashlytics.setUserIdentifier('');
      await _crashlytics.setCustomKey('is_logged_in', false);
      await _crashlytics.setCustomKey('user_type', 'guest');
      await _crashlytics.setCustomKey('user_name', 'Guest');
      await _crashlytics.setCustomKey('user_phone', '');
    } catch (_) {}
  }

  /// Add a breadcrumb log to the user's session timeline.
  static void log(String message) {
    _crashlytics.log(message);
  }

  /// Record a non-fatal caught exception manually.
  static Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    await _crashlytics.recordError(
      exception,
      stack,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Measure the duration of any custom operation in Firebase Performance.
  static Future<T> measureAsync<T>(
    String traceName,
    Future<T> Function() action,
  ) async {
    final trace = _performance.newTrace(traceName);
    await trace.start();
    try {
      return await action();
    } finally {
      await trace.stop();
    }
  }

  /// Send a test non-fatal crash to verify Firebase Crashlytics dashboard connectivity.
  static Future<void> testCrashReporting() async {
    try {
      throw StateError('اختبار فايربيس التجريبي: تم الاتصال بنجاح من تطبيق سافرة!');
    } catch (exception, stack) {
      debugPrint('📤 [FirebaseMonitoringService]: Dispatching test error to Crashlytics...');
      await _crashlytics.recordError(
        exception,
        stack,
        reason: 'Firebase Setup Verification',
        fatal: false,
      );
      debugPrint('✅ [FirebaseMonitoringService]: Test error dispatched to Firebase successfully!');
    }
  }
}
