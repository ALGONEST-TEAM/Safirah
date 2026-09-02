import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_statistics_model.dart';
import 'match_statistics_row_widget.dart';

class MatchStatisticsCardWidget extends StatelessWidget {
  final String title;
  final List<StatItemModel> statsList;
  final Color homeColor;
  final Color awayColor;

  const MatchStatisticsCardWidget({
    super.key,
    required this.title,
    required this.statsList,
    required this.homeColor,
    required this.awayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: AutoSizeTextWidget(
              text: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              colorText: AppColors.fontColor,
            ),
          ),
          const Divider(height: 1, color: Color(0xfff5f3f9)),

          // Stat Rows
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: statsList.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Color(0xfff5f3f9)),
            itemBuilder: (context, index) {
              return MatchStatisticsRowWidget(
                stat: statsList[index],
                homeColor: homeColor,
                awayColor: awayColor,
              );
            },
          ),
        ],
      ),
    );
  }
}
