import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'awesome_notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification == null) {
    await AwesomeNotificationService.I.showFromRemote(message);
  }
}

class FirebaseMessagingService {
  VoidCallback? onRefreshUnread;
  void Function(int count)? onSetUnread;

  FirebaseMessagingService._();

  static final FirebaseMessagingService I = FirebaseMessagingService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  bool _configured = false;

  Future<String?> getDeviceToken() async {
    try {
      if (Platform.isIOS) {
        // ننتظر ثانية واحدة للتأكد من استقرار تهيئة Firebase
        await Future.delayed(const Duration(seconds: 1));

        String? apnsToken = await _messaging.getAPNSToken();

        // محاولات متكررة في حال كان الجهاز حقيقي ولكنه يحتاج وقتاً للاتصال بخوادم آبل
        int retryCount = 0;
        while (apnsToken == null && retryCount < 10) {
          if (kDebugMode) print('[FCM] APNS Token is null, retrying ($retryCount/10)...');
          await Future.delayed(const Duration(seconds: 2));
          apnsToken = await _messaging.getAPNSToken();
          retryCount++;
        }

        if (apnsToken == null) {
          if (kDebugMode) {
            print('[FCM] Error: APNS Token is still null. Please check Xcode Capabilities (Push Notifications & Background Modes).');
          }
          // في بعض الحالات، قد يعمل getToken حتى لو كان APNS null (اعتماداً على إصدار Firebase)
          return await _messaging.getToken();
        }
      }

      return await _messaging.getToken();
    } catch (e) {
      if (kDebugMode) print('[FCM] getToken exception: $e');
      return null;
    }
  }

  Future<void> configure() async {
    if (_configured) return;

    // طلب الأذونات
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (kDebugMode) {
      print('[FCM] User granted permission: ${settings.authorizationStatus}');
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final shouldShowLocalNotification =
          !Platform.isIOS || message.notification == null;

      if (shouldShowLocalNotification) {
        await AwesomeNotificationService.I.showFromRemote(message);
      }
      _touchUnread(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _touchUnread(message);
    });

    _configured = true;

    unawaited(_finishDeferredConfiguration());
  }

  Future<void> _finishDeferredConfiguration() async {
    if (Platform.isIOS) {
      try {
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        ).timeout(const Duration(seconds: 5));
      } catch (e) {
        if (kDebugMode) {
          print('[FCM] Foreground presentation setup skipped: $e');
        }
      }
    }

    try {
      final initialMessage = await _messaging
          .getInitialMessage()
          .timeout(const Duration(seconds: 5));
      if (initialMessage != null) {
        _touchUnread(initialMessage);
      }
    } catch (e) {
      if (kDebugMode) {
        print('[FCM] Initial message fetch skipped: $e');
      }
    }
  }

  void _touchUnread(RemoteMessage m) {
    final type = m.data['type'];
    if (type == 'unread_count' && m.data['unread'] != null) {
      final c = int.tryParse('${m.data['unread']}') ?? 0;
      onSetUnread?.call(c);
    } else {
      onRefreshUnread?.call();
    }
  }
}
