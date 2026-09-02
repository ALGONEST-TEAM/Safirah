import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_fixture_standings_model.dart';
import '../../provider/match_details_providers.dart';
import '../../riverpod/match_details_riverpod.dart';
import 'match_standings_competition_header_widget.dart';
import 'match_standings_filter_bar_widget.dart';
import 'match_standings_pinned_column_widget.dart';
import 'match_standings_scrollable_table_widget.dart';
import 'match_standings_shimmer_widget.dart';
import 'match_standings_rules_legend_widget.dart';

class MatchStandingsContentWidget extends ConsumerWidget {
  final int matchId;
  final MatchFixtureStandingsModel standingsModel;
  final String selectedGroupKey;
  final String? homeColorHex;
  final String? awayColorHex;
  final bool isLoading;

  const MatchStandingsContentWidget({
    super.key,
    required this.matchId,
    required this.standingsModel,
    this.selectedGroupKey = 'all',
    this.homeColorHex,
    this.awayColorHex,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final competition = standingsModel.competition;
    final tables = standingsModel.tables;

    final filterTabs =
        MatchStandingsUIHelper.getDefaultFilterTabs(selectedGroupKey);
    final standingsItems =
        MatchStandingsUIHelper.flattenStandingItems(tables);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double dynamicGap =
        MatchStandingsUIHelper.calculateDynamicGap(screenWidth);

    Color highlightColor(MatchTeamStandingItemModel item) =>
        MatchStandingsUIHelper.getHighlightColor(
          item,
          homeColorHex: homeColorHex,
          awayColorHex: awayColorHex,
        );

    Color qualificationColor(MatchTeamStandingItemModel item) =>
        MatchStandingsUIHelper.getQualificationColor(item);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Filter Tabs Bar (الكل | داخل الأرض | خارج الأرض)
          MatchStandingsFilterBarWidget(
            filterTabs: filterTabs,
            selectedGroupKey: selectedGroupKey,
            onGroupSelected: (newKey) {
              if (selectedGroupKey != newKey) {
                final String scopeParam = newKey == 'all' ? 'overall' : newKey;
                ref
                    .read(matchStandingsProvider(matchId).notifier)
                    .getMatchStandings(scope: scopeParam);
              }
            },
          ),
          16.h.verticalSpace,

          // Standings Table Container
          if (isLoading)
            const MatchStandingsShimmerWidget()
          else if (standingsItems.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: AutoSizeTextWidget(
                  text: 'لا يوجد ترتيب متاح حالياً',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  colorText: AppColors.fontColor,
                ),
              ),
            )
          else
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Merged League Header
                  if (competition != null)
                    MatchStandingsCompetitionHeaderWidget(
                      competition: competition,
                    ),

                  // Table Body (Pinned Column + Scrollable Table)
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Pinned Column
                        MatchStandingsPinnedColumnWidget(
                          standingsItems: standingsItems,
                          getHighlightColor: highlightColor,
                          getQualificationColor: qualificationColor,
                        ),

                        // Horizontally Scrollable Table
                        MatchStandingsScrollableTableWidget(
                          standingsItems: standingsItems,
                          dynamicGap: dynamicGap,
                          getHighlightColor: highlightColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          if (tables.isNotEmpty && tables.first.rulesLegend.isNotEmpty) ...[
            16.h.verticalSpace,
            MatchStandingsRulesLegendWidget(
              rulesLegend: tables.first.rulesLegend,
            ),
          ],

          32.h.verticalSpace,
        ],
      ),
    );
  }
}
