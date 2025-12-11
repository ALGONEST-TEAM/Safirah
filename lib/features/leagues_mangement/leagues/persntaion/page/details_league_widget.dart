import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../match/presntaion/widget/matches_schedule_widget.dart';
import '../widget/details_league_tabbar_widget.dart';
import '../widget/details_league_top_header_widget.dart';
import '../widget/list_ranking_group_widget.dart';
class DetailsLeagueWidget extends ConsumerStatefulWidget {
  const DetailsLeagueWidget({super.key, required this.leagueId});
  final int leagueId;
  @override
  ConsumerState<DetailsLeagueWidget> createState() =>
      _DetailsLeagueWidgetState();
}

class _DetailsLeagueWidgetState extends ConsumerState<DetailsLeagueWidget>
    with SingleTickerProviderStateMixin {
  late final TabController controller;
  final List<String> tabTitle = ['المراكز', 'المباريات', 'اخبار', 'احصائيات'];

  @override
  void initState() {
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
                leagueId: widget.leagueId,
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
              leagueId: widget.leagueId,
            ),
            MatchesScheduleWidget(
              leagueId: widget.leagueId,
              matchFilter: 'scheduled,live,finished',
            ),
            MatchesScheduleWidget(
              leagueId: widget.leagueId,
              matchFilter: 'scheduled,live,finished',
            ),
            MatchesScheduleWidget(
              leagueId: widget.leagueId,
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