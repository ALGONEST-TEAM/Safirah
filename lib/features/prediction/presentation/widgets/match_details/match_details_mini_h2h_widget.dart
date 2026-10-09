import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../data/model/match_details_model.dart';
import '../../riverpod/match_details_riverpod.dart';

/// Mini Head-to-Head Comparison card displaying overall wins and draws
/// between the two competing teams in the first tab of match details.
class MatchDetailsMiniH2HWidget extends ConsumerWidget {
  final int matchId;
  final MatchDetailsModel? matchDetails;
  final VoidCallback? onViewMoreH2H;

  const MatchDetailsMiniH2HWidget({
    super.key,
    required this.matchId,
    this.matchDetails,
    this.onViewMoreH2H,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final h2hState = ref.watch(matchH2HProvider(matchId));

    // While loading initial H2H data, show lightweight shimmer
    if (h2hState.stateData == States.loading &&
        h2hState.data.summary == null) {
      return const _MiniH2HShimmer();
    }

    final h2hData = h2hState.data;

    final summary = h2hData.summary;
    final homeLogo = h2hData.teams?.home?.imagePath.isNotEmpty == true
        ? h2hData.teams!.home!.imagePath
        : (matchDetails?.teams?.home?.logo ?? '');
    final awayLogo = h2hData.teams?.away?.imagePath.isNotEmpty == true
        ? h2hData.teams!.away!.imagePath
        : (matchDetails?.teams?.away?.logo ?? '');

    final int homeWins = summary?.homeTeamWins ?? 0;
    final int draws = summary?.draws ?? 0;
    final int awayWins = summary?.awayTeamWins ?? 0;

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
            // Header: Title ("المقارنة")
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              ),
              child: AutoSizeTextWidget(
                text: 'المواجهات المباشرة',
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                colorText: AppColors.fontColor,
              ),
            ),

            const Divider(height: 1, color: Color(0xfff5f3f9)),

            // Body: Home Logo | Home Wins | Draws | Away Wins | Away Logo
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  // Home Team Logo (Right in RTL)
                  OnlineImagesWidget(
                    imageUrl: homeLogo,
                    size: Size(44.r, 44.r),
                    circularImage: true,
                    fit: BoxFit.contain,
                    backgroundColor: Colors.transparent,
                  ),

                  // Middle Section: 3 Stat Columns with Vertical Dividers
                  Expanded(
                    child: Row(
                      children: [
                        // Home Team Wins
                        Expanded(
                          child: _buildStatItem(
                            value: '$homeWins',
                            label: 'انتصارات',
                          ),
                        ),

                        // Vertical Divider 1
                        Container(
                          width: 1,
                          height: 28.h,
                          color: const Color(0xfff0edf5),
                        ),

                        // Draws
                        Expanded(
                          child: _buildStatItem(
                            value: '$draws',
                            label: 'تعادلات',
                          ),
                        ),

                        // Vertical Divider 2
                        Container(
                          width: 1,
                          height: 28.h,
                          color: const Color(0xfff0edf5),
                        ),

                        // Away Team Wins
                        Expanded(
                          child: _buildStatItem(
                            value: '$awayWins',
                            label: 'انتصارات',
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Away Team Logo (Left in RTL)
                  OnlineImagesWidget(
                    imageUrl: awayLogo,
                    size: Size(44.r, 44.r),
                    circularImage: true,
                    fit: BoxFit.contain,
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
            ),

            // Footer: "شاهد المزيد" Action to switch to H2H tab
            if (onViewMoreH2H != null) ...[
              const Divider(height: 1, color: Color(0xfff5f3f9)),
              Material(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12.r)),
                child: InkWell(
                  onTap: onViewMoreH2H,
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
                            fontSize: 11.sp,
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

  Widget _buildStatItem({
    required String value,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AutoSizeTextWidget(
          text: value,
          fontSize: 16.5.sp,
          fontWeight: FontWeight.w600,
          colorText: AppColors.fontColor,
          textAlign: TextAlign.center,
        ),
        3.h.verticalSpace,
        AutoSizeTextWidget(
          text: label,
          fontSize: 10.5.sp,
          fontWeight: FontWeight.w400,
          colorText: AppColors.fontColor2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _MiniH2HShimmer extends StatelessWidget {
  const _MiniH2HShimmer();

  @override
  Widget build(BuildContext context) {
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
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                child: Container(
                  width: 60.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              const Divider(height: 1, color: Color(0xfff5f3f9)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 44.r,
                      height: 44.r,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 32.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    Container(
                      width: 32.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    Container(
                      width: 32.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    Container(
                      width: 44.r,
                      height: 44.r,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
