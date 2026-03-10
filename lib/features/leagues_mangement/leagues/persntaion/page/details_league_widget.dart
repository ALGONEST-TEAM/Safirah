import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import 'package:safirah/features/profile/presentation/pages/settings_page.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../authorization/authorization_service.dart';
import '../../../home/presntation/pages/latest_news_page.dart';
import '../../../match/presntaion/page/matches_in_details_league_page.dart';
import '../../../match/presntaion/widget/matches_schedule_widget.dart';
import '../../../team_and_player/data/model/team_model.dart';
import '../../../team_and_player/presntation/page/league_player_stats_page.dart';
import '../../../team_and_player/presntation/state_mangment/riverpod.dart';
import '../widget/details_league_tabbar_widget.dart';
import '../widget/list_ranking_group_widget.dart';
import 'latest_news_league_page.dart';
import 'league_settings_page.dart';

class DetailsLeagueWidget extends ConsumerStatefulWidget {
  const DetailsLeagueWidget({super.key, required this.leagueSyncId});
  final String leagueSyncId;
  @override
  ConsumerState<DetailsLeagueWidget> createState() =>
      _DetailsLeagueWidgetState();
}

class _DetailsLeagueWidgetState extends ConsumerState<DetailsLeagueWidget>
    with SingleTickerProviderStateMixin {
  late final TabController controller;
  final List<String> tabTitle = ['المراكز', 'المباريات', 'اخبار', 'احصائيات'];
  late final AuthorizationService service;

  @override
  void initState() {
    Future.microtask(() {

      ref.read(teamsRefreshProvider(widget.leagueSyncId).notifier).refresh();

    });
    // Future.microtask(() async {
    //   await service.syncUserAccessForAllLeagues();
    //
    // });
    // Future.microtask(() {
    //
    //   ref
    //       .read(leagueStatusProvider(widget.leagueSyncId).notifier)
    //       .refresh();
    // });
    super.initState();
    controller = TabController(length: tabTitle.length, vsync: this);
    controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
  //  final league = ref.watch(leagueStreamProvider(leagueSyncId));

    return Scaffold(
        appBar: SecondaryAppBarWidget(
          title: 'تفاصيل الدوري',
          actions: [
            IconButton(onPressed: (){
              navigateTo(context, LeagueSettingsPage(leagueSyncId: widget.leagueSyncId,));
            }, icon:  Icon(Icons.settings))
          ],
        ),
        body: Column(
          children: [
            DetailsLeagueTabBarWidget(
              controller: controller,
              tabTitle: tabTitle,
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  ListRankingGroupWidget(
                    leagueSyncId:widget.leagueSyncId,
                  ),
                  MatchesInDetailsLeaguePage(
                    role: 'organizer',
                    leagueSyncId: widget.leagueSyncId,
                    matchFilter: 'scheduled,live,finished',
                  ),
                  LatestNewsLeaguePage(
                    leagueSyncId: widget.leagueSyncId,
                  ),
                  LeaguePlayerStatsPage(
                    leagueSyncId: widget.leagueSyncId,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
   // );
  }
}

