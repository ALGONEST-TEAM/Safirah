import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/online_images_widget.dart';

class MatchStandingsRowTeamLogoWidget extends StatelessWidget {
  final String logoUrl;
  final String teamName;

  const MatchStandingsRowTeamLogoWidget({
    super.key,
    required this.logoUrl,
    required this.teamName,
  });

  @override
  Widget build(BuildContext context) {
    if (logoUrl.isNotEmpty) {
      return Container(
        width: 22.r,
        height: 22.r,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.antiAlias,
        child: OnlineImagesWidget(
          imageUrl: logoUrl,
          size: Size(22.r, 22.r),
          fit: BoxFit.contain,
        ),
      );
    }
    return Container(
      width: 22.r,
      height: 22.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.greySwatch.shade100,
        border: Border.all(color: AppColors.greySwatch.shade200, width: 0.5),
      ),
      alignment: Alignment.center,
      child: Icon(Icons.shield_outlined, size: 12.sp, color: AppColors.fontColor3),
    );
  }
}
