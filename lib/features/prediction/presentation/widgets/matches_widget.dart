import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';

import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/league_for_prediction_model.dart';
import '../riverpod/prediction_riverpod.dart';
import 'match_card_widget.dart';
import 'matches_scope_tabs_widget.dart';
import 'shimmer_matches_widget.dart';

import '../riverpod/live_matches_websocket_notifier.dart';

class MatchesWidget extends ConsumerStatefulWidget {
  const MatchesWidget({super.key});

  @override
  ConsumerState<MatchesWidget> createState() => _MatchesWidgetState();
}

class _MatchesWidgetState extends ConsumerState<MatchesWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(liveMatchesWebSocketProvider).startListening();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (mounted) {
        final scope = ref.read(matchesScopeProvider);
        ref.read(getAllMatchesProvider(scope).notifier).getData(silent: true);
        ref.read(liveMatchesWebSocketProvider).startListening();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = ref.watch(matchesScopeProvider);
    var state = ref.watch(getAllMatchesProvider(scope));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CheckStateInGetApiDataWidget(
        state: state,
        refresh: () {
          ref.invalidate(getAllMatchesProvider(scope));
        },
        widgetOfLoading: const ShimmerMatchesWidget(),
        widgetOfData: Column(
          children: [
            10.h.verticalSpace,
            MatchesScopeTabsWidget(
              selectedScope: scope,
              onChanged: (newScope) {
                if (newScope == scope) return;
                ref.read(matchesScopeProvider.notifier).state = newScope;
              },
            ),
            const SizedBox(height: 6),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: Colors.white,
                color: AppColors.primaryColor,
                onRefresh: () async {
                  await ref
                      .read(getAllMatchesProvider(scope).notifier)
                      .getData(silent: true);
                },
                child: Builder(
                  builder: (context) {
                    // Flatten: each league becomes its own ListView item
                    final flatItems = <({String? dateHeader, LeagueForPredictionModel? league, String? leagueDate})>[];
                    for (final day in state.data) {
                      flatItems.add((dateHeader: day.date, league: null, leagueDate: null));
                      for (final league in day.leagues) {
                        flatItems.add((dateHeader: null, league: league, leagueDate: day.date));
                      }
                    }

                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 12.w)
                          .copyWith(bottom: 80.h),
                      itemCount: flatItems.length,
                      itemBuilder: (context, index) {
                        final item = flatItems[index];

                        if (item.dateHeader != null) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w)
                                .copyWith(top: 12.h),
                            child: AutoSizeTextWidget(
                              text: item.dateHeader!,
                              fontSize: 10.6.sp,
                            ),
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: MatchCardWidget(
                            data: item.league!,
                            date: item.leagueDate!,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
