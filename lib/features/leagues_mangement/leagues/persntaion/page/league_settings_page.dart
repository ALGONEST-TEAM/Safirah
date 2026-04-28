import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safirah/features/leagues_mangement/leagues/persntaion/page/reporter_matches_page.dart';
import 'package:safirah/features/leagues_mangement/leagues/persntaion/page/show_rule_league_page.dart';
import '../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../injection.dart' as di;
import '../../../../authorization/authorization_sync_runner.dart';
import '../../../../authorization/persntaion/pages/select_user_for_authorization_page.dart';
import '../../../../authorization/persntaion/riverpod/riverpod.dart';
import '../../../../authorization/persntaion/widgets/authorization_gate_hide_if_denied.dart';
import '../../../group/presntaion/page/divide_group_page.dart';
import '../../../match/presntaion/page/matches_scheduling_page.dart';
import '../../../match/presntaion/page/refereer_matches_page.dart';
import '../../../match_term_event/presntation/page/initialization_term_page.dart';
import '../../../match_term_event/presntation/state_mangement/riverpod.dart';
import '../../../team_and_player/presntation/page/show_team_and_player_page.dart';
import '../../../team_and_player/presntation/page/teams_with_players_widget.dart';
import '../riverpod/riverpod.dart';
import '../widget/button_of_organizer_widget.dart';

class LeagueSettingsPage extends ConsumerStatefulWidget {
  const LeagueSettingsPage({super.key, required this.leagueSyncId});

  final String leagueSyncId;

  @override
  ConsumerState<LeagueSettingsPage> createState() => _LeagueSettingsPageState();
}

