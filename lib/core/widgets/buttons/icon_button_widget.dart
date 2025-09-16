import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_icons.dart';
import '../../theme/app_colors.dart';

class IconButtonWidget extends StatelessWidget {
  final String? icon;
  final Color? iconColor;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;

  const IconButtonWidget({
    super.key,
    this.icon,
    this.iconColor,
    this.height,
    this.width,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: AppColors.secondarySwatch.shade800.withOpacity(.1),
      highlightColor: AppColors.secondarySwatch.shade800.withOpacity(.1),
      splashRadius: 2,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
      ),
      onPressed: onPressed ??
          () {
            Navigator.of(context).pop();
          },
      icon: SvgPicture.asset(
        icon ?? AppIcons.arrowBack,
        height: height,
        width: width,
        color: iconColor??AppColors.secondaryColor,
      ),
    );
  }
}
