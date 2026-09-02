import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../data/model/match_h2h_model.dart';
import '../../provider/match_details_providers.dart';
import 'match_h2h_filter_segment_tab_widget.dart';
import 'match_h2h_segment_divider_widget.dart';
import 'match_h2h_team_logo_widget.dart';

class MatchH2hContentWidget extends StatelessWidget {
  final int matchId;
  final MatchH2hModel h2hData;
  final MatchH2hUIState h2hUI;
  final Color homeColor;
  final Color awayColor;

  const MatchH2hContentWidget({
    super.key,
    required this.matchId,
    required this.h2hData,
    required this.h2hUI,
    required this.homeColor,
    required this.awayColor,
  });

  @override
  Widget build(BuildContext context) {
    final homeTeam = h2hUI.teams?.home ?? h2hData.teams?.home;
    final awayTeam = h2hUI.teams?.away ?? h2hData.teams?.away;
    final summary = h2hUI.summary ?? h2hData.summary;
    final filteredFixtures = h2hUI.filteredFixtures;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
        ),
        child: Column(
          children: [
            // Top Summary Section
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Home Team (Right side in RTL)
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MatchH2hTeamLogoWidget(
                            logoUrl: homeTeam?.imagePath,
                            size: 32.w,
                            fallbackColor: const Color(0xff004d98),
                          ),
                          12.w.horizontalSpace,
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: homeColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: AutoSizeTextWidget(
                              text: '${summary?.homeTeamWins ?? 0}',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              colorText: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      12.h.verticalSpace,
                      AutoSizeTextWidget(
                        text: 'الفوز',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        colorText: AppColors.fontColor,
                      ),
                    ],
                  ),

                  // Draws (Center)
                  Column(
                    children: [
                      AutoSizeTextWidget(
                        text: '${summary?.draws ?? 0}',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        colorText: AppColors.fontColor,
                      ),
                      12.h.verticalSpace,
                      AutoSizeTextWidget(
                        text: 'التعادلات',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        colorText: AppColors.fontColor,
                      ),
                    ],
                  ),

                  // Away Team (Left side in RTL)
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: awayColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: AutoSizeTextWidget(
                              text: '${summary?.awayTeamWins ?? 0}',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              colorText: Colors.white,
                            ),
                          ),
                          12.w.horizontalSpace,
                          MatchH2hTeamLogoWidget(
                            logoUrl: awayTeam?.imagePath,
                            size: 32.w,
                            fallbackColor: const Color(0xff00508f),
                          ),
                        ],
                      ),
                      12.h.verticalSpace,
                      AutoSizeTextWidget(
                        text: 'الفوز',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        colorText: AppColors.fontColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xfff5f3f9)),

            // 3-Segment Control Filters Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                      color: AppColors.greySwatch.shade200, width: 1),
                ),
                child: Row(
                  children: [
                    // Right: Home Team Ground Filter (index 0)
                    Expanded(
                      child: MatchH2hFilterSegmentTabWidget(
                        matchId: matchId,
                        title: homeTeam?.name ?? 'المستضيف',
                        index: 0,
                        selectedIndex: h2hUI.selectedFilterIndex,
                      ),
                    ),
                    const MatchH2hSegmentDividerWidget(),

                    // Center: "الكل" Filter (index 1 - default)
                    Expanded(
                      child: MatchH2hFilterSegmentTabWidget(
                        matchId: matchId,
                        title: 'الكل',
                        index: 1,
                        selectedIndex: h2hUI.selectedFilterIndex,
                      ),
                    ),
                    const MatchH2hSegmentDividerWidget(),

                    // Left: Away Team Ground Filter (index 2)
                    Expanded(
                      child: MatchH2hFilterSegmentTabWidget(
                        matchId: matchId,
                        title: awayTeam?.name ?? 'الضيف',
                        index: 2,
                        selectedIndex: h2hUI.selectedFilterIndex,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Divider(height: 1, color: Color(0xfff5f3f9)),

            // Matches List
            if (filteredFixtures.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Center(
                  child: AutoSizeTextWidget(
                    text: 'لا توجد مواجهات مباشرة سابقة',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    colorText: AppColors.fontColor2,
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredFixtures.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, color: Color(0xfff5f3f9)),
                itemBuilder: (context, index) {
                  final fixture = filteredFixtures[index];
                  final fixtureHome = fixture.homeTeam;
                  final fixtureAway = fixture.awayTeam;
                  final leagueName = fixture.league?.name ??
                      h2hData.match?.competition?.name ??
                      '';
                  final leagueLogo = fixture.league?.imagePath ??
                      h2hData.match?.competition?.imagePath ??
                      '';

                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      children: [
                        // Top row: Date and Competition
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeTextWidget(
                              text: fixture.date,
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w500,
                              colorText: AppColors.fontColor3,
                            ),
                            Row(
                              children: [
                                AutoSizeTextWidget(
                                  text: leagueName,
                                  fontSize: 11.5.sp,
                                  fontWeight: FontWeight.w500,
                                  colorText: AppColors.fontColor3,
                                ),
                                8.w.horizontalSpace,
                                if (leagueLogo.isNotEmpty)
                                  OnlineImagesWidget(
                                    imageUrl: leagueLogo,
                                    size: Size(16.w, 16.w),
                                    backgroundColor: Colors.transparent,
                                    fit: BoxFit.contain,
                                  ),
                              ],
                            ),
                          ],
                        ),
                        16.h.verticalSpace,

                        // Bottom row: Score and Teams
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Home Team (Right)
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: AutoSizeTextWidget(
                                      text: fixtureHome?.name ?? '',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      colorText: AppColors.fontColor,
                                      maxLines: 1,
                                      minFontSize: 9,
                                    ),
                                  ),
                                  8.w.horizontalSpace,
                                  MatchH2hTeamLogoWidget(
                                    logoUrl: fixtureHome?.imagePath,
                                    size: 18.w,
                                    fallbackColor: const Color(0xff004d98),
                                  ),
                                ],
                              ),
                            ),

                            // Score (Center)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: AutoSizeTextWidget(
                                text:
                                    '${fixture.homeScore} - ${fixture.awayScore}',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                colorText: AppColors.fontColor,
                              ),
                            ),

                            // Away Team (Left)
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MatchH2hTeamLogoWidget(
                                    logoUrl: fixtureAway?.imagePath,
                                    size: 18.w,
                                    fallbackColor: const Color(0xff00508f),
                                  ),
                                  8.w.horizontalSpace,
                                  Flexible(
                                    child: AutoSizeTextWidget(
                                      text: fixtureAway?.name ?? '',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      colorText: AppColors.fontColor,
                                      maxLines: 1,
                                      minFontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
