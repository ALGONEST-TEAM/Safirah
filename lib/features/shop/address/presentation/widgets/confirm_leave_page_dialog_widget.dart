import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../generated/l10n.dart';

class ConfirmLeavePageDialogWidget extends StatelessWidget {
  const ConfirmLeavePageDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).confirmLeavePageTitle,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        S.of(context).confirmLeavePageDescription,
        style: TextStyle(
          fontSize: 11.8.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.fontColor,
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            S.of(context).confirmLeavePageContinue,
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 11.sp,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            foregroundColor: Colors.white,
          ),
          child: Text(
            ' ${S.of(context).confirmLeavePageBack} ',
            style: TextStyle(fontSize: 11.sp),
          ),
        ),
      ],
    );
  }

  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ConfirmLeavePageDialogWidget(),
    );

    return result ?? false;
  }
}
