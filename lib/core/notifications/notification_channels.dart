import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'notification_keys.dart';

class NotificationChannels {
  static List<NotificationChannel> channels = [
    NotificationChannel(
      channelKey: NotifKeys.highChannel,
      channelName: 'High Importance',
      channelDescription: 'Alerts and important updates',
      importance: NotificationImportance.Max,
      channelShowBadge: true,
      playSound: true,
      criticalAlerts: true,
      defaultColor: const Color(0xFF9D50DD),
      ledColor: Colors.white,
    ),
  ];

  static List<NotificationChannelGroup> groups = [
    NotificationChannelGroup(
      channelGroupKey: NotifKeys.generalGroup,
      channelGroupName: 'General',
    ),
  ];
}
