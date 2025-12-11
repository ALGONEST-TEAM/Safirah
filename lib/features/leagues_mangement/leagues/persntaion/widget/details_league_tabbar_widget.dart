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
          return TabBar(
            controller: controller,
            isScrollable: false,
            tabAlignment: TabAlignment.fill,
            dividerColor: Colors.transparent,
            indicator: const BoxDecoration(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: List.generate(tabTitle.length, (i) {
              final t = (1 - (anim.value - i).abs()).clamp(0.0, 1.0);
              final bg = Color.lerp(
                Colors.white,
                AppColors.primaryColor,
                Curves.easeOut.transform(t),
              )!;
              final fg = t > 0.5 ? Colors.white : AppColors.secondaryColor;

              return Tab(
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: AutoSizeTextWidget(
                    text: tabTitle[i],
                    colorText: fg,
                    fontSize: 11.5.sp,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}