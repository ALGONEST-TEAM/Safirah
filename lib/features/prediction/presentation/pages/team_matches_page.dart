import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';
import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../data/model/team_matches_model.dart';
import '../riverpod/team_matches_riverpod.dart';
import '../widgets/team_details/team_details_header_widget.dart';
import '../widgets/team_details/team_matches_list_widget.dart';
import '../widgets/team_details/team_matches_shimmer_view.dart';

class TeamMatchesPage extends ConsumerStatefulWidget {
  final int teamId;

  const TeamMatchesPage({
    super.key,
    required this.teamId,
  });

  @override
  ConsumerState<TeamMatchesPage> createState() => _TeamMatchesPageState();
}

class _TeamMatchesPageState extends ConsumerState<TeamMatchesPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teamMatchesProvider(widget.teamId));

    // Prepare fallback info based on passed arguments
    final fallbackInfo = TeamMatchTeamInfo(
      id: widget.teamId,
      sportmonksId: 0,
      name: '',
      shortCode: '',
      imagePath: '',
      coachName: null,
      leagueName: null,
      leagueLogo: null,
    );

    // Merge API data with fallback data if API data is missing fields
    TeamMatchTeamInfo displayInfo = fallbackInfo;
    if (state.stateData == States.loaded && state.data.team.id != 0) {
      displayInfo = state.data.team;
    }

    if (state.stateData == States.initial || state.stateData == States.loading) {
      return const TeamMatchesShimmerView();
    }

    final String? resolvedLeagueName = displayInfo.leagueName ??
        (state.data.previous.isNotEmpty ? state.data.previous.first.league.name : null) ??
        (state.data.upcoming.isNotEmpty ? state.data.upcoming.first.league.name : null);

    final String? resolvedLeagueLogo = displayInfo.leagueLogo ??
        (state.data.previous.isNotEmpty ? state.data.previous.first.league.imagePath : null) ??
        (state.data.upcoming.isNotEmpty ? state.data.upcoming.first.league.imagePath : null);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: NestedScrollView(
        floatHeaderSlivers: false,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 100.h,
              toolbarHeight: 40.h,
              pinned: true,
              floating: false,
              snap: false,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              flexibleSpace: RepaintBoundary(
                child: TeamDetailsHeaderWidget(
                  teamInfo: displayInfo,
                  onBack: () => Navigator.pop(context),
                ),
              ),
            ),
            if (resolvedLeagueName != null && resolvedLeagueName.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.fontColor2.withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (resolvedLeagueLogo != null && resolvedLeagueLogo.isNotEmpty) ...[
                          OnlineImagesWidget(
                            imageUrl: resolvedLeagueLogo,
                            backgroundColor: Colors.transparent,
                            size: Size(24.w, 24.h),
                          ),
                        ] else ...[
                          Icon(
                            Icons.emoji_events,
                            color: AppColors.primaryColor,
                            size: 20.sp,
                          ),
                        ],
                        8.w.horizontalSpace,
                        AutoSizeTextWidget(
                          text: resolvedLeagueName,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          colorText: AppColors.mainColorFont,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ];
        },
        body: CheckStateInGetApiDataWidget(
          state: state,
          refresh: () => ref.read(teamMatchesProvider(widget.teamId).notifier).getTeamMatches(),
          widgetOfData: state.stateData == States.loaded
              ? TeamMatchesListWidget(
                data: state.data,
              )
              : const SizedBox(),
        ),
      ),
    );
  }
}
