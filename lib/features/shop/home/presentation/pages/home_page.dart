import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../riverpod/home_riverpod.dart';
import '../widgets/app_bar_home_widget.dart';
import '../widgets/loading_home_widget.dart';
import '../widgets/offers_widget.dart';
import '../widgets/sections_widget.dart';
import '../widgets/tap_bar_widget.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
as extended;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  TabController? _tab;
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();

  @override
  void dispose() {
    _tab?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(sectionProvider);

    return Scaffold(
      appBar: appBarHomeWidget(context: context),
      body: CheckStateInGetApiDataWidget(
          state: state,
          refresh: () {
            ref.invalidate(sectionProvider);
          },
          widgetOfLoading: const LoadingHomeWidget(subSection: false),
          widgetOfData: Builder(
            builder: (context) {
              final sections = state.data.section ?? [];

              if (sections.isEmpty) {
                _tab?.dispose();
                _tab = null;
                return const LoadingHomeWidget(subSection: false);
              }
              // if (_tab == null || _tab!.length != sections.length) {
              //   final prev = _tab?.index ?? 0;
              //   final safeIndex = prev.clamp(0, sections.length - 1);
              //   _tab?.dispose();
              //   _tab = TabController(
              //     length: sections.length,
              //     vsync: this,
              //     initialIndex: safeIndex,
              //   );
              // }
              if (_tab == null || _tab!.length != sections.length) {
                final savedIndex = ref.read(homeTabIndexProvider); // ✅ من الذاكرة
                final safeIndex = savedIndex.clamp(0, sections.length - 1);

                _tab?.dispose();
                _tab = TabController(
                  length: sections.length,
                  vsync: this,
                  initialIndex: safeIndex,
                );

                // ✅ خزّن أي تغيير في التبويب
                _tab!.addListener(() {
                  if (!_tab!.indexIsChanging) {
                    ref.read(homeTabIndexProvider.notifier).state = _tab!.index;
                  }
                });
              }
              return PageStorage(
                bucket: _pageStorageBucket,
                child: extended.ExtendedNestedScrollView(
                  onlyOneScrollInBody: true,
                  floatHeaderSlivers: false,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      if (state.data.offers!.isNotEmpty)
                        SliverToBoxAdapter(
                          child: OffersWidget(
                            offers: state.data.offers ?? [],
                          ),
                        ),
                    SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w)
                              .copyWith(top: 10.h),
                          child: AutoSizeTextWidget(
                            text: S.of(context).sections,
                            colorText: AppColors.fontColor,
                            fontSize: 11.4.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        floating: false,
                        delegate: CollapsingTabBarHeaderWidget(
                          minHeight: 46.h,
                          maxHeight: 58.h,
                          builder: (t) => TapBarWidget(
                            controller: _tab!,
                            titles: state.data.section!
                                .map((s) => s.name ?? '')
                                .toList(),
                            t: t, //
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tab,
                    children: state.data.section!.map((section) {
                      return extended.ExtendedVisibilityDetector(
                        uniqueKey: Key('tab_${section.id}'),
                        child: SectionOfCategoryInHomePage(
                          idSection: section.id!,
                          key: PageStorageKey('tab_${section.id}'),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          )),
    );
  }
}
