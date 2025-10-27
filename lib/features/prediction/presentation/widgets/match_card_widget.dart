import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/show_modal_bottom_sheet_widget.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import 'matches_widget.dart';
import 'send_prediction_widget.dart';
import 'team_widget.dart';

class MatchCardWidget extends StatelessWidget {
  final MatchSection section;

  const MatchCardWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: AutoSizeTextWidget(
              text: section.title,
              fontSize: 10.6.sp,
            ),
          ),
          Divider(
            height: 6.h,
            color: AppColors.fontColor2.withValues(alpha: .15),
          ),
          Column(
            children: List.generate(section.items.length, (i) {
              final item = section.items[i];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheetWidget(
                        context: context,
                        page: SendPredictionWidget(
                          title: section.title,
                          items: item,
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        6.w.horizontalSpace,
                        Icon(
                          Icons.arrow_circle_right_outlined,
                          color: const Color(0xff5e5e84).withValues(alpha: .8),
                          size: 14.8.sp,
                        ),
                        4.w.horizontalSpace,
                        TeamWidget(
                          name: item.home,
                          image: item.image,
                          alignRight: true,
                        ),
                        Expanded(
                          child: AutoSizeTextWidget(
                            text: item.time,
                            fontSize: 12.2.sp,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TeamWidget(
                          name: item.away,
                          image: item.awayImage,
                          alignRight: false,
                        ),
                        6.w.horizontalSpace,
                      ],
                    ),
                  ),
                  if (i != section.items.length - 1)
                    Divider(
                      height: 4.h,
                      color: AppColors.fontColor2.withValues(alpha: .14),
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
