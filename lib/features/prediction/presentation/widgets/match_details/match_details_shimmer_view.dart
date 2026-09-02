import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/network/errors/app_exception_message.dart';
import '../../../../../core/widgets/error_widget.dart';
import '../../provider/match_details_providers.dart';
import '../../riverpod/match_details_riverpod.dart';
import 'match_details_header_widget.dart';
import 'match_events_shimmer_widget.dart';
import 'match_tab_bar_shimmer_widget.dart';
import 'match_details_tab_header_delegate.dart';

class MatchDetailsShimmerView extends ConsumerWidget {
  final int matchId;

  const MatchDetailsShimmerView({
    super.key,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabsConfig = ref.watch(matchDetailsTabsConfigProvider(matchId));
    final bool isError = tabsConfig.isError;

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        floatHeaderSlivers: false,
        physics: const ClampingScrollPhysics(),
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
                  matchId: matchId,
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: MatchDetailsTabHeaderDelegate(
                child: const MatchTabBarShimmerWidget(),
              ),
            ),
          ];
        },
        body: isError
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
                        .read(matchDetailsProvider(matchId).notifier)
                        .getMatchDetails();
                  },
                ),
              )
            : const MatchEventsShimmerWidget(),
      ),
    );
  }
}
