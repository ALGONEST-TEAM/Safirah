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
      null, // أو ضع أيقونة: 'resource://drawable/ic_stat_notification'
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

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id ?? generateId(),
        channelKey: channelKey,
        title: title,
        body: body,
        summary: summary,
        largeIcon: largeIcon,
        payload: payload,
        notificationLayout: layout,
        bigPicture: bigPicture,
        displayOnBackground: displayOnBackground,
        displayOnForeground: displayOnForeground,
        wakeUpScreen: wakeUpScreen,
        fullScreenIntent: true,
        criticalAlert: true

      ),
    );
  }



  Future<void> showFromRemote(
    RemoteMessage message, {
    String channelKey = NotifKeys.highChannel,
  }) async {
    final title = message.notification?.title ?? 'إشعار';
    final body = message.notification?.body ?? '';

    await show(
      title: title,
      body: body,
      channelKey: channelKey,
      payload: (message.data.isNotEmpty)
          ? message.data.map((k, v) => MapEntry(k, '$v'))
          : null,
      bigPicture: message.notification!.android!.imageUrl,
    );
  }
}
