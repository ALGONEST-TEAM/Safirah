import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';

class MatchDetailsTabBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final TabController controller;
  final List<String> tabLabels;

  const MatchDetailsTabBarWidget({
    super.key,
    required this.controller,
    required this.tabLabels,
  });

  @override
  Size get preferredSize => const Size.fromHeight(46.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        labelColor: AppColors.secondaryColor,
        unselectedLabelColor: const Color(0xff454545),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 4.h,
            color: AppColors.secondaryColor,
          ),
          borderRadius: BorderRadius.circular(10.r),
          insets: EdgeInsets.symmetric(horizontal: 5.w),
        ),
        labelStyle: TextStyle(
          fontFamily: 'IBMPlexSansArabic',
          fontWeight: FontWeight.w700,
          fontSize: 12.sp,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'IBMPlexSansArabic',
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
        ),
        tabs: tabLabels.map((label) => Tab(text: label)).toList(),
      ),
    );
  }
}
