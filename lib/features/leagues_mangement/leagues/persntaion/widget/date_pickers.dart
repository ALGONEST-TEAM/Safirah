import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safirah/core/theme/app_colors.dart';

class DatePickers {
  DatePickers._();

  /// يعرض المنتقي ويعيد التاريخ أو null
  static Future<DateTime?> pick(
    BuildContext context, {
    DateTime? initial,
    DateTime? first,
    DateTime? last,
  }) {
    final now = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: initial ?? now,

      firstDate: first ?? DateTime(2000),
      lastDate: last ?? DateTime(2100),
    );
  }

  /// تنسيق افتراضي yyyy-MM-dd
  static String format(DateTime d, {String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(d);
  }

  /// يربط المنتقي بحقل نصي (يملأه عند الاختيار)
  static Future<void> bindToController(
    BuildContext context,
    TextEditingController controller, {
    DateTime? initial,
    DateTime? first,
    DateTime? last,
    String pattern = 'yMMMMd',
    VoidCallback? onPicked,
  }) async {
    final picked = await pick(
      context,
      initial: initial,
      first: first,
      last: last,
    );
    if (picked == null) return;
    controller.text = format(picked, pattern: pattern);
    onPicked?.call();
  }
}

/// 🔹 منتقي الوقت بتصميم أبيض (نظام 12 ساعة)
class TimePickers {
  TimePickers._();

  /// يعرض منتقي الوقت ويعيد TimeOfDay أو null
  static Future<TimeOfDay?> pick(
    BuildContext context, {
    TimeOfDay? initial,
  }) {
    final now = TimeOfDay.now();
    return showTimePicker(
      context: context,
      initialTime: initial ?? now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: const TimePickerThemeData(
              backgroundColor: Colors.white, // 🩶 خلفية بيضاء
            ),
            colorScheme: ColorScheme.light(
              primary: AppColors.secondaryColor, // لون الأسهم والأزرار
              onSurface: AppColors.secondaryColor,
              surface: AppColors.secondaryColor.withOpacity(0.1),
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(alwaysUse24HourFormat: false), // 12 ساعة
            child: child!,
          ),
        );
      },
    );
  }

  /// تنسيق الوقت بصيغة 12 ساعة مع AM/PM
  static String format(
    TimeOfDay t, {
    String pattern = 'hh:mm a',
  }) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, t.hour, t.minute);
    return DateFormat(pattern).format(dt);
  }

  /// يربط المنتقي بحقل نصي
  static Future<void> bindToController(
    BuildContext context,
    TextEditingController controller, {
    TimeOfDay? initial,
    String pattern = 'hh:mm a',
    VoidCallback? onPicked,
  }) async {
    final picked = await pick(context, initial: initial);
    if (picked == null) return;
    controller.text = format(picked, pattern: pattern);
    onPicked?.call();
  }

  /// دمج التاريخ والوقت في DateTime واحد
  static DateTime merge(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
String normalizeArabicNumbers(String input) {
  const arabicNums = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];
  for (var i = 0; i < arabicNums.length; i++) {
    input = input.replaceAll(arabicNums[i], i.toString());
  }
  return input;
}
