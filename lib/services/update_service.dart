import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';

class GooglePlayUpdateService {
  GooglePlayUpdateService._();

  static bool _isChecking = false;

  static Future<void> checkForUpdate() async {
    if (!Platform.isAndroid) return;

    if (_isChecking) return;
    _isChecking = true;

    try {
      final AppUpdateInfo info = await InAppUpdate.checkForUpdate();

      debugPrint('Google Play updateAvailability: ${info.updateAvailability}');
      debugPrint('Google Play immediateUpdateAllowed: ${info.immediateUpdateAllowed}');
      debugPrint('Google Play flexibleUpdateAllowed: ${info.flexibleUpdateAllowed}');

      if (info.updateAvailability != UpdateAvailability.updateAvailable) {
        return;
      }

      if (!info.immediateUpdateAllowed) {
        debugPrint('Immediate update is not allowed by Google Play.');
        return;
      }

      await InAppUpdate.performImmediateUpdate();
    } on PlatformException catch (e, stackTrace) {
      debugPrint('Google Play In-App Update PlatformException: ${e.code} - ${e.message}');
      debugPrintStack(stackTrace: stackTrace);
    } catch (e, stackTrace) {
      debugPrint('Google Play In-App Update Error: $e');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _isChecking = false;
    }
  }
}