import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';

class TapBarWidget extends StatelessWidget {
  final TabController controller;
  final List<String> titles;
  final double t;

  const TapBarWidget({
    super.key,
    required this.controller,
    required this.titles,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final double vPad = lerpDouble(6.h, 8.h, t)!; // padding عمودي
    final double hPad = lerpDouble(24.w, 34.w, t)!; // padding أفقي
    final double chipHeight = lerpDouble(36.h, 40.h, t)!; // ارتفاع الكبسولة
    final double radius = lerpDouble(8.r, 8.r, t)!; // نصف القطر
    final double font = lerpDouble(11.sp, 12.sp, t)!; // حجم الخط

    return TabBar(
      controller: controller,
      isScrollable: true,
      padding: EdgeInsets.symmetric(horizontal: 4.5.w),
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      labelPadding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 2),
      indicator: ShapeDecoration(
        color: AppColors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      tabs: [
        for (int i = 0; i < titles.length; i++)
          AnimatedBuilder(
            animation: controller.animation!,
            builder: (context, _) {
              // موقع الأنيميشن الحالي
              final value =
                  controller.animation?.value ?? controller.index.toDouble();
              // حساب القرب من التبويبة الحالية
              final selectness = (1.0 - (value - i).abs()).clamp(0.0, 1.0);
              final bgColor = Color.lerp(
                  Colors.white, AppColors.secondaryColor, selectness)!;
              final textColor = Color.lerp(
                  AppColors.secondaryColor, Colors.white, selectness)!;

              return Container(
                height: chipHeight,
                margin: EdgeInsets.symmetric(horizontal: 4.5.w),
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: AppColors.greySwatch.shade100,
                    width: 0.4,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  titles[i],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'IBMPlexSansArabic',
                    fontWeight: FontWeight.w500,
                    fontSize: font,
                    color: textColor,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

class CollapsingTabBarHeaderWidget extends SliverPersistentHeaderDelegate {
  CollapsingTabBarHeaderWidget({
    required this.minHeight,
    required this.maxHeight,
    required this.builder,
  }) : assert(maxHeight >= minHeight);

  final double minHeight;
  final double maxHeight;

  final Widget Function(double t) builder;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final total = (maxExtent - minExtent);
    final clamped = (total - shrinkOffset).clamp(0.0, total);
    final t = total == 0 ? 0.0 : (clamped / total);

    return SizedBox.expand(
      child: Material(
        color: AppColors.scaffoldColor,
        child: builder(t),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant CollapsingTabBarHeaderWidget oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight ||
        builder != oldDelegate.builder;
  }
}
