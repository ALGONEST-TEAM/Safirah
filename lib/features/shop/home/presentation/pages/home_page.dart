import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import 'package:safirah/features/shop/shoppingBag/cart/presentation/pages/cart_page.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/skeletonizer_widget.dart';
import '../riverpod/home_riverpod.dart';
import '../widgets/app_bar_home_widget.dart';
import '../widgets/offers_widget.dart';
import '../widgets/sections_widget.dart';
import '../widgets/tap_bar_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  bool _isTabControllerInitialized = false;

  final PageStorageBucket _pageStorageBucket = PageStorageBucket();

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(sectionProvider);

    if (state.data.section == null || state.data.section!.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor));
    }

    try {
      if (!_isTabControllerInitialized) {
        _tabController = TabController(
          length: state.data.section!.length,
          vsync: this,
        );

        _isTabControllerInitialized = true;
      }
    } catch (e) {
      if (kReleaseMode) {
        print("Error initializing TabController in Release mode: $e");
      }
      return const Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor));
    }

    if (_tabController == null) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor));
    }

    return CheckStateInGetApiDataWidget(
      state: state,
      widgetOfData: Scaffold(
        appBar: appBarHomeWidget(context: context),
        body: PageStorage(
          bucket: _pageStorageBucket,
          child: NestedScrollView(
            floatHeaderSlivers: false,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Consumer(
                    builder: (context, ref, child) {
                      var stateSubSection = ref.watch(subSectionProvider(
                          Tuple2(state.data.section![0].id!, 1)));
                      return stateSubSection.stateData == States.loading
                          ? const SkeletonizerWidget(
                              child: OffersWidget(
                                images: ['', ''],
                              ),
                            )
                          : OffersWidget(
                              images: stateSubSection.data.imageBanner ?? [],
                            );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w)
                        .copyWith(top: 12.h),
                    child: AutoSizeTextWidget(
                      text: "الأقسام",
                      colorText: AppColors.fontColor,
                      fontSize: 11.4.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverPersistentHeader(
                    pinned: true,
                    floating: false,
                    delegate: CollapsingTabBarHeaderWidget(
                      minHeight: 46.h,
                      maxHeight: 58.h,
                      builder: (t) => TapBarWidget(
                        controller: _tabController!,
                        titles: state.data.section!
                            .map((s) => s.name ?? '')
                            .toList(),
                        t: t, //
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: state.data.section!.map((section) {
                return SectionOfCategoryInHomePage(
                  idSection: section.id!,
                  key: ValueKey(section.id!),
                );
              }).toList(),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 28.h),
          child: FloatingActionButton(
            onPressed: () {
              navigateTo(context, const CartPage());
            },
            backgroundColor: AppColors.whiteColor,
            elevation: 5,
            splashColor:AppColors.primaryColor ,
            shape: const CircleBorder(),
            child: SvgPicture.asset(
              AppIcons.cartActive,
              height: 23.h,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
