import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalContactInfo {
  static const String supportEmail = 'spport@safira.com';
  static const String ownerName = 'متجر صافرة';
  static const String lastUpdated = '18 أبريل 2026';
}

Future<void> launchLegalEmail(BuildContext context, String email) async {
  final uri = Uri.parse('mailto:$email');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
    return;
  }

  await Clipboard.setData(ClipboardData(text: email));
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ البريد الإلكتروني للتواصل.'),
      ),
    );
  }
}

