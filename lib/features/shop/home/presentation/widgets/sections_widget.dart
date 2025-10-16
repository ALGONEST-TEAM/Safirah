import 'dart:async';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safirah/core/theme/app_colors.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/widgets/product/products_shimmer_widget.dart';
import '../../../../../core/widgets/shimmer_widget.dart';
import '../riverpod/home_riverpod.dart';
import 'category_widget.dart';
import 'filter_products_home_widget.dart';
import '../../../../../core/widgets/product/product_list_widget.dart';

class SectionOfCategoryInHomePage extends ConsumerStatefulWidget {
  const SectionOfCategoryInHomePage({
    required this.idSection,
    super.key,
  });

  final int idSection;

  @override
  ConsumerState<SectionOfCategoryInHomePage> createState() =>
      _SectionOfCategoryInHomePageState();
}

class _SectionOfCategoryInHomePageState
    extends ConsumerState<SectionOfCategoryInHomePage>
    with AutomaticKeepAliveClientMixin<SectionOfCategoryInHomePage> {
  Timer? _debounceTimer;
  bool isLoadingMore = false;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _loadMoreData(int? numberFilter) async {
    if (!mounted) return;

    setState(() => isLoadingMore = true);

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      try {
        await ref
            .read(
                subSectionProvider(Tuple2(widget.idSection, numberFilter ?? 1))
                    .notifier)
            .getSubSectionData(moreData: true);
      } finally {
        if (mounted) setState(() => isLoadingMore = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var numberFilter =
        ref.watch(getSectionFilterTypeProvider(widget.idSection));
    var state = ref.watch(subSectionProvider(Tuple2(widget.idSection, 1)));

    return CustomRefreshIndicator(
      offsetToArmed: 40.h,
      autoRebuild: true,
      onRefresh: () async {
        await ref
            .read(
                subSectionProvider(Tuple2(widget.idSection, numberFilter ?? 1))
                    .notifier)
            .getSubSectionData(isRefresh: true, moreData: false);
      },
      builder: (context, child, controller) {
        final visible = controller.isLoading || controller.value > 1.0;
        final pull = Curves.easeOut.transform(controller.value.clamp(0.0, 1.0));
        final dy = pull * 28.h;
        return Stack(
          children: [
            Transform.translate(
              offset: Offset(0, dy),
              child: child,
            ),
            if (visible)
              Positioned(
                top: 28.h,
                left: 0,
                right: 0,
                child: ShimmerWidget(
                    baseColor: AppColors.primaryColor,
                    highlightColor: Colors.grey.shade50,
                    child: SvgPicture.asset(AppIcons.logoText, height: 80.h)),
              ),
          ],
        );
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            final m = scrollNotification.metrics;
            final bool nearEnd = m.extentAfter < 0.4; // px متبقية قليلة

            if (nearEnd && !isLoadingMore && m.maxScrollExtent > 0) {
              _loadMoreData(numberFilter);
            }
          }
          return false;
        },
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            CategoryWidget(
              state: state,
              refresh: () async {
                await ref
                    .read(subSectionProvider(
                            Tuple2(widget.idSection, numberFilter ?? 1))
                        .notifier)
                    .getSubSectionData(isRefresh: true, moreData: false);
              },
            ),
            if (state.stateData != States.error)
              SliverToBoxAdapter(
                child: FilterProductsHomeWidget(
                  idSection: widget.idSection,
                ),
              ),
            SliverToBoxAdapter(
              child: Consumer(
                builder: (context, ref, child) {
                  if (numberFilter != 1) {
                    state = ref.watch(subSectionProvider(
                        Tuple2(widget.idSection, numberFilter ?? 1)));
                  }
                  return state.stateData == States.loading
                      ? const ProductsShimmerWidget()
                      : state.stateData == States.error
                          ? const SizedBox.shrink()
                          : ProductListWidget(
                              isLoadingMore: isLoadingMore,
                              product: state.data.product?.data ?? [],
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
