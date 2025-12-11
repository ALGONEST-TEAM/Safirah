import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../team_and_player/data/model/team_model.dart';

class TeamTabsWidget extends StatelessWidget {
  final TeamModel homeTeam;
  final TeamModel awayTeam;

  const TeamTabsWidget({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Container(
        height: 40.h,
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: TabBar(
          dividerColor: Colors.transparent,
          tabAlignment: TabAlignment.fill,
          indicator: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.5.w),
          indicatorSize: TabBarIndicatorSize.tab,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          labelPadding: EdgeInsets.zero,
          indicatorPadding:
          EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 2),
          labelColor: Colors.white,
          unselectedLabelColor: AppColors.secondaryColor,
          tabs: [
            Tab(text: homeTeam.teamName),
            Tab(text: awayTeam.teamName),
          ],
        ),
      ),
    );
  }
}
