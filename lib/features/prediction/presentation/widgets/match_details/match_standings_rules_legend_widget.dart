import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_fixture_standings_model.dart';
import '../../provider/match_standings_ui_provider.dart';

class MatchStandingsRulesLegendWidget extends StatelessWidget {
  final List<MatchStandingsRuleModel> rulesLegend;

  const MatchStandingsRulesLegendWidget({
    super.key,
    required this.rulesLegend,
  });

  @override
  Widget build(BuildContext context) {
    if (rulesLegend.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: 'التأهل والهبوط',
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            colorText: AppColors.fontColor,
          ),
          16.h.verticalSpace,
          Wrap(
            spacing: 16.w,
            runSpacing: 12.h,
            children: rulesLegend.map((rule) {
              final Color color = MatchStandingsUIHelper.parseColor(rule.color, Colors.transparent);
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12.r,
                    height: 12.r,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: color, width: 2.r),
                    ),
                  ),
                  8.w.horizontalSpace,
                  Flexible(
                    child: AutoSizeTextWidget(
                      text: rule.name,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      colorText: AppColors.fontColor2,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
