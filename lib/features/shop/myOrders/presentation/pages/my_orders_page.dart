import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/design_please_login_widget.dart';
import '../../../../../core/widgets/main_app_bar_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../riverpod/order_riverpod.dart';
import '../widgets/list_for_orders_widget.dart';

class MyOrdersPage extends ConsumerStatefulWidget {
  const MyOrdersPage({
    super.key,
  });

  @override
  ConsumerState<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends ConsumerState<MyOrdersPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final List<String> _tabs = [
    S.current.allOrders,
    S.current.unpaid,
    S.current.processing,
    S.current.onTheWay,
    S.current.delivered
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(getAllOrdersProvider.notifier).getData(
            moreData: true,
          );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(title: S.of(context).myOrders),
      body: !Auth().loggedIn
          ? const DesignPleaseLoginWidget()
          : DefaultTabController(
              length: 5,
              child: Column(
                spacing: 6.h,
                children: [
                  2.h.verticalSpace,
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.zero,
                    indicator: ShapeDecoration(
                      color: AppColors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    tabs: [
                      for (int i = 0; i < _tabs.length; i++)
                        AnimatedBuilder(
                          animation: _tabController.animation!,
                          builder: (context, _) {
                            final value = _tabController.animation?.value ??
                                _tabController.index.toDouble();
                            final selectness =
                                (1.0 - (value - i).abs()).clamp(0.0, 1.0);
                            final bgColor = Color.lerp(Colors.white,
                                AppColors.secondaryColor, selectness)!;
                            final textColor = Color.lerp(
                                AppColors.secondaryColor,
                                Colors.white,
                                selectness)!;

                            return Container(
                                height: 34.h,
                                width: 100.w,
                                margin: EdgeInsets.symmetric(horizontal: 6.w),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: AppColors.greySwatch.shade100,
                                    width: 0.4,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(_tabs[i],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontFamily: 'IBMPlexSansArabic',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.4.sp,
                                      color: textColor,
                                    )));
                          },
                        ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ListForOrdersWidget(
                          scrollController: _scrollController,
                          status: 0,
                          all: true,
                        ),
                        ListForOrdersWidget(
                          scrollController: _scrollController,
                          status: 1,
                        ),
                        ListForOrdersWidget(
                          scrollController: _scrollController,
                          status: 3,
                        ),
                        ListForOrdersWidget(
                          scrollController: _scrollController,
                          status: 5,
                        ),
                        ListForOrdersWidget(
                          scrollController: _scrollController,
                          status: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
