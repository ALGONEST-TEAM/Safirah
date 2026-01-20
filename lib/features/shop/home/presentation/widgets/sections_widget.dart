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

  bool _pagingLock = false;

  void _loadMoreData(int? numberFilter) async {
    if (!mounted || _pagingLock) return;
    _pagingLock = true;

    setState(() => isLoadingMore = true);
    try {
      await ref
          .read(subSectionProvider(Tuple2(widget.idSection, numberFilter ?? 1))
              .notifier)
          .getSubSectionData(moreData: true);
    } finally {
      if (mounted) setState(() => isLoadingMore = false);
      _pagingLock = false;
    }
  }

  double _lastPixels = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var numberFilter =
        ref.watch(getSectionFilterTypeProvider(widget.idSection));
    var state = ref.watch(subSectionProvider(Tuple2(widget.idSection, 1)));
    final hasMore = ref.watch(
      subSectionProvider(Tuple2(widget.idSection, numberFilter ?? 1))
          .select((s) {
        final p = s.data.product;
        if (p == null) return true;
        if (p.lastPage != null) return p.currentPage < p.lastPage!;
        return (p.data.isNotEmpty);
      }),
    );
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
                top: -20.h,
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
        onNotification: (n) {
          if (n.metrics.axis != Axis.vertical) return false;
          if (n is ScrollUpdateNotification) {
            final m = n.metrics;
            // فقط لو المستخدم ينزل لتحت
            final goingDown = m.pixels > _lastPixels;
            _lastPixels = m.pixels;

            final endThreshold = MediaQuery.of(context).size.height * 0.02;

            final atEnd = m.pixels >= (m.maxScrollExtent - endThreshold);

            if (goingDown &&
                !isLoadingMore &&
                !_pagingLock &&
                atEnd &&
                m.maxScrollExtent > 5 &&
                hasMore) {
              _loadMoreData(numberFilter);
            }
          }
          return false;
        },
        child: CustomScrollView(
          key: PageStorageKey('section_${widget.idSection}'),
          physics: const ClampingScrollPhysics(),
          slivers: [
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
            if (state.stateData != States.error) ...[
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
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
