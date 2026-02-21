import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extension/string.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../prediction/presentation/widgets/team_widget.dart';
import '../../data/models/upcoming_match_model.dart';

class UpcomingMatchCardWidget extends StatelessWidget {
  final List<UpcomingMatchModel> matches;

  const UpcomingMatchCardWidget({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        scrollDirection: Axis.horizontal,
        itemCount: matches.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final match = matches[index];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeTextWidget(
                  text: "${match.matchDay} ,${formatDate(match.matchDate)}",
                  fontSize: 10.sp,
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TeamWidget(
                        name: match.homeTeam.name,
                        image: match.homeTeam.logoUrl ?? '',
                        alignRight: true,
                      ),
                      4.w.horizontalSpace,
                      AutoSizeTextWidget(
                        text: match.matchTime??'',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                      4.w.horizontalSpace,
                      TeamWidget(
                        name: match.awayTeam.name,
                        image: match.awayTeam.logoUrl ?? '',
                        alignRight: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
