import 'package:firebase_core/firebase_core.dart';
import 'awesome_notification_service.dart';
import 'firebase_messaging_service.dart';

class NotificationBootstrap {
  NotificationBootstrap._();
  static final NotificationBootstrap I = NotificationBootstrap._();

  bool _bootstrapped = false;

  Future<void> init({bool debug = true}) async {
    if (_bootstrapped) return;

    // Firebase أولاً
    await Firebase.initializeApp();

    // Awesome Notifications (القنوات)
    await AwesomeNotificationService.I.initialize(debug: debug);

    // Firebase Messaging (الاستماعات)
    await FirebaseMessagingService.I.configure();

    _bootstrapped = true;
  }
}
