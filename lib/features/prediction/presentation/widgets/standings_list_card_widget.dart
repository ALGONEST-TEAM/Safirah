import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/standings_model.dart';
import 'standings_header_widget.dart';
import 'standings_rank_widget.dart';

class StandingsListCardWidget extends StatelessWidget {
  final List<StandingItemData> items;

  const StandingsListCardWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r)),
      elevation: 0,
      child: Column(
        spacing: 8.h,
        children: [
          const StandingsHeaderWidget(),
          Column(
            children: List.generate(items.length, (i) {
              final item = items[i];
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.w,
                      children: [
                        StandingsRankWidget(
                          rank: item.rank,
                          movement: item.trend,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            spacing: 4.h,
                            children: [
                              AutoSizeTextWidget(
                                text: item.user,
                                fontSize: 12.sp,
                                minFontSize: 12,
                                maxLines: 2,
                              ),
                              // AutoSizeTextWidget(
                              //   text: item.username,
                              //   fontSize: 10.sp,
                              //   colorText: AppColors.fontColor
                              //       .withValues(alpha: .6),
                              //   maxLines: 2,
                              // ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            spacing: 6.h,
                            children: [
                              AutoSizeTextWidget(
                                text:
                                '${item.correctPredictions} توقع صحيح',
                                fontSize: 10.sp,
                                colorText: AppColors.fontColor
                                    .withValues(alpha: .6),
                                maxLines: 2,
                              ),
                              AutoSizeTextWidget(
                                text:
                                '${item.incorrectPredictions} توقع غير صحيح',
                                fontSize: 10.sp,
                                colorText: AppColors.fontColor
                                    .withValues(alpha: .6),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (i != items.length - 1)
                    Divider(
                      height: 10.h,
                      color:
                      AppColors.fontColor2.withValues(alpha: .14),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
