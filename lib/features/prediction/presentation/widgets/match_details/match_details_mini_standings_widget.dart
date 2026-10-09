import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_details_model.dart';
import '../../../data/model/match_fixture_standings_model.dart';
import '../../provider/match_standings_ui_provider.dart';
import '../../riverpod/match_details_riverpod.dart';
import 'match_standings_cell_widget.dart';
import 'match_standings_pinned_team_logo_widget.dart';

/// Mini Standings widget displaying the 2 competing teams in the exact design
/// and layout of the main Standings table (pinned column with # and logo + horizontally scrollable table),
/// with clean white background (no tint highlights) and prominent rank numbers.
class MatchDetailsMiniStandingsWidget extends ConsumerWidget {
  final int matchId;
  final MatchDetailsModel? matchDetails;
  final VoidCallback? onViewMoreStandings;

  const MatchDetailsMiniStandingsWidget({
    super.key,
    required this.matchId,
    this.matchDetails,
    this.onViewMoreStandings,
  });

  List<MatchTeamStandingItemModel> _extractMatchTeams(
    List<MatchTeamStandingItemModel> allItems,
  ) {
    if (allItems.isEmpty) return const [];

    // 1. First attempt: match by isMatchTeam flag provided by the API
    final flaggedTeams = allItems.where((item) => item.isMatchTeam).toList();
    if (flaggedTeams.length >= 2) {
      flaggedTeams.sort((a, b) => a.position.compareTo(b.position));
      return flaggedTeams.take(2).toList();
    }

    // 2. Second attempt: match by team IDs or names from MatchDetails
    if (matchDetails?.teams != null) {
      final homeId = matchDetails!.teams?.home?.id;
      final awayId = matchDetails!.teams?.away?.id;
      final homeName = matchDetails!.teams?.home?.name.trim().toLowerCase();
      final awayName = matchDetails!.teams?.away?.name.trim().toLowerCase();

      MatchTeamStandingItemModel? homeItem;
      MatchTeamStandingItemModel? awayItem;

      for (final item in allItems) {
        final teamId = item.team?.id;
        final teamName = item.team?.name.trim().toLowerCase();

        final matchesHome = (homeId != null && teamId == homeId) ||
            (homeName != null && teamName == homeName);
        final matchesAway = (awayId != null && teamId == awayId) ||
            (awayName != null && teamName == awayName);

        if (matchesHome && homeItem == null) {
          homeItem = item;
        } else if (matchesAway && awayItem == null) {
          awayItem = item;
        }
      }

      final found = <MatchTeamStandingItemModel>[];
      if (homeItem != null) found.add(homeItem);
      if (awayItem != null) found.add(awayItem);

      if (found.length == 2) {
        found.sort((a, b) => a.position.compareTo(b.position));
        return found;
      }
      if (found.isNotEmpty) return found;
    }

    if (flaggedTeams.isNotEmpty) return flaggedTeams;
    return const [];
  }

