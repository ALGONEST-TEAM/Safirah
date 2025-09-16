import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/theme/app_colors.dart';

class SmoothPageIndicatorWidget extends StatelessWidget {
  final int pageController;
  final int count;

  const SmoothPageIndicatorWidget({
    super.key,
    required this.pageController,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: SmoothPageIndicator(
        controller: PageController(initialPage: pageController),
        count: count,
        effect: const ExpandingDotsEffect(
          activeDotColor: AppColors.whiteColor,
          dotColor: Colors.white38,
          dotHeight: 2.5,
          dotWidth: 14,
          expansionFactor: 3,
          spacing: 3.0,
        ),
      ),
    );
  }
}
