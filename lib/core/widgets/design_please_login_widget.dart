import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/constants/app_icons.dart';
import '../../features/user/presentation/pages/log_in_page.dart';
import '../../generated/l10n.dart';
import '../helpers/navigateTo.dart';
import '../theme/app_colors.dart';
import 'auto_size_text_widget.dart';
import 'buttons/default_button.dart';

class DesignPleaseLoginWidget extends StatelessWidget {
  const DesignPleaseLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppIcons.logo,height: 70.h,),
          20.h.verticalSpace,

          AutoSizeTextWidget(
            text: S.of(context).loginRequired,
            fontSize: 15.6.sp,
          ),
          6.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).pleaseLoginToContinue,
            colorText: AppColors.fontColor,
            fontSize: 12.8.sp,
          ),
          20.h.verticalSpace,
          DefaultButtonWidget(
            text: S.of(context).logIn,
            width: 180.w,
            height: 36.h,
            onPressed: () {
              navigateTo(context, const LogInPage());
            },
          )
        ],
      ),
    );
  }
}
