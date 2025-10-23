import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../generated/l10n.dart';
import '../theme/app_colors.dart';
import '../widgets/auto_size_text_widget.dart';

// /// Success ///
void showFlashBarSuccess({
  required BuildContext context,
  required String message,
}) {
  Flushbar(
    duration: const Duration(seconds: 3),
    message: message,
    messageText: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'IBMPlexSansArabic',
      ),
    ),
    margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 18.h),
    padding: EdgeInsets.all(12.sp),
    backgroundColor: AppColors.successSwatch.shade800.withValues(alpha: .9),
    borderRadius: BorderRadius.circular(8.r),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
  ).show(context);
}

/// Error ///
void showFlashBarError({
  required BuildContext context,
  required String title,
  required String text,
}) {
  Flushbar(
    duration: const Duration(seconds: 3),
    title: title,
    message: text,
    titleText: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'IBMPlexSansArabic',
      ),
    ),
    messageText: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12.8.sp,
        fontWeight: FontWeight.w500,

        fontFamily: 'IBMPlexSansArabic',
      ),
    ),
    backgroundColor: const Color(0xFFBC2A23),
    margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 18.h),
    padding: EdgeInsets.all(12.sp),
    borderRadius: BorderRadius.circular(8.r),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
  ).show(context);
}

/// Exit ///
void pressAgainToExit({
  required BuildContext context,
  String? text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: 160.w,
      duration: const Duration(seconds: 2),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.sp)),
        alignment: Alignment.center,
        child: AutoSizeTextWidget(
          text: text ?? S.of(context).clickAgainToExit,
          colorText: Colors.white,
          fontSize: 14.sp,
          minFontSize: 4,
          maxFontSize: 20,
          textAlign: TextAlign.center,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black54.withValues(alpha: .8),
    ),
  );
}
