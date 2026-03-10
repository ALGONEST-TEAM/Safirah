import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/logo_shimmer_widget.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../home/presntation/riverpod/home_riverpod.dart';
import '../../../home/presntation/widgets/latest_news_card_widget.dart';
import '../riverpod/riverpod.dart';
import '../widget/report_card_widget.dart';

class LatestNewsLeaguePage extends ConsumerStatefulWidget {
  const LatestNewsLeaguePage({super.key,required this.leagueSyncId});
  final String leagueSyncId;
  @override
  ConsumerState<LatestNewsLeaguePage> createState() => _LatestNewsPageState();
}

class _LatestNewsPageState extends ConsumerState<LatestNewsLeaguePage> {
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
        ref.read(getAllLatestNewsLeagueProvider(widget.leagueSyncId)).stateData != States.loadingMore) {
      ref.read(getAllLatestNewsLeagueProvider(widget.leagueSyncId).notifier).getData(moreData: true);
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
    var state = ref.watch(getAllLatestNewsLeagueProvider(widget.leagueSyncId));

    return  SafeArea(
        top: false,
        child: CheckStateInGetApiDataWidget(
          state: state,
          refresh: () {
            ref.invalidate(getAllLatestNewsLeagueProvider(widget.leagueSyncId));
          },
          widgetOfLoading: const LogoShimmerWidget(),
          widgetOfData: RefreshIndicator(
            backgroundColor: Colors.white,
            color: AppColors.primaryColor,
            onRefresh: () async {
              ref.invalidate(getAllLatestNewsProvider);
            },
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(12.sp).copyWith(bottom: 46.h),
              itemCount: state.data.data.length +
                  (state.stateData == States.loadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                final isLoaderItem = index >= state.data.data.length;
                if (isLoaderItem) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(child: CircularProgressIndicatorWidget()),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(bottom: 14.h),
                  child: ReportCardWidget(
                    news: state.data.data[index],
                    size: Size(MediaQuery.sizeOf(context).width, 200.h),
                  ),
                );
              },
            ),
          ),
        ),
      );

  }
}