  int _resolvePosition(
    MatchTeamStandingItemModel item,
    List<MatchTeamStandingItemModel> allItems,
  ) {
    if (item.position > 0) return item.position;
    final index = allItems.indexWhere(
      (e) =>
          (e.team?.id != null && e.team?.id == item.team?.id) ||
          (e.team?.name.isNotEmpty == true && e.team?.name == item.team?.name),
    );
    return index >= 0 ? index + 1 : 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final standingsState = ref.watch(matchStandingsProvider(matchId));

    // While loading initial standings data, render subtle 2-row shimmer
    if (standingsState.stateData == States.loading &&
        standingsState.data.tables.isEmpty) {
      return const _MiniStandingsShimmer();
    }

    // If loaded or cached, extract standings
    final standingsModel = standingsState.data;
    if (standingsModel.tables.isEmpty) {
      return const SizedBox.shrink();
    }

    final allItems =
        MatchStandingsUIHelper.flattenStandingItems(standingsModel.tables);
    final matchTeams = _extractMatchTeams(allItems);

    // If no teams found in standings (e.g. cup/knockout tournament), hide gracefully
    if (matchTeams.isEmpty) {
      return const SizedBox.shrink();
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final double dynamicGap =
        MatchStandingsUIHelper.calculateDynamicGap(screenWidth);

    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.greySwatch.shade200,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Compact Header: Title + Competition Name
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeTextWidget(
                    text: 'ترتيب الفريقين',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    colorText: AppColors.fontColor,
                  ),
                  if (standingsModel.competition != null &&
                      standingsModel.competition!.name.isNotEmpty)
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: standingsModel.competition!.name,
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w400,
                        colorText: AppColors.fontColor2,
                        maxLines: 1,
                      ),
                    ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xfff5f3f9)),

            // Table Body: Pinned Column (# + Logo) + Horizontally Scrollable Table
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Pinned Column on the right (# + Team Logo)
                  SizedBox(
                    width: 56.w,
                    child: Column(
                      children: [
                        // Pinned Header (#)
                        Container(
                          height: 32.h,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: AutoSizeTextWidget(
                            text: '#',
                            fontSize: 10.5.sp,
                            fontWeight: FontWeight.w500,
                            colorText: AppColors.fontColor2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Divider(height: 1, color: Color(0xfff5f3f9)),

                        // Pinned Rows: Rank # and Logo with clean white background
                        for (int i = 0; i < matchTeams.length; i++) ...[
                          if (i > 0)
                            const Divider(height: 1, color: Color(0xfff5f3f9)),
                          _buildPinnedRow(
                            matchTeams[i],
                            _resolvePosition(matchTeams[i], allItems),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Horizontally Scrollable Table (Team Name + لعب + +/- + نقاط + ف + ت + خ + فارق)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      child: IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Table Header
                            Container(
                              height: 32.h,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  MatchStandingsCellWidget(
                                    text: '',
                                    width: 105.w,
                                    isHeader: true,
                                  ),
                                  SizedBox(width: dynamicGap),
                                  MatchStandingsCellWidget(
                                    text: 'لعب',
                                    width: 32.w,
                                    isHeader: true,
                                  ),
                                  MatchStandingsCellWidget(
                                    text: '+/-',
                                    width: 48.w,
                                    isHeader: true,
                                  ),
                                  MatchStandingsCellWidget(
                                    text: 'نقاط',
                                    width: 36.w,
                                    isHeader: true,
                                  ),
                                  MatchStandingsCellWidget(
                                    text: 'ف',
                                    width: 28.w,
                                    isHeader: true,
                                  ),
                                  MatchStandingsCellWidget(
                                    text: 'ت',
                                    width: 28.w,
                                    isHeader: true,
                                  ),
                                  MatchStandingsCellWidget(
                                    text: 'خ',
                                    width: 28.w,
                                    isHeader: true,
                                  ),
                                  MatchStandingsCellWidget(
                                    text: 'فارق',
                                    width: 36.w,
                                    isHeader: true,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 1, color: Color(0xfff5f3f9)),

                            // Table Data Rows
                            for (int i = 0; i < matchTeams.length; i++) ...[
                              if (i > 0)
                                const Divider(
                                  height: 1,
                                  color: Color(0xfff5f3f9),
                                ),
                              _buildScrollableRow(matchTeams[i], dynamicGap),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Footer: See More Action
            if (onViewMoreStandings != null) ...[
              const Divider(height: 1, color: Color(0xfff5f3f9)),
              Material(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12.r)),
                child: InkWell(
                  onTap: onViewMoreStandings,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(12.r)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 9.h),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeTextWidget(
                            text: 'شاهد المزيد',
                            fontSize: 10.5.sp,
                            fontWeight: FontWeight.w500,
                            colorText: AppColors.primaryColor,
                          ),
                          4.w.horizontalSpace,
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 10.r,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPinnedRow(
    MatchTeamStandingItemModel item,
    int resolvedPosition,
  ) {
    final String positionStr = resolvedPosition > 0 ? '$resolvedPosition' : '-';

    return Container(
      height: 36.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Rank # (Prominent & Clear)
          SizedBox(
            width: 22.w,
            child: AutoSizeTextWidget(
              text: positionStr,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              colorText: AppColors.fontColor,
              textAlign: TextAlign.center,
            ),
          ),
          4.w.horizontalSpace,

          // Team Logo
          MatchStandingsPinnedTeamLogoWidget(
            logoUrl: item.team?.imagePath ?? '',
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableRow(
    MatchTeamStandingItemModel item,
    double dynamicGap,
  ) {
    final teamName = item.team?.name ?? '';

    return Container(
      height: 36.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      color: Colors.white,
      child: Row(
        children: [
          // Team Name
          SizedBox(
            width: 105.w,
            child: AutoSizeTextWidget(
              text: teamName,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              colorText: AppColors.fontColor,
              maxLines: 1,
            ),
          ),
          SizedBox(width: dynamicGap),

          // First 3 visible stats: لعب, +/-, نقاط
          MatchStandingsCellWidget(
            text: '${item.played}',
            width: 32.w,
            isHighlight: false,
            textColor: AppColors.fontColor,
          ),
          MatchStandingsCellWidget(
            text: '${item.goalsAgainst}:${item.goalsFor}',
            width: 48.w,
            isHighlight: false,
            textColor: AppColors.fontColor,
          ),
          MatchStandingsCellWidget(
            text: '${item.points}',
            width: 36.w,
            isHighlight: false,
            textColor: AppColors.fontColor,
          ),

          // Remaining stats visible on horizontal scroll: ف, ت, خ, فارق
          MatchStandingsCellWidget(
            text: '${item.won}',
            width: 28.w,
            isHighlight: false,
            textColor: AppColors.fontColor,
          ),
          MatchStandingsCellWidget(
            text: '${item.drawn}',
            width: 28.w,
            isHighlight: false,
            textColor: AppColors.fontColor,
          ),
          MatchStandingsCellWidget(
            text: '${item.lost}',
            width: 28.w,
            isHighlight: false,
            textColor: AppColors.fontColor,
          ),
          MatchStandingsCellWidget(
            text: '${item.goalDifference}',
            width: 36.w,
            isHighlight: false,
            textColor: AppColors.fontColor,
          ),
        ],
      ),
    );
  }
}

class _MiniStandingsShimmer extends StatelessWidget {
  const _MiniStandingsShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.greySwatch.shade200,
            width: 1,
          ),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Shimmer
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    Container(
                      width: 60.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xfff5f3f9)),

              // Table Rows Shimmer (2 compact rows)
              for (int i = 0; i < 2; i++) ...[
                if (i > 0) const Divider(height: 1, color: Color(0xfff5f3f9)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
                  child: Row(
                    children: [
                      Container(
                        width: 14.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                      6.w.horizontalSpace,
                      Container(
                        width: 18.r,
                        height: 18.r,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      8.w.horizontalSpace,
                      Container(
                        width: 70.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 90.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
