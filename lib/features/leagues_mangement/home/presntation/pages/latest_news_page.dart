import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/buttons/icon_button_widget.dart';
import 'package:safirah/core/widgets/logo_shimmer_widget.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../riverpod/home_riverpod.dart';
import '../widgets/latest_news_card_widget.dart';

class LatestNewsPage extends ConsumerStatefulWidget {
  const LatestNewsPage({super.key});

  @override
  ConsumerState<LatestNewsPage> createState() => _LatestNewsPageState();
}

class _LatestNewsPageState extends ConsumerState<LatestNewsPage> {
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
        ref.read(getAllLatestNewsProvider).stateData != States.loadingMore) {
      ref.read(getAllLatestNewsProvider.notifier).getData(moreData: true);
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
    var state = ref.watch(getAllLatestNewsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leadingWidth: 60.w,
        automaticallyImplyLeading: false,
        leading: const IconButtonWidget(iconColor: Colors.white),
        title: AutoSizeTextWidget(
          text: 'الأخبار',
          fontSize: 14.sp,
          colorText: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: CheckStateInGetApiDataWidget(
          state: state,
          refresh: () {
            ref.invalidate(getAllLatestNewsProvider);
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
                  child: LatestNewsCardWidget(
                    news: state.data.data[index],
                    size: Size(MediaQuery.sizeOf(context).width, 220.h),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
