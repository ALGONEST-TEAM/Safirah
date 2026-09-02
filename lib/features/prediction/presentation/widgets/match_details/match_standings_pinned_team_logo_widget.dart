import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/online_images_widget.dart';

class MatchStandingsPinnedTeamLogoWidget extends StatelessWidget {
  final String logoUrl;

  const MatchStandingsPinnedTeamLogoWidget({
    super.key,
    required this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (logoUrl.isNotEmpty) {
      return Container(
        width: 20.r,
        height: 20.r,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.antiAlias,
        child: OnlineImagesWidget(
          imageUrl: logoUrl,
          size: Size(20.r, 20.r),
          fit: BoxFit.contain,
        ),
      );
    }
    return Container(
      width: 20.r,
      height: 20.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.greySwatch.shade100,
        border: Border.all(color: AppColors.greySwatch.shade200, width: 0.5),
      ),
      alignment: Alignment.center,
      child: Icon(Icons.shield_outlined, size: 11.sp, color: AppColors.fontColor3),
    );
  }
}
