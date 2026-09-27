import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../riverpod/match_details_riverpod.dart';
import '../provider/match_details_providers.dart';
import '../riverpod/match_details_websocket_notifier.dart';
import '../../../../core/network/errors/app_exception_message.dart';
import '../../../../core/widgets/error_widget.dart';
import '../widgets/match_details/match_details_header_widget.dart';
import '../widgets/match_details/match_events_shimmer_widget.dart';
import '../widgets/match_details/match_tab_bar_shimmer_widget.dart';
import '../widgets/match_details/match_details_tab_bar_widget.dart';
import '../widgets/match_details/match_details_tab_header_delegate.dart';
import '../widgets/match_details/match_events_widget.dart';
import '../widgets/match_details/match_h2h_widget.dart';
import '../widgets/match_details/match_lineups_widget.dart';
import '../widgets/match_details/match_standings_widget.dart';
import '../widgets/match_details/match_statistics_widget.dart';

class MatchDetailsPage extends ConsumerStatefulWidget {
  final int matchId;

  const MatchDetailsPage({
    super.key,
    required this.matchId,
  });

  @override
  ConsumerState<MatchDetailsPage> createState() => _MatchDetailsPageState();
}

class _TabItem {
  final String label;
  final Widget widget;
  const _TabItem(this.label, this.widget);
}

class _MatchDetailsPageState extends ConsumerState<MatchDetailsPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 5, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref
            .read(matchDetailsWebSocketProvider(widget.matchId))
            .startListening();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // When the app comes back from the background:
      // 1. Re-fetch match details & events to get missing updates
      // 2. Restart socket listening in case the OS killed the connection
      if (mounted) {
        ref
            .read(matchDetailsProvider(widget.matchId).notifier)
            .getMatchDetails(isRefresh: true);
        ref.read(matchEventsProvider(widget.matchId).notifier).getMatchEvents();
        ref
            .read(matchDetailsWebSocketProvider(widget.matchId))
            .startListening();
      }
    }
  }

  void _syncTabController(int newLength) {
    if (_tabController.length != newLength) {
      final oldIndex = _tabController.index;
      final newIndex = (oldIndex < newLength) ? oldIndex : 0;
      final oldController = _tabController;
      _tabController = TabController(
        length: newLength,
        vsync: this,
        initialIndex: newIndex,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        oldController.dispose();
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    ref.read(matchDetailsWebSocketProvider(widget.matchId)).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabsConfig =
        ref.watch(matchDetailsTabsConfigProvider(widget.matchId));

    final List<_TabItem> tabItems = [
      for (final item in tabsConfig.tabs)
        _TabItem(item.label, _buildTabWidget(item.type, widget.matchId)),
    ];

    if (!tabsConfig.isLoading && tabItems.isNotEmpty) {
      _syncTabController(tabItems.length);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        floatHeaderSlivers: false,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 140.h,
              toolbarHeight: 46.h,
              pinned: true,
              floating: false,
              snap: false,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              flexibleSpace: RepaintBoundary(
                child: MatchDetailsHeaderWidget(
                  matchId: widget.matchId,
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: MatchDetailsTabHeaderDelegate(
                child: tabsConfig.isLoading
                    ? const MatchTabBarShimmerWidget()
                    : MatchDetailsTabBarWidget(
                        controller: _tabController,
                        tabLabels: tabItems.map((tab) => tab.label).toList(),
                      ),
              ),
            ),
          ];
        },
        body: tabsConfig.isError
            ? Center(
                child: ErrorsWidget(
                  title: MessageOfError.get(
                          tabsConfig.exception as Object)
                      .first,
                  subTitle: MessageOfError.get(
                          tabsConfig.exception as Object)
                      .last,
                  onPressed: () {
                    ref
                        .read(matchDetailsProvider(widget.matchId).notifier)
                        .getMatchDetails();
                  },
                ),
              )
            : tabsConfig.isLoading
                ? const MatchEventsShimmerWidget()
                : TabBarView(
                    controller: _tabController,
                    physics: const BouncingScrollPhysics(),
                    children: tabItems.map((tab) => tab.widget).toList(),
                  ),
      ),
    );
  }

  Widget _buildTabWidget(MatchDetailTabType type, int matchId) {
    Widget child;
    switch (type) {
      case MatchDetailTabType.events:
        child = MatchEventsWidget(matchId: matchId);
        break;
      case MatchDetailTabType.lineups:
        child = MatchLineupsWidget(matchId: matchId);
        break;
      case MatchDetailTabType.standings:
        child = MatchStandingsWidget(matchId: matchId);
        break;
      case MatchDetailTabType.statistics:
        child = MatchStatisticsWidget(matchId: matchId);
        break;
      case MatchDetailTabType.h2h:
        child = MatchH2hWidget(matchId: matchId);
        break;
    }
    // RepaintBoundary isolates each tab's paint layer.
    // No KeepAlive: prevents ALL 5 tabs from relaying out on every
    // scroll frame when the header height changes. Data is preserved
    // in Riverpod providers — no API refetch occurs on tab switch.
    return RepaintBoundary(child: child);
  }
}
