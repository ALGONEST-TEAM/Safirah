import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extension/string.dart';
import '../../../../core/theme/app_colors.dart';

class MatchPointsStatusWidget extends StatelessWidget {
  final bool isOpened;
  final bool rtl;

  final String? statusColor;
  final num? pointsEarned;
  final num? homeScore;
  final num? awayScore;

  const MatchPointsStatusWidget({
    super.key,
    required this.isOpened,
    required this.rtl,
    required this.statusColor,
    required this.pointsEarned,
    required this.homeScore,
    required this.awayScore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        // horizontal: isOpened ? 8.w : 4.w,
        horizontal: 8.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: (statusColor ?? '').toColorOrNull() ?? AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8.r),
          bottomRight: Radius.circular(8.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.star_rate_rounded,
                color: Colors.white,
                size: 13.sp,
              ),
              2.w.horizontalSpace,
              Text(
                (pointsEarned ?? 0).toString(),
                style: TextStyle(
                  fontSize: 8.6.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          2.h.verticalSpace,
          Text(
            "${homeScore ?? 0} - ${awayScore ?? 0}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
