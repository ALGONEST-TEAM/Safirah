import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'notification_keys.dart';
import 'notification_channels.dart';
import 'package:firebase_messaging/firebase_messaging.dart' show RemoteMessage;

class AwesomeNotificationService {
  AwesomeNotificationService._();

  static final AwesomeNotificationService I = AwesomeNotificationService._();

  bool _initialized = false;

  Future<void> initialize({bool debug = kDebugMode}) async {
    if (_initialized) return;
    await AwesomeNotifications().initialize(
      null,
      NotificationChannels.channels,
      channelGroups: NotificationChannels.groups,
      debug: debug,

    );
    _initialized = true;
  }

  Future<bool> ensurePermission() async {
    final allowed = await AwesomeNotifications().isNotificationAllowed();
    if (!allowed) {
      return AwesomeNotifications().requestPermissionToSendNotifications();
    }
    return true;
  }

  int generateId() {
    final now = DateTime.now().microsecondsSinceEpoch;
    return now & 0x7fffffff;
  }

  String? _extractRemoteImage(RemoteMessage message) {
    final androidImage = message.notification?.android?.imageUrl;
    if (androidImage != null && androidImage.isNotEmpty) {
      return androidImage;
    }

    final appleImage = message.notification?.apple?.imageUrl;
    if (appleImage != null && appleImage.isNotEmpty) {
      return appleImage;
    }

    final rawImage =
        message.data['imageUrl'] ?? message.data['image'] ?? message.data['bigPicture'];
    if (rawImage == null) return null;

    final normalized = rawImage.trim();
    return normalized.isEmpty ? null : normalized;
  }

  Future<void> show({
    required String title,
    required String body,
    String channelKey = NotifKeys.highChannel,
    String? summary,
    Map<String, String>? payload,
    NotificationLayout layout = NotificationLayout.BigPicture,
    NotificationCategory? category,
    String? bigPicture,
    bool displayOnForeground = true,
    bool displayOnBackground = true,
    String? largeIcon,
    bool wakeUpScreen = true,
    int? id,
  }) async {
    final granted = await ensurePermission();
    if (!granted) {
      if (kDebugMode) print('[AwesomeNotif] Permission denied by user.');
      return;
    }

    final effectiveLayout =
    (bigPicture != null && bigPicture.trim().isNotEmpty)
        ? layout
        : NotificationLayout.Default;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id ?? generateId(),
        channelKey: channelKey,
        title: title,
        body: body,
        summary: summary,
        largeIcon: largeIcon,
        payload: payload,
        notificationLayout: effectiveLayout,
        bigPicture: bigPicture,
        displayOnBackground: displayOnBackground,
        displayOnForeground: displayOnForeground,
        wakeUpScreen: wakeUpScreen,
        category: category,
      ),
    );
  }



  Future<void> showFromRemote(
      RemoteMessage message, {
        String channelKey = NotifKeys.highChannel,
      }) async {
    if (kDebugMode) {
      print('[FCM] Background Message Received!');
      print('[FCM] Message Title: ${message.notification?.title}');
      print('[FCM] Message Body: ${message.notification?.body}');
      print('[FCM] Message Data: ${message.messageId}');
    }
    final title = message.notification?.title ?? 'إشعار';
    final body = message.notification?.body ?? '';
    final image = _extractRemoteImage(message);

    await show(
      title: title,
      body: body,
      channelKey: channelKey,
      payload: (message.data.isNotEmpty)
          ? message.data.map((k, v) => MapEntry(k, '$v'))
          : null,
      layout: image != null ? NotificationLayout.BigPicture : NotificationLayout.Default,
      bigPicture: image,
    );
  }
}
