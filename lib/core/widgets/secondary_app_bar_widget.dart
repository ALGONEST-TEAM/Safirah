import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_icons.dart';
import 'auto_size_text_widget.dart';
import 'buttons/icon_button_widget.dart';

class SecondaryAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final bool? centerTitle;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? backgroundColor;
  final bool isLogo;
  final double? fromHeight;
  final double? logoHeight;

  const SecondaryAppBarWidget({
    super.key,
    this.title = '',
    this.centerTitle = true,
    this.fontWeight,
    this.fontSize,
    this.backgroundColor,
    this.isLogo = false,
    this.fromHeight,
    this.logoHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(fromHeight ?? 48.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      surfaceTintColor: backgroundColor ?? Colors.transparent,
      elevation: 0.0,
      titleSpacing: 0,
      toolbarHeight: fromHeight ?? 48.h,
      centerTitle: centerTitle,
      title: isLogo
          ? SvgPicture.asset(
              AppIcons.logo,
              height: logoHeight ?? 40.h,
            )
          : AutoSizeTextWidget(
              text: title.toString(),
              fontSize: fontSize ?? 14.4.sp,
              fontWeight: fontWeight ?? FontWeight.w600,
            ),
      leading: const IconButtonWidget(),
    );
  }
}
