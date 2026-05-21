import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'notification_keys.dart';
import 'notification_channels.dart';
import 'package:firebase_messaging/firebase_messaging.dart' show RemoteMessage;

class AwesomeNotificationService {
  AwesomeNotificationService._();

  static final AwesomeNotificationService I = AwesomeNotificationService._();
  static const Duration _recentRemoteWindow = Duration(minutes: 2);
  static const Set<String> _silentRemoteTypes = <String>{
    'unread_count',
  };

  bool _initialized = false;
  final Map<String, DateTime> _recentRemoteKeys = <String, DateTime>{};

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

  static String? _normalizedText(dynamic value) {
    final normalized = value?.toString().trim() ?? '';
    return normalized.isEmpty ? null : normalized;
  }

  @visibleForTesting
  static String? resolveRemoteTitle(RemoteMessage message) {
    return _normalizedText(message.notification?.title) ??
        _normalizedText(message.data['title']) ??
        _normalizedText(message.data['notification_title']) ??
        _normalizedText(message.data['main_title']) ??
        _normalizedText(message.data['subject']);
  }

  @visibleForTesting
  static String? resolveRemoteBody(RemoteMessage message) {
    return _normalizedText(message.notification?.body) ??
        _normalizedText(message.data['body']) ??
        _normalizedText(message.data['message']) ??
        _normalizedText(message.data['content']) ??
        _normalizedText(message.data['description']);
  }

  @visibleForTesting
  static bool shouldDisplayRemoteMessage(RemoteMessage message) {
    final title = resolveRemoteTitle(message);
    final body = resolveRemoteBody(message);
    final hasVisibleText = title != null || body != null;
    final type = _normalizedText(message.data['type'])?.toLowerCase();
    final silentFlag = _normalizedText(message.data['silent'])?.toLowerCase();
    final isSilent = silentFlag == '1' ||
        silentFlag == 'true' ||
        silentFlag == 'yes' ||
        (_silentRemoteTypes.contains(type) && !hasVisibleText);

    return !isSilent && hasVisibleText;
  }

  @visibleForTesting
  static int notificationIdForRemote(RemoteMessage message) {
    final stableSource = _normalizedText(message.messageId) ??
        _normalizedText(message.data['notification_id']) ??
        _normalizedText(message.data['id']) ??
        _normalizedText(message.data['sync_id']) ??
        '${resolveRemoteTitle(message) ?? ''}|${resolveRemoteBody(message) ?? ''}|${message.sentTime?.millisecondsSinceEpoch ?? ''}|${message.data}';

    return stableSource.hashCode & 0x7fffffff;
  }

  String _remoteDedupKey(RemoteMessage message) {
    return _normalizedText(message.messageId) ??
        _normalizedText(message.data['notification_id']) ??
        _normalizedText(message.data['id']) ??
        _normalizedText(message.data['sync_id']) ??
        '${notificationIdForRemote(message)}';
  }

  bool _shouldSkipRecentlyHandledRemote(RemoteMessage message) {
    final now = DateTime.now();
    _recentRemoteKeys.removeWhere(
      (_, handledAt) => now.difference(handledAt) > _recentRemoteWindow,
    );

    final key = _remoteDedupKey(message);
    final lastHandledAt = _recentRemoteKeys[key];
    if (lastHandledAt != null &&
        now.difference(lastHandledAt) <= _recentRemoteWindow) {
      return true;
    }

    _recentRemoteKeys[key] = now;
    return false;
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
    if (!shouldDisplayRemoteMessage(message)) {
      if (kDebugMode) {
        print('[FCM] Skipping silent/empty remote message: ${message.messageId}');
      }
      return;
    }

    if (_shouldSkipRecentlyHandledRemote(message)) {
      if (kDebugMode) {
        print('[FCM] Skipping duplicate remote message: ${message.messageId}');
      }
      return;
    }

    if (kDebugMode) {
      print('[FCM] Background Message Received!');
      print('[FCM] Message Title: ${resolveRemoteTitle(message)}');
      print('[FCM] Message Body: ${resolveRemoteBody(message)}');
      print('[FCM] Message Data: ${message.messageId}');
    }
    final title = resolveRemoteTitle(message)!;
    final body = resolveRemoteBody(message) ?? '';
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
      id: notificationIdForRemote(message),
    );
  }
}
