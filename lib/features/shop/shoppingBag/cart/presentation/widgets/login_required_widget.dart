import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';


class LoginRequiredWidget extends StatelessWidget {
  const LoginRequiredWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          12.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).loginRequired,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
          ),
          4.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).pleaseLoginToContinue,
            fontSize: 12.5.sp,
            colorText: AppColors.fontColor,
          ),
          12.h.verticalSpace,
          DefaultButtonWidget(
            text: S.of(context).logIn,
            width: 140.w,
            height: 34.h,
            onPressed: () {
              // navigateTo(
              //   context,
              //   const LogInPage(),
              // );
            },
          ),
        ],
      ),
    );
  }
}
