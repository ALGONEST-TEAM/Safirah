import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
class DetailsLeagueTabBarWidget extends StatelessWidget {
  const DetailsLeagueTabBarWidget({
    super.key,
    required this.controller,
    required this.tabTitle,
  });

  final TabController controller;
  final List<String> tabTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: AnimatedBuilder(
        animation: controller.animation!,
        builder: (_, __) {
          final anim = controller.animation!;
          // return TabBar(
          //   controller: controller,
          //   isScrollable: false,
          //   tabAlignment: TabAlignment.fill,
          //   dividerColor: Colors.transparent,
          //   indicator: const BoxDecoration(),
          //   overlayColor: MaterialStateProperty.all(Colors.transparent),
          //   indicatorSize: TabBarIndicatorSize.tab,
          //   tabs: List.generate(tabTitle.length, (i) {
          //     final t = (1 - (anim.value - i).abs()).clamp(0.0, 1.0);
          //     final bg = Color.lerp(
          //       Colors.white,
          //       AppColors.secondaryColor,
          //       Curves.easeOut.transform(t),
          //     )!;
          //     final fg = t > 0.5 ? Colors.white : AppColors.secondaryColor;
          //
          //     return Tab(
          //       child: Container(
          //         height: 40.h,
          //         width: double.infinity,
          //         alignment: Alignment.center,
          //         decoration: BoxDecoration(
          //           color: bg,
          //           borderRadius: BorderRadius.circular(12.r),
          //         ),
          //         child: AutoSizeTextWidget(
          //           text: tabTitle[i],
          //           colorText: fg,
          //           fontSize: 11.5.sp,
          //         ),
          //       ),
          //     );
          //   }),
          // );
       return   TabBar(
            controller: controller,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.zero,
            indicator: ShapeDecoration(
              color: AppColors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            tabs: [
              for (int i = 0; i < tabTitle.length; i++)
                AnimatedBuilder(
                  animation: controller.animation!,
                  builder: (context, _) {
                    final value = controller.animation?.value ??
                        controller.index.toDouble();
                    final selectness =
                    (1.0 - (value - i).abs()).clamp(0.0, 1.0);
                    final bgColor = Color.lerp(Colors.white,
                        AppColors.secondaryColor, selectness)!;
                    final textColor = Color.lerp(
                        AppColors.secondaryColor,
                        Colors.white,
                        selectness)!;

                    return Container(
                        height: 34.h,
                        width: 100.w,
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.greySwatch.shade100,
                            width: 0.4,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(tabTitle[i],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: 'IBMPlexSansArabic',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.4.sp,
                              color: textColor,
                            )));
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}