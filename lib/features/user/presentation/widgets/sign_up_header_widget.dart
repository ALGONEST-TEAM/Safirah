import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../generated/l10n.dart';
import 'user_page_titles_widget.dart';

class SignUpAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const SignUpAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      surfaceTintColor: AppColors.secondaryColor,
      automaticallyImplyLeading: false,
      toolbarHeight: 38.h,
      elevation: 0.0,
      leading: const IconButtonWidget(
        iconColor: Colors.white,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(38.h);
}

class SignUpHeaderWidget extends StatelessWidget {
  const SignUpHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 18.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: UserPageTitlesWidget(
              title: S.of(context).createAccountS,
              subTitle: S.of(context).createAccountDesc,
              fontSize: 17.sp,
            ),
          ),
          SvgPicture.asset(AppIcons.logo),
        ],
      ),
    );
  }
}
