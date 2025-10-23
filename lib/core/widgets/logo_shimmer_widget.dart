import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/constants/app_icons.dart';
import '../theme/app_colors.dart';
import 'shimmer_widget.dart';

class LogoShimmerWidget extends StatelessWidget {

  const LogoShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShimmerWidget(
          baseColor: AppColors.greySwatch.shade200,
          highlightColor: Colors.grey.shade50,
        child: SvgPicture.asset(AppIcons.logoText,)
      ),
    );
  }
}
