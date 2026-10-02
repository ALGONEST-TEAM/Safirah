import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/monitoring/firebase_monitoring_service.dart';
import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/design_please_login_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../services/auth/auth.dart';
import '../../data/model/league_for_prediction_model.dart';
import '../riverpod/prediction_riverpod.dart';
import 'prediction_card_widget.dart';
import 'shimmer_matches_widget.dart';

class PredictionListWidget extends ConsumerStatefulWidget {
  const PredictionListWidget({super.key});

  @override
  ConsumerState<PredictionListWidget> createState() =>
      _PredictionListWidgetState();
}

class _PredictionListWidgetState extends ConsumerState<PredictionListWidget> {
  final ScrollController _scrollController = ScrollController();
  DateTime? _lastFetchAttempt;

  @override
  void initState() {
    FirebaseMonitoringService.setCurrentScreen('PredictionList');
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (!position.hasContentDimensions) return;

    const threshold = 250.0;
    final isNearEnd = position.pixels >= (position.maxScrollExtent - threshold);

    if (isNearEnd &&
        ref.read(getAllPredictionsProvider).stateData != States.loadingMore) {
      final now = DateTime.now();
      if (_lastFetchAttempt != null &&
          now.difference(_lastFetchAttempt!).inMilliseconds < 600) {
        return; // Throttled to prevent multiple rapid duplicate calls
      }
      _lastFetchAttempt = now;
      ref.read(getAllPredictionsProvider.notifier).getData(moreData: true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getAllPredictionsProvider);

    return !Auth().loggedIn
        ? const DesignPleaseLoginWidget()
        : CheckStateInGetApiDataWidget(
            state: state,
            refresh: () {
              ref.invalidate(getAllPredictionsProvider);
            },
            widgetOfLoading: const ShimmerMatchesWidget(),
            widgetOfData: RefreshIndicator(
              backgroundColor: Colors.white,
              color: AppColors.primaryColor,
              onRefresh: () async {
                await ref
                    .read(getAllPredictionsProvider.notifier)
                    .getData(silent: true);
              },
              child: Builder(
                builder: (context) {
                  // Flatten: each league becomes its own ListView item
                  final flatItems = <({String? dateHeader, LeagueForPredictionModel? league, String? leagueDate})>[];
                  for (final day in state.data.data) {
                    flatItems.add((dateHeader: day.date, league: null, leagueDate: null));
                    for (final league in day.leagues) {
                      flatItems.add((dateHeader: null, league: league, leagueDate: day.date));
                    }
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollCacheExtent: const ScrollCacheExtent.viewport(1.0),
                    padding: EdgeInsets.symmetric(horizontal: 12.w)
                        .copyWith(bottom: 46.h),
                    itemCount: flatItems.length +
                        (state.stateData == States.loadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= flatItems.length) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: const Center(
                              child: CircularProgressIndicatorWidget()),
                        );
                      }

                      final item = flatItems[index];

                      if (item.dateHeader != null) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w)
                              .copyWith(top: 16.h),
                          child: AutoSizeTextWidget(
                            text: item.dateHeader!,
                            fontSize: 10.6.sp,
                          ),
                        );
                      }

                      return Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: PredictionCardWidget(
                          data: item.league!,
                          date: item.leagueDate!,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
  }
}
