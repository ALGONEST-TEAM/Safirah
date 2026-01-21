import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/extension/string.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

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
        horizontal: isOpened ? 8.w : 4.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: (statusColor ?? '').toColor(),
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
              AutoSizeTextWidget(
                text: (pointsEarned ?? 0).toString(),
                fontSize: 8.6.sp,
                colorText: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          2.h.verticalSpace,
          Visibility(
            visible: isOpened,
            replacement: SvgPicture.asset(
              rtl ? AppIcons.arrowBackEn : AppIcons.arrowBack,
              color: Colors.white,
              height: 15.h,
            ),
            child: AutoSizeTextWidget(
              text: "${homeScore ?? 0} - ${awayScore ?? 0}",
              colorText: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
