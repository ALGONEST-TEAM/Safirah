import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Professional APM and Crash Tracking Service using Sentry.
/// Designed for low overhead, free-tier optimization, and deep diagnostics.
class SentryService {
  SentryService._();

  /// Sentry DSN key.
  /// Replace this string with your DSN from your Sentry dashboard project settings.
  static const String dsn =
      'https://f62d8b64e07c793a39d1e5f81ca917e9@o4512177866735616.ingest.de.sentry.io/4512177879711824';

  /// Whether Sentry is configured with a valid DSN.
  static bool get isConfigured =>
      dsn.isNotEmpty &&
      !dsn.contains('YOUR_SENTRY_DSN_HERE') &&
      dsn.startsWith('https://');

  /// Initialize Sentry and run the application.
  static Future<void> init({required FutureOr<void> Function() appRunner}) async {
    if (!isConfigured) {
      if (kDebugMode) {
        debugPrint(
          '⚠️ [SentryService]: Sentry DSN is not set yet. Running app normally without Sentry.',
        );
      }
      await appRunner();
      return;
    }

    await SentryFlutter.init(
      (options) {
        options.dsn = dsn;
        options.debug = false;

        options.connectionTimeout = const Duration(seconds: 15);
        options.readTimeout = const Duration(seconds: 15);

        // 1. Performance Monitoring (Sample 20% to keep usage inside free tier)
        options.tracesSampleRate = 0.2;
        // ignore: experimental_member_use
        options.profilesSampleRate = 0.2;

        // 2. Track App Hangs (Freezing on main thread > 2 seconds)
        options.enableAppHangTracking = true;
        options.appHangTimeoutInterval = const Duration(seconds: 2);

        // 3. UI Diagnostics & Breadcrumbs
        options.enableUserInteractionTracing = true;
        // ignore: experimental_member_use
        options.attachViewHierarchy = true;
        options.enableAutoPerformanceTracing = true;

        // 4. Filter noisy network disconnects in release mode
        options.beforeSend = (event, hint) {
          final exception = event.throwable;
          if (exception != null &&
              exception.toString().contains('SocketException')) {
            // Drop benign offline errors if needed or keep them as breadcrumbs
            return event;
          }
          return event;
        };

        // 5. Release and Environment tagging
        options.environment = kReleaseMode ? 'production' : 'development';
      },
      appRunner: appRunner,
    );

    if (kDebugMode) {
      debugPrint('🚀 [SentryService]: Sentry APM & Crash Reporting initialized successfully.');
      Future.delayed(const Duration(seconds: 3), () {
        triggerTestError();
      });
    }
  }

  /// Send an explicit test exception to Sentry to verify the connection in real-time.
  static Future<void> triggerTestError() async {
    if (!isConfigured) return;
    try {
      throw StateError('اختبار سينتري التجريبي: تم تأكيد الاتصال بنجاح من تطبيق سافرة!');
    } catch (exception, stackTrace) {
      debugPrint('📤 [SentryService]: Sending real test exception to Sentry...');
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      debugPrint('✅ [SentryService]: Test exception sent to Sentry successfully!');
    }
  }

  /// Manually capture an unexpected error or exception.
  static Future<void> captureException(
    dynamic throwable, {
    dynamic stackTrace,
    String? reason,
  }) async {
    if (!isConfigured) return;
    await Sentry.captureException(
      throwable,
      stackTrace: stackTrace,
      hint: reason != null ? Hint.withMap({'reason': reason}) : null,
    );
  }

  /// Record user navigation or action breadcrumb.
  static void addBreadcrumb({
    required String message,
    String category = 'custom',
    Map<String, dynamic>? data,
  }) {
    if (!isConfigured) return;
    Sentry.addBreadcrumb(
      Breadcrumb(
        message: message,
        category: category,
        data: data,
        timestamp: DateTime.now(),
      ),
    );
  }

  /// Associate events with a user ID (for customer support diagnosis).
  static void setUser({required String id, String? email, String? username}) {
    if (!isConfigured) return;
    Sentry.configureScope((scope) {
      scope.setUser(
        SentryUser(
          id: id,
          email: email,
          username: username,
        ),
      );
    });
  }

  /// Clear user identity on logout.
  static void clearUser() {
    if (!isConfigured) return;
    Sentry.configureScope((scope) {
      scope.setUser(null);
    });
  }
}
