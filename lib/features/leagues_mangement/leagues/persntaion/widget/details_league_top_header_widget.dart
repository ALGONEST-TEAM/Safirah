import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../group/presntaion/page/divide_group_page.dart';
import '../../../match/presntaion/page/matches_scheduling_page.dart';
import '../../../match/presntaion/state_managment/riverpod.dart';
import '../../../team_and_player/presntation/page/show_team_and_player_page.dart';
import '../../../team_and_player/presntation/page/teams_with_players_widget.dart';
import '../riverpod/riverpod.dart';
import 'button_of_organizer_widget.dart';

class DetailsLeagueTopHeaderWidget extends ConsumerWidget {
  const DetailsLeagueTopHeaderWidget({
    super.key,
    required this.leagueId,
  });

  final int leagueId;

  @override
  Widget build(BuildContext context,ref) {

    final detailsLeague = ref.watch(detailsLeagueProvider(leagueId));
    final scheduleGroupStageMatchesState =
    ref.watch(scheduleGroupStageMatchesRRProvider((leagueId, false)));
    final leagueStatus = ref.watch(leagueStatusProvider(leagueId));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          4.h.verticalSpace,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 6.w,
              children: [
                ButtonOfOrganizerWidget(
                  title: "الفرق واللعبين",
                  onTap: () {
                    navigateTo(
                      context,
                      leagueStatus.data!.hasPlayersInTeams
                          ? TeamsWithPlayersPage(
                              leagueId: detailsLeague.data!.id!,
                            )
                          : ShowTeamAndPlayerPage(
                              leagueId: detailsLeague.data!.id!,
                              maxTeam: detailsLeague.data!.maxTeams!,
                              maxPlayer: detailsLeague.data!.maxSubPlayers! +
                                  detailsLeague.data!.maxMainPlayers!,
                            ),
                    );
                  },
                ),
                ButtonOfOrganizerWidget(
                  title: 'تقسيم المجموعات',
                  onTap: () {
                    leagueStatus.data!.hasPlayersInTeams == false
                        ? showFlashBarError(
                            context: context,
                            title: 'اكمل عملية تقسيم اللعبين ',
                            text: 'قم باتمام تقسيم اللعبين على الفرق',
                          )
                        : navigateTo(
                            context,
                            DivideGroupPage(
                              leagueId: leagueId,
                            ),
                          );
                  },
                ),
                Visibility(
                  visible: leagueStatus.data?.hasMatches == false,
                  replacement: ButtonOfOrganizerWidget(
                    title: 'جدولة المباريات',
                    onTap: () {
                      navigateTo(
                        context,
                        MatchesSchedulingPage(
                          leagueId: leagueId,
                        ),
                      );
                    },
                  ),
                  child: CheckStateInPostApiDataWidget(
                    state: scheduleGroupStageMatchesState,
                    functionSuccess: () {
                      ref
                          .read(
                        leagueStatusUpdateProvider.notifier,
                      )
                          .update(
                        leagueId: leagueId,
                        hasMatches: true,
                      );
                      navigateTo(
                        context,
                        MatchesSchedulingPage(
                          leagueId: leagueId,
                        ),
                      );
                    },
                    bottonWidget: ButtonOfOrganizerWidget(
                      title: 'جدولة المباريات',
                      onTap: () {
                        navigateTo(
                          context,
                          MatchesSchedulingPage(
                            leagueId: leagueId,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ButtonOfOrganizerWidget(
                  title: "الداعمين",
                  onTap: () {},
                ),
                ButtonOfOrganizerWidget(
                  title: "المنظمين",
                  onTap: () {},
                ),
              ],
            ),
          ),
          14.h.verticalSpace,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 300.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/post.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                6.w.horizontalSpace,
                Container(
                  width: 300.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.h.verticalSpace,
        ],
      ),
    );
  }
}