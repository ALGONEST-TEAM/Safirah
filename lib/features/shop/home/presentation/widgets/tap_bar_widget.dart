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
      labelColor: Colors.white,
      unselectedLabelColor: AppColors.secondaryColor,
      labelStyle: TextStyle(
        fontFamily: 'IBMPlexSansArabic',
        fontWeight: FontWeight.w500,
        fontSize: font,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'IBMPlexSansArabic',
        fontWeight: FontWeight.w500,
        fontSize: font,
        color: AppColors.secondaryColor,
      ),
      indicator: ShapeDecoration(
        color:AppColors.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      tabs: [
        for (final title in titles)
          Tab(
            height: chipHeight,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.5.w),
              padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
              decoration: BoxDecoration(
                color:AppColors.transparent,
                borderRadius: BorderRadius.circular(radius),
                border:
                    Border.all(color: AppColors.greySwatch.shade200, width: 1),
              ),
              alignment: Alignment.center,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.rtl,
              ),
            ),
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
