import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../services/auth/auth.dart';

class SplachScreenWidget extends StatelessWidget {
  final String title;
  final String description;
  final int boardingLength;
  final int currentIndex;
  final PageController controller;

  const SplachScreenWidget({
    super.key,
    required this.title,
    required this.description,
    required this.currentIndex,
    required this.controller,
    required this.boardingLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.sp).copyWith(bottom: 60.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SmoothPageIndicator(
            controller: controller,
            count: boardingLength,
            effect: ExpandingDotsEffect(
              dotColor: AppColors.whiteColor,
              activeDotColor: AppColors.primarySwatch.shade600,
              dotHeight: 8,
              dotWidth: 8,
              expansionFactor: 4.4,
              spacing: 8.0,
            ),
          ),
          14.h.verticalSpace,
          AutoSizeTextWidget(
            text: title,
            fontWeight: FontWeight.bold,
            colorText: Colors.white,
            fontSize: 15.sp,
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: description,
            fontSize: 12.sp,
            colorText: Colors.white,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
            maxLines: 8,
          ),
          18.h.verticalSpace,
          DefaultButtonWidget(
            text: 'التالي',
            height: 38.h,
            onPressed: () {
              if (currentIndex == boardingLength - 1) {
                Auth().cacheOnBoarding(true).then((value) {
                  navigateAndFinish(
                    context,
                    const BottomNavigationBarWidget(),
                  );
                });
              }
              controller.nextPage(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
            },
          ),
        ],
      ),
    );
  }
}
