import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../theme/app_colors.dart';

class SmoothPageIndicatorWidget extends StatelessWidget {
  final int count;
  final int pageController;

  const SmoothPageIndicatorWidget({super.key, required this.count, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: SmoothPageIndicator(
        controller: PageController(initialPage: pageController),
        count: count,
        effect: ExpandingDotsEffect(
          activeDotColor: AppColors.whiteColor,
          dotColor: Colors.white54,
          dotHeight: 3,
          dotWidth: 5,
          expansionFactor: 2.0,
          spacing: 6.0,
        ),
      ),
    );
  }
}

