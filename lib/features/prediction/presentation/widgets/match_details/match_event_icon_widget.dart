import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safirah/core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import 'match_events_list_widget.dart'; // For MatchEventType

class MatchEventIconWidget extends StatelessWidget {
  final MatchEventType type;

  const MatchEventIconWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case MatchEventType.goal:
        return Icon(Icons.sports_soccer, size: 14.sp, color: AppColors.mainColorFont);
      case MatchEventType.penaltyGoal:
        return Container(
          width: 15.sp,
          height: 15.sp,
          decoration: BoxDecoration(
            color: const Color(0xfffecb00), // Yellow circle
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.mainColorFont, width: 1.0),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 1.0), // Slight nudge to visually center 'P'
            child: Text(
              'P',
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.w900,
                color: AppColors.mainColorFont,
                height: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      case MatchEventType.yellowCard:
        return Container(
          width: 11.w,
          height: 15.h,
          decoration: BoxDecoration(
            color: const Color(0xfffecb00),
            borderRadius: BorderRadius.circular(2.r),
          ),
        );
      case MatchEventType.redCard:
        return Container(
          width: 11.w,
          height: 15.h,
          decoration: BoxDecoration(
            color: const Color(0xffe53935),
            borderRadius: BorderRadius.circular(2.r),
          ),
        );
      case MatchEventType.substitution:
        // return Container(
        //   width: 24.r,
        //   height: 24.r,
        //   decoration: const BoxDecoration(
        //     color: Color(0xfff1f1f5),
        //     shape: BoxShape.circle,
        //   ),
        //   alignment: Alignment.center,
        //   child: Icon(
        //     Icons.compare_arrows_rounded,
        //     size: 14.sp,
        //     color: const Color(0xffef4444), // red/green swap style
        //   ),
        // );
        return SvgPicture.asset(
          AppIcons.substitutionInMatch,
          width: 14.sp,
          height: 14.sp,
        );
      case MatchEventType.penaltyMissed:
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // The exact same 'P' circle as penaltyGoal
            Container(
              width: 15.sp,
              height: 15.sp,
              decoration: BoxDecoration(
                color: const Color(0xfffecb00),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.mainColorFont, width: 1.0),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: Text(
                  'P',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w900,
                    color: AppColors.mainColorFont,
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Professional small red 'X' badge at the bottom right
            Positioned(
              bottom: -3,
              right: -3,
              child: Container(
                padding: EdgeInsets.all(0.5.r),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close_rounded, size: 8.sp, color: AppColors.dangerColor),
              ),
            ),
          ],
        );
      case MatchEventType.canceledGoal:
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.sports_soccer, size: 14.sp, color: AppColors.mainColorFont.withOpacity(0.3)),
            Positioned(
              bottom: -3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppColors.dangerColor,
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Text(
                  'VAR',
                  style: TextStyle(
                    fontSize: 6.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
              ),
            ),
          ],
        );
      case MatchEventType.addedTime:
      case MatchEventType.halfTime:
      case MatchEventType.fullTime:
        return SizedBox(width: 24.r);
    }
  }
}
