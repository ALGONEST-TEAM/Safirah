import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_statistics_model.dart';
import '../../provider/match_details_providers.dart';
import '../../riverpod/match_details_riverpod.dart';
import 'match_statistics_card_widget.dart';
import 'match_statistics_periods_bar_widget.dart';
import 'match_statistics_shimmer_widget.dart';

class MatchStatisticsContentWidget extends ConsumerWidget {
  final int matchId;
  final MatchStatisticsModel statsModel;
  final String selectedPeriodKey;
  final bool isLoading;

  const MatchStatisticsContentWidget({
    super.key,
    required this.matchId,
    required this.statsModel,
    this.selectedPeriodKey = 'all',
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamColors = ref.watch(matchTeamColorsProvider(matchId));
    final Color homeColor = teamColors.homeColor;
    final Color awayColor = teamColors.awayColor;

    // Use periods from model or fallback tabs
    final List<StatPeriodModel> periodTabs = statsModel.periods.isNotEmpty
        ? statsModel.periods
        : [
            StatPeriodModel(
              key: 'all',
              labelAr: 'الكل',
              labelEn: 'All',
              available: true,
              selected: true,
            ),
            StatPeriodModel(
              key: 'first_half',
              labelAr: 'الشوط الأول',
              labelEn: 'First Half',
              available: true,
              selected: false,
            ),
            StatPeriodModel(
              key: 'second_half',
              labelAr: 'الشوط الثاني',
              labelEn: 'Second Half',
              available: true,
              selected: false,
            ),
          ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Dynamic Period Tabs Bar
          MatchStatisticsPeriodsBarWidget(
            periods: periodTabs,
            selectedPeriodKey: selectedPeriodKey,
            onPeriodSelected: (periodKey) {
              if (selectedPeriodKey != periodKey) {
                ref
                    .read(matchStatisticsProvider(matchId).notifier)
                    .getMatchStatistics(period: periodKey);
              }
            },
          ),
          16.h.verticalSpace,

          // Render Sections Dynamically from API directly using StatItemModel
          if (isLoading)
            const MatchStatisticsShimmerWidget()
          else if (statsModel.sections.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: AutoSizeTextWidget(
                  text: 'لا توجد إحصائيات متاحة حالياً',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  colorText: AppColors.fontColor,
                ),
              ),
            )
          else
            for (final section in statsModel.sections) ...[
              if (section.items.isNotEmpty) ...[
                MatchStatisticsCardWidget(
                  title: section.labelAr.isNotEmpty
                      ? section.labelAr
                      : section.labelEn,
                  statsList: section.items,
                  homeColor: homeColor,
                  awayColor: awayColor,
                ),
                16.h.verticalSpace,
              ],
            ],

          32.h.verticalSpace,
        ],
      ),
    );
  }
}
