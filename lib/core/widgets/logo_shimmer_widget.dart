import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/constants/app_icons.dart';

import '../constants/app_images.dart';
import '../theme/app_colors.dart';
import 'shimmer_widget.dart';

class LogoShimmerWidget extends StatelessWidget {
  final double? width;

  const LogoShimmerWidget({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShimmerWidget(
          baseColor: AppColors.greySwatch.shade200,
          highlightColor: Colors.grey.shade50,
        child: SvgPicture.asset(AppIcons.logoText)
      ),
    );
  }
}
