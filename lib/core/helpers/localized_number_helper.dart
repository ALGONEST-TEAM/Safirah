import 'package:flutter/services.dart';

class LocalizedNumberHelper {
  const LocalizedNumberHelper._();

  static const _arabicIndicDigits = <String>[
    '٠',
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩',
  ];

  static const _easternArabicDigits = <String>[
    '۰',
    '۱',
    '۲',
    '۳',
    '۴',
    '۵',
    '۶',
    '۷',
    '۸',
    '۹',
  ];

  static String normalizeDigits(String input) {
    var value = input;

    for (var i = 0; i < 10; i++) {
      value = value.replaceAll(_arabicIndicDigits[i], '$i');
      value = value.replaceAll(_easternArabicDigits[i], '$i');
    }

    return value;
  }

  static String normalizeNumericText(String input) {
    return normalizeDigits(input).trim();
  }

  static int? parseInt(String input) {
    final normalized = normalizeNumericText(input);
    if (normalized.isEmpty) return null;
    return int.tryParse(normalized);
  }

  static bool isValidInteger(String input) {
    return parseInt(input) != null;
  }
}

class LocalizedDigitsFormatter extends TextInputFormatter {
  const LocalizedDigitsFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final normalized = LocalizedNumberHelper.normalizeDigits(newValue.text);
    return newValue.copyWith(
      text: normalized,
      selection: TextSelection.collapsed(offset: normalized.length),
      composing: TextRange.empty,
    );
  }
}

