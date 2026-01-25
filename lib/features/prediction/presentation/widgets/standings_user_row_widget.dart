import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/standings_model.dart';
import 'standings_rank_widget.dart';

class StandingsUserRowWidget extends StatelessWidget {
  final StandingItemData item;

  const StandingsUserRowWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(28.r),
          gradient: LinearGradient(
            colors: [
              AppColors.secondaryColor,
              AppColors.secondaryColor,
              AppColors.primarySwatch.shade500,
              AppColors.primaryColor,
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StandingsRankWidget(
            rank: item.rank,
            movement: item.trend,
            fontColor: Colors.white,
          ),
          4.w.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: item.user,
                  fontSize: 12.sp,
                  minFontSize: 12,
                  maxLines: 2,
                  colorText: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: '${item.correctPredictions} توقع صحيح',
                  fontSize: 9.sp,
                  colorText: Colors.white,
                  maxLines: 2,
                ),
                2.h.verticalSpace,
                AutoSizeTextWidget(
                  text: '${item.incorrectPredictions} توقع غير صحيح',
                  fontSize: 9.sp,
                  colorText: Colors.white,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 54.w,
            child: AutoSizeTextWidget(
              text: item.points.toString(),
              fontSize: 11.sp,
              textAlign: TextAlign.end,
              maxLines: 2,
              colorText: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
