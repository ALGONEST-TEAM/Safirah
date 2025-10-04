import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safirah/core/theme/app_colors.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/widgets/product/products_shimmer_widget.dart';
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
  final double _loadMoreThreshold = 1;

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

    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: AppColors.primaryColor,
      onRefresh: () async {
        await ref
            .read(
            subSectionProvider(Tuple2(widget.idSection, numberFilter ?? 1))
                .notifier)
            .getSubSectionData(isRefresh: true, moreData: false);
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            final metrics = scrollNotification.metrics;
            final double scrollPercentage =
                metrics.pixels / metrics.maxScrollExtent;
            if (scrollPercentage > _loadMoreThreshold &&
                !isLoadingMore &&
                metrics.maxScrollExtent > 0) {
              _loadMoreData(numberFilter);
            }
          }
          return false;
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
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