class _LeagueSettingsPageState extends ConsumerState<LeagueSettingsPage> {
  @override
  void initState() {
    // TODO: implement initState
    di.sl<AuthorizationSyncRunner>().syncNow(tag: 'league_details_open');
    Future.microtask(() {
      ref
          .read(leagueBundleRefreshProvider(widget.leagueSyncId).notifier)
          .refresh(); // يعمل sync فورًا
    });

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
    ref.watch(leagueStatusProvider(widget.leagueSyncId));

    final leagueStatus =
        ref.watch(leagueStatusStreamProvider(widget.leagueSyncId));
    ref.watch(leaguePermissionsProvider(widget.leagueSyncId));
    final leaguePermissions = ref.watch(leaguePermissionsProvider(widget.leagueSyncId));
    final canEditLeague = leaguePermissions.asData?.value.contains('league.edit') ?? false;

    // ref.watch(leagueStatusProvider(widget.leagueSyncId));
    //  ref.watch(usersHasRoleRefreshProvider(widget.leagueSyncId));
    //print(teamState.asData!.value[0].teamName);
    return Scaffold(
      appBar: const SecondaryAppBarWidget(
        title: 'اعدادات الدوري',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ButtonOfOrganizerWidget(
            title: "الفرق واللعبين",
            onTap: () {
              final details = detailsLeague.asData?.value;
              final status = leagueStatus.asData?.value;
              if (details == null || status == null) return;

              navigateTo(
                context,
                status.hasPlayersInTeams || !canEditLeague
                    ? TeamsWithPlayersPage(
                        leagueSyncId: details.syncId,
                      )
                    : ShowTeamAndPlayerPage(
                        leagueSyncId: details.syncId,
                        maxTeam: details.maxTeams ?? 0,
                        maxPlayer: (details.maxSubPlayers ?? 0) +
                            (details.maxMainPlayers ?? 0),
                        //   detailsLeague.data!.maxMainPlayers,
                      ),
              );
            },
          ),
          Visibility(
            visible: (leagueStatus.asData?.value!.hasGroups ?? false) == false,
            child: AuthorizationGateHideIfDenied(
              leagueSyncId: widget.leagueSyncId,
              permissionKey: 'league.edit',
              child: ButtonOfOrganizerWidget(
                title: 'تقسيم المجموعات',
                onTap: () {
                  (leagueStatus.asData?.value!.hasPlayersInTeams ?? false) ==
                          false
                      ? showFlashBarError(
                          context: context,
                          title: 'اكمل عملية تقسيم اللعبين ',
                          text: 'قم باتمام تقسيم اللعبين على الفرق',
                        )
                      : navigateTo(
                          context,
                          DivideGroupPage(leagueSyncId: widget.leagueSyncId),
                        );
                },
              ),
            ),
          ),
          AuthorizationGateHideIfDenied(
            leagueSyncId: widget.leagueSyncId,
            permissionKey: 'match.manage',
            child: ButtonOfOrganizerWidget(
              title: 'ادارة المباريات',
              onTap: () {
                navigateTo(
                  context,
                  RefereeMatchesPage(
                    role: 'Referee',
                    leagueSyncId: widget.leagueSyncId,
                  ),
                );
              },
            ),
          ),
          AuthorizationGateHideIfDenied(
            leagueSyncId: widget.leagueSyncId,
            permissionKey: 'match.report',
            child: ButtonOfOrganizerWidget(
              title: 'ادارة التقارير',
              onTap: () {
                navigateTo(
                  context,
                  ReporterMatchesPage(
                    role: 'Media',
                    leagueSyncId: widget.leagueSyncId,
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: (leagueStatus.asData?.value!.hasMatches ?? false) == false,
            child: AuthorizationGateHideIfDenied(
              leagueSyncId: widget.leagueSyncId,
              permissionKey: 'league.edit',
              child: ButtonOfOrganizerWidget(
                title: "تهيئة الاشواط",
                onTap: () {
                  (leagueStatus.asData?.value!.hasGroups ?? false) == false
                      ? showFlashBarError(
                          context: context,
                          title: 'اكمل عملية تقسيم المجموعات ',
                          text: 'قم باتمام تقسيم الفرق على المجموعات',
                        )
                      : navigateTo(
                          context,
                          LeagueTermSetupPage(
                            leagueSyncId: widget.leagueSyncId,
                          ));
                },
              ),
            ),
          ),
          // AuthorizationGateHideIfDenied(
          //   leagueSyncId: widget.leagueSyncId,
          //   permissionKey: 'league.edit',
          //   child: Visibility(
          //     visible: leagueStatus.asData?.value!.hasMatches == false,
          //     replacement: ButtonOfOrganizerWidget(
          //       title: 'جدولة المباريات',
          //       onTap: () {
          //         print('2222222222222222222222222222222222222');
          //         (leagueStatus.asData?.value!.hasGroups ?? false) == false
          //             ? showFlashBarError(
          //                 context: context,
          //                 title: 'اكمل كل عمليات انشاء الدوري  ',
          //                 text:
          //                     'قم باتمام كل عمليات انشاء الدوري لبدا جدولة المباريات',
          //               )
          //             : WidgetsBinding.instance.addPostFrameCallback((_) {
          //                 ref
          //                     .read(ensureKnockoutProgressProvider(
          //                             widget.leagueSyncId)
          //                         .notifier)
          //                     .run(qualifiedPerGroup: 4);
          //               });
          //         navigateTo(
          //           context,
          //           MatchesSchedulingPage(
          //             role: 'organizer',
          //             leagueSyncId: widget.leagueSyncId,
          //           ),
          //         );
          //       },
          //     ),
          //     child: CheckStateInPostApiDataWidget(
          //       state: scheduleGroupStageMatchesState,
          //       functionSuccess: () {
          //         ref
          //             .read(
          //               leagueStatusUpdateProvider.notifier,
          //             )
          //             .update(
          //               leagueSyncId: widget.leagueSyncId,
          //               hasMatches: true,
          //             );
          //         //  ref.read(leagueStatusStreamProvider(widget.leagueSyncId));
          //         ref
          //             .read(leagueStatusProvider(widget.leagueSyncId).notifier)
          //             .refresh();
          //       },
          //       bottonWidget: ButtonOfOrganizerWidget(
          //         title: 'جدولة المباريات',
          //         onTap: () {
          //           navigateTo(
          //             context,
          //             MatchesSchedulingPage(
          //               role: 'organizer',
          //               leagueSyncId: widget.leagueSyncId,
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          AuthorizationGateHideIfDenied(
            leagueSyncId: widget.leagueSyncId,
            permissionKey: 'league.edit',
            child: Visibility(
              child: ButtonOfOrganizerWidget(
                title: 'جدولة المباريات',
                onTap: () {
                  if ((leagueStatus.asData?.value!.hasMatches ?? false) ==
                      false) {
                    showFlashBarError(
                      context: context,
                      title: 'اكمل كل عمليات انشاء الدوري  ',
                      text:
                          'قم باتمام كل عمليات انشاء الدوري لبدا جدولة المباريات',
                    );
                  } else {
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
                  }
                },
              ),
            ),
          ),
          ButtonOfOrganizerWidget(
            title: "الداعمين",
            onTap: () {},
          ),
          ButtonOfOrganizerWidget(
            title: "قواعد الدوري",
            onTap: () {
              navigateTo(
                  context,
                  ShowRuleLeaguePage(
                    leagueSyncId: widget.leagueSyncId,
                  ));
            },
          ),
          AuthorizationGateHideIfDenied(
            leagueSyncId: widget.leagueSyncId,
            permissionKey: 'league.edit',
            child: ButtonOfOrganizerWidget(
              title: "المنظمين",
              onTap: () {
                navigateTo(
                    context,
                    SelectUserForAuthorizationPage(
                      leagueSyncId: widget.leagueSyncId,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
