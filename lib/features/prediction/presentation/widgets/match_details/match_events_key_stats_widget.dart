import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/team_color_helper.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_details_model.dart';
import 'match_events_key_stats_row_widget.dart';

class MatchEventsKeyStatsWidget extends StatelessWidget {
  final Color homeColor;
  final Color awayColor;
  final List<MatchKeyStatisticModel> keyStatistics;

  const MatchEventsKeyStatsWidget({
    super.key,
    required this.homeColor,
    required this.awayColor,
    required this.keyStatistics,
  });

  @override
  Widget build(BuildContext context) {
    if (keyStatistics.isEmpty) return const SizedBox.shrink();

    // Helper to format numeric strings
    String formatDouble(String? valStr) {
      if (valStr == null || valStr.isEmpty) return '0';
      final d = double.tryParse(valStr) ?? 0.0;
      if (d == d.toInt()) return d.toInt().toString();
      return d.toStringAsFixed(1);
    }

    // Find ball possession stat
    final possessionStat = keyStatistics
        .where((s) =>
            s.code == 'ball-possession' ||
            (s.label != null && s.label!.contains('استحواذ')))
        .firstOrNull;

    int homePossession = 50;
    int awayPossession = 50;
    if (possessionStat != null) {
      homePossession = int.tryParse(double.tryParse(possessionStat.home ?? '50')
                  ?.toStringAsFixed(0) ??
              '50') ??
          50;
      awayPossession = int.tryParse(double.tryParse(possessionStat.away ?? '50')
                  ?.toStringAsFixed(0) ??
              '50') ??
          50;
    }

    // Build stat items excluding possession
    final List<Widget> statRows = [];

    for (final stat in keyStatistics) {
      if (stat.code == 'ball-possession') continue;

      final double homeNum = double.tryParse(stat.home ?? '0') ?? 0.0;
      final double awayNum = double.tryParse(stat.away ?? '0') ?? 0.0;
      final String labelStr = (stat.label != null && stat.label!.isNotEmpty)
          ? stat.label!
          : (stat.code ?? '');

      if (labelStr.isEmpty || labelStr.contains('استحواذ')) continue;

      statRows.add(
        MatchEventsKeyStatsRowWidget(
          title: labelStr,
          homeValueText: formatDouble(stat.home),
          awayValueText: formatDouble(stat.away),
          homeVal: homeNum,
          awayVal: awayNum,
          homeColor: homeColor,
          awayColor: awayColor,
        ),
      );
    }

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
              text: 'أبرز الاحصائيات',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              colorText: AppColors.mainColorFont,
            ),
          ),
          const Divider(height: 1, color: Color(0xfff5f3f9)),

          // 1. Possession Progress Bar Section
          if (possessionStat != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                children: [
                  AutoSizeTextWidget(
                    text: 'الاستحواذ على الكرة',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    colorText: AppColors.fontColor,
                  ),
                  10.h.verticalSpace,
                  _PossessionBarWidget(
                    homePercent: homePossession,
                    awayPercent: awayPossession,
                    homeColor: homeColor,
                    awayColor: awayColor,
                  ),
                ],
              ),
            ),
            if (statRows.isNotEmpty)
              const Divider(height: 1, color: Color(0xfff5f3f9)),
          ],

          // 2. Rows list matching match_statistics_card_widget
          if (statRows.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: statRows.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Color(0xfff5f3f9)),
              itemBuilder: (context, index) => statRows[index],
            ),
        ],
      ),
    );
  }
}

// ── Possession progress bar ───────────────────────────────────────────────────
class _PossessionBarWidget extends StatelessWidget {
  final int homePercent;
  final int awayPercent;
  final Color homeColor;
  final Color awayColor;

  const _PossessionBarWidget({
    required this.homePercent,
    required this.awayPercent,
    required this.homeColor,
    required this.awayColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Row(
        children: [
          // Home (right team in RTL)
          Expanded(
            flex: homePercent > 0 ? homePercent : 50,
            child: Container(
              height: 28.h,
              color: homeColor,
              alignment: Alignment.center,
              child: AutoSizeTextWidget(
                text: '$homePercent%',
                colorText: TeamColorHelper.getTextColor(homeColor),
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
              ),
            ),
          ),
          // Away (left team in RTL)
          Expanded(
            flex: awayPercent > 0 ? awayPercent : 50,
            child: Container(
              height: 28.h,
              color: awayColor,
              alignment: Alignment.center,
              child: AutoSizeTextWidget(
                text: '$awayPercent%',
                colorText: TeamColorHelper.getTextColor(awayColor),
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
