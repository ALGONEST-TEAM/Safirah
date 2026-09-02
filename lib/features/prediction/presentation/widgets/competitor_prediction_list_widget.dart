import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../riverpod/prediction_riverpod.dart';
import 'prediction_card_widget.dart';
import 'shimmer_matches_widget.dart';

class CompetitorPredictionListWidget extends ConsumerStatefulWidget {
  final int competitorId;

  const CompetitorPredictionListWidget({
    super.key,
    required this.competitorId,
  });

  @override
  ConsumerState<CompetitorPredictionListWidget> createState() =>
      _CompetitorPredictionListWidgetState();
}

class _CompetitorPredictionListWidgetState extends ConsumerState<CompetitorPredictionListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    const threshold = 200.0;

    final position = _scrollController.position;
    final isNearEnd = position.pixels >= (position.maxScrollExtent - threshold);

    if (isNearEnd &&
        ref.read(getCompetitorPredictionsProvider(widget.competitorId)).stateData != States.loadingMore) {
      ref.read(getCompetitorPredictionsProvider(widget.competitorId).notifier).getData(moreData: true);
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
    var state = ref.watch(getCompetitorPredictionsProvider(widget.competitorId));

    return CheckStateInGetApiDataWidget(
      state: state,
      refresh: () {
        ref.invalidate(getCompetitorPredictionsProvider(widget.competitorId));
      },
      widgetOfLoading: const ShimmerMatchesWidget(),
      widgetOfData: RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primaryColor,
        onRefresh: () async {
          ref.invalidate(getCompetitorPredictionsProvider(widget.competitorId));
        },
        child: ListView.builder(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 12.w)
              .copyWith(bottom: 46.h),
          itemCount: state.data.data.length +
              (state.stateData == States.loadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            final isLoaderItem = index >= state.data.data.length;
            if (isLoaderItem) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(
                    child: CircularProgressIndicatorWidget()),
              );
            }

            final day = state.data.data[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w)
                      .copyWith(top: 16.h),
                  child: AutoSizeTextWidget(
                    text: day.date,
                    fontSize: 10.6.sp,
                  ),
                ),
                ...day.leagues.map(
                  (league) => Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: PredictionCardWidget(
                      data: league,
                      date: day.date,
                      isCompetitor: true, // Hide edit buttons
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
