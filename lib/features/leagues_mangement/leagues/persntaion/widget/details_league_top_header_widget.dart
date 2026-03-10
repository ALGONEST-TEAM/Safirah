import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../injection.dart' as di;
import '../../../../authorization/authorization_sync_runner.dart';
import '../../../../authorization/persntaion/pages/select_user_for_authorization_page.dart';
import '../../../../authorization/persntaion/riverpod/riverpod.dart';
import '../../../../authorization/persntaion/widgets/authorization_gate_hide_if_denied.dart';
import '../../../group/presntaion/page/divide_group_page.dart';
import '../../../match/presntaion/page/matches_scheduling_page.dart';
import '../../../match/presntaion/page/refereer_matches_page.dart';
import '../../../match/presntaion/state_managment/riverpod.dart';
import '../../../match_term_event/presntation/state_mangement/riverpod.dart';
import '../../../team_and_player/presntation/page/show_team_and_player_page.dart';
import '../../../team_and_player/presntation/page/teams_with_players_widget.dart';
import '../../data/model/league_status_model.dart';
import '../riverpod/riverpod.dart';
import 'button_of_organizer_widget.dart';

class DetailsLeagueTopHeaderWidget extends ConsumerStatefulWidget {
  const DetailsLeagueTopHeaderWidget({
    super.key,
    required this.leagueSyncId,
  });

  final String leagueSyncId;

  @override
  ConsumerState<DetailsLeagueTopHeaderWidget> createState() =>
      _DetailsLeagueTopHeaderWidgetState();
}

class _DetailsLeagueTopHeaderWidgetState
    extends ConsumerState<DetailsLeagueTopHeaderWidget> {
  @override
  void initState() {
    // TODO: implement initState
    di.sl<AuthorizationSyncRunner>().syncNow(tag: 'league_details_open');

    // Future.microtask(() {
    //
    //   ref
    //       .read(leagueStatusProvider(widget.leagueSyncId).notifier)
    //       .refresh();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final detailsLeague = ref.watch(leagueStreamProvider(widget.leagueSyncId));
    final scheduleGroupStageMatchesState = ref.watch(
        scheduleGroupStageMatchesRRProvider((widget.leagueSyncId, false)));
    ref.watch(leagueStatusProvider(widget.leagueSyncId));

    final leagueStatus =
        ref.watch(leagueStatusStreamProvider(widget.leagueSyncId));
    ref.watch(leaguePermissionsProvider(widget.leagueSyncId));

    // ref.watch(leagueStatusProvider(widget.leagueSyncId));
    //  ref.watch(usersHasRoleRefreshProvider(widget.leagueSyncId));

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
                    print(leagueStatus.asData!.value!.hasPlayersInTeams);
                    print((detailsLeague.asData!.value!.maxSubPlayers ?? 0) +
                        (detailsLeague.asData!.value!.maxMainPlayers ?? 0));
                    navigateTo(
                      context,
                      leagueStatus.asData!.value!.hasPlayersInTeams
                          ? TeamsWithPlayersPage(
                              leagueSyncId: detailsLeague.asData!.value!.syncId,
                            )
                          : AuthorizationGateHideIfDenied(
                              leagueSyncId: widget.leagueSyncId,
                              permissionKey: 'league.edit',
                              child: ShowTeamAndPlayerPage(
                                leagueSyncId:
                                    detailsLeague.asData!.value!.syncId,
                                maxTeam:
                                    detailsLeague.asData!.value!.maxTeams ?? 0,
                                maxPlayer: (detailsLeague
                                            .asData!.value!.maxSubPlayers ??
                                        0) +
                                    (detailsLeague
                                            .asData!.value!.maxMainPlayers ??
                                        0),
                                //   detailsLeague.data!.maxMainPlayers,
                              ),
                            ),
                    );
                  },
                ),
                AuthorizationGateHideIfDenied(
                  leagueSyncId: widget.leagueSyncId,
                  permissionKey: 'league.edit',
                  child: ButtonOfOrganizerWidget(
                    title: 'تقسيم المجموعات',
                    onTap: () {
                      (leagueStatus.asData?.value!.hasPlayersInTeams ??
                                  false) ==
                              false
                          ? showFlashBarError(
                              context: context,
                              title: 'اكمل عملية تقسيم اللعبين ',
                              text: 'قم باتمام تقسيم اللعبين على الفرق',
                            )
                          : navigateTo(
                              context,
                              DivideGroupPage(
                                  leagueSyncId: widget.leagueSyncId),
                            );
                    },
                  ),
                ),
                AuthorizationGateHideIfDenied(
                  leagueSyncId: widget.leagueSyncId,
                  permissionKey: 'match.manage',
                  child: Visibility(
                    visible: leagueStatus.asData?.value!.hasMatches == false,
                    replacement: ButtonOfOrganizerWidget(
                      title: 'ادارة المباريات',
                      onTap: () {
                        navigateTo(
                          context,
                          RefereeMatchesPage(
                            role: 'referrer',
                            leagueSyncId: widget.leagueSyncId,
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
                              leagueSyncId: widget.leagueSyncId,
                              hasMatches: true,
                            );
                        //  ref.read(leagueStatusStreamProvider(widget.leagueSyncId));
                        ref
                            .read(leagueStatusProvider(widget.leagueSyncId)
                                .notifier)
                            .refresh();
                        navigateTo(
                          context,
                          RefereeMatchesPage(
                            role: 'referrer',
                            leagueSyncId: widget.leagueSyncId,
                          ),
                        );
                      },
                      bottonWidget: ButtonOfOrganizerWidget(
                        title: 'جدولة المباريات',
                        onTap: () {
                          navigateTo(
                            context,
                            RefereeMatchesPage(
                              role: 'referrer',
                              leagueSyncId: widget.leagueSyncId,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: leagueStatus.asData?.value!.hasMatches == false,
                  replacement: ButtonOfOrganizerWidget(
                    title: 'جدولة المباريات',
                    onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ref
                              .read(ensureKnockoutProgressProvider(
                                      widget.leagueSyncId)
                                  .notifier)
                              .run(qualifiedPerGroup: 4);
                        });
                      navigateTo(
                        context,
                        MatchesSchedulingPage(
                          role: 'organizer',
                          leagueSyncId: widget.leagueSyncId,
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
                            leagueSyncId: widget.leagueSyncId,
                            hasMatches: true,
                          );
                      //  ref.read(leagueStatusStreamProvider(widget.leagueSyncId));
                      ref
                          .read(leagueStatusProvider(widget.leagueSyncId)
                              .notifier)
                          .refresh();
                      navigateTo(
                        context,
                        MatchesSchedulingPage(
                          role: 'organizer',
                          leagueSyncId: widget.leagueSyncId,
                        ),
                      );
                    },
                    bottonWidget: ButtonOfOrganizerWidget(
                      title: 'جدولة المباريات',
                      onTap: () {
                        navigateTo(
                          context,
                          MatchesSchedulingPage(
                            role: 'organizer',
                            leagueSyncId: widget.leagueSyncId,
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
                  onTap: () {
                    navigateTo(
                        context,
                        SelectUserForAuthorizationPage(
                          leagueSyncId: widget.leagueSyncId,
                        ));
                  },
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
                // Container(
                //   width: 300.w,
                //   height: 100.h,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12.r),
                //     image: const DecorationImage(
                //       image: AssetImage('assets/images/logo.png'),
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          10.h.verticalSpace,
        ],
      ),
    );
  }
}
