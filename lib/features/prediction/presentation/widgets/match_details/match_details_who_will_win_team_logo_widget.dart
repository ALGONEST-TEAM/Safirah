import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/online_images_widget.dart';

class MatchDetailsWhoWillWinTeamLogoWidget extends StatelessWidget {
  final String logoUrl;

  const MatchDetailsWhoWillWinTeamLogoWidget({
    super.key,
    required this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (logoUrl.isNotEmpty) {
      return Container(
        width: 44.r,
        height: 44.r,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.antiAlias,
        child: OnlineImagesWidget(
          imageUrl: logoUrl,
          size: Size(44.r, 44.r),
          fit: BoxFit.contain,
        ),
      );
    }
    return Container(
      width: 44.r,
      height: 44.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.greySwatch.shade100,
      ),
      alignment: Alignment.center,
      child: Icon(Icons.shield_outlined, color: AppColors.mainColorFont, size: 22.sp),
    );
  }
}
