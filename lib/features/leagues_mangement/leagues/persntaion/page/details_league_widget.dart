import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../authorization/authorization_service.dart';
import '../../../match/presntaion/widget/matches_schedule_widget.dart';
import '../riverpod/riverpod.dart';
import '../widget/details_league_tabbar_widget.dart';
import '../widget/details_league_top_header_widget.dart';
import '../widget/list_ranking_group_widget.dart';

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
    ref.watch(leagueBundleRefreshProvider(widget.leagueSyncId)); // يعمل sync فورًا
  //  final league = ref.watch(leagueStreamProvider(leagueSyncId));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const AutoSizeTextWidget(
          text:  'تفاصيل الدوري',
          colorText: Colors.white,
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerScrolled) {
          return [
            SliverToBoxAdapter(
              child:DetailsLeagueTopHeaderWidget(
                leagueSyncId: widget.leagueSyncId,
              ),

            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarSliverDelegate(
                child: Material(
                  color: Colors.white,
                  child: DetailsLeagueTabBarWidget(
                    controller: controller,
                    tabTitle: tabTitle,
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: controller,
          children: [
            ListRankingGroupWidget(
              leagueSyncId:widget.leagueSyncId,
            ),
            MatchesScheduleWidget(
              role: 'organizer',
              leagueSyncId: widget.leagueSyncId,
              matchFilter: 'scheduled,live,finished',
            ),
            MatchesScheduleWidget(
              role: 'organizer',

              leagueSyncId: widget.leagueSyncId,
              matchFilter: 'scheduled,live,finished',
            ),
            MatchesScheduleWidget(
              role: 'organizer',

              leagueSyncId: widget.leagueSyncId,
              matchFilter: 'scheduled,live,finished',
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBarSliverDelegate extends SliverPersistentHeaderDelegate {
  _TabBarSliverDelegate({required this.child});

  final Widget child;

  @override
  double get minExtent => 56.0;

  @override
  double get maxExtent => 56.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _TabBarSliverDelegate oldDelegate) {
    return false;
  }
}