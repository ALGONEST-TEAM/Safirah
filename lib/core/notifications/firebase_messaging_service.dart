// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'awesome_notification_service.dart';
//
// /// لازم يكون Top-Level و عليه @pragma حتى يشتغل بالخلفية.
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   if (message.notification == null) {
//     await AwesomeNotificationService.I.showFromRemote(message);
//   }
// }
//
// class FirebaseMessagingService {
//   VoidCallback? onRefreshUnread;
//   void Function(int count)? onSetUnread;
//
//   FirebaseMessagingService._();
//
//   static final FirebaseMessagingService I = FirebaseMessagingService._();
//
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   bool _configured = false;
//
//   Future<String?> getDeviceToken() async {
//     try {
//       return _messaging.getToken();
//     } catch (e) {
//       if (kDebugMode) print('[FCM] getToken error: $e');
//       return null;
//     }
//   }
//
//   Future<void> configure() async {
//     if (_configured) return;
//
//     // أذونات iOS + Android 13
//     await _messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//
//     if (Platform.isIOS) {
//       await FirebaseMessaging.instance
//           .setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//     }
//
//     // Background handler
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       if (kDebugMode) {
//         print('[FCM] onMessageOpenedApp: ${message.data}');
//       }
//     });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       await AwesomeNotificationService.I.showFromRemote(message);
//       _touchUnread(message);
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       _touchUnread(message);
//     });
//     _configured = true;
//   }
//
//   void _touchUnread(RemoteMessage m) {
//     final type = m.data['type'];
//     if (type == 'unread_count' && m.data['unread'] != null) {
//       final c = int.tryParse('${m.data['unread']}') ?? 0;
//       onSetUnread?.call(c);
//     } else {
//       onRefreshUnread?.call();
//     }
//   }
// }
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
        // في نظام iOS، يجب الحصول على APNS token أولاً
        String? apnsToken = await _messaging.getAPNSToken();

        // إذا كنت على المحاكي، توكن APNS سيكون دائماً null
        // سنحاول الانتظار قليلاً فقط في حالة الجهاز الحقيقي
        int retryCount = 0;
        while (apnsToken == null && retryCount < 2) {
          await Future.delayed(const Duration(seconds: 2));
          apnsToken = await _messaging.getAPNSToken();
          retryCount++;
        }

        if (apnsToken == null) {
          if (kDebugMode) {
            print('[FCM] APNS Token is null. Skipping getToken to avoid error.');
            print('[FCM] Note: FCM doesn\'t support notifications on iOS Simulators.');
          }
          return null; // نرجع null بهدوء دون استدعاء getToken الذي يسبب الخطأ
        }
      }

      // إذا وصلنا هنا (أندرويد أو iOS مع توكن APNS جاهز)
      return await _messaging.getToken();
    } catch (e) {
      if (kDebugMode) print('[FCM] getToken exception: $e');
      return null;
    }
  }

  Future<void> configure() async {
    if (_configured) return;

    // طلب الأذونات
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await AwesomeNotificationService.I.showFromRemote(message);
      _touchUnread(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _touchUnread(message);
    });
    _configured = true;
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
