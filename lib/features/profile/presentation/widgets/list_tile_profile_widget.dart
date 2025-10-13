import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class ListTileProfileWidget extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final double? fontSize;

  const ListTileProfileWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.fontSize,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Material(
        color: Colors.white,
        child: ListTile(
          onTap: onTap,
          title: AutoSizeTextWidget(
            text: title,
            fontSize: fontSize ?? 11.8.sp,
            colorText: Colors.black,
          ),
          leading: SvgPicture.asset(
            icon,
            color: AppColors.secondaryColor,
          ),
          trailing: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: SvgPicture.asset(
              AppIcons.arrowLeft,
              color: const Color(0xffbfc8c6),
              height: 14.h,
            ),
          ),
          titleAlignment: ListTileTitleAlignment.center,
          dense: true,
          horizontalTitleGap: 10.w,
          contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 12.w),
        ),
      ),
    );
  }
}
