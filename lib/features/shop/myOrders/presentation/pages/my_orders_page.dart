import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/design_please_login_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../riverpod/order_riverpod.dart';
import '../widgets/app_bar_my_orders_widget.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
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
      appBar: const AppBarMyOrdersWidget(),
      body: !Auth().loggedIn
          ? const DesignPleaseLoginWidget()
          : DefaultTabController(
              length: 6,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    physics: const ClampingScrollPhysics(),
                    isScrollable: true,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: AppColors.fontColor,
                    labelColor: AppColors.secondaryColor,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "IBMPlexSansArabic",
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "IBMPlexSansArabic",
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(width: 2.w, color: AppColors.primaryColor),
                      insets: EdgeInsets.symmetric(vertical: 4.h),
                    ),
                    tabs: [
                      Tab(text: S.of(context).allOrders),
                      Tab(text: S.of(context).unpaid),
                      Tab(text: S.of(context).processing),
                      Tab(text: S.of(context).shipped),
                      Tab(text: S.of(context).returns),
                      Tab(text: S.of(context).review),
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
                          status: 4,
                        ),
                        ListForOrdersWidget(
                          scrollController: _scrollController,
                          status: 5,
                        ),
                        ListForOrdersWidget(
                          scrollController: _scrollController,
                          status: 3,
                        ),
                        ListForOrdersWidget(
                          scrollController: _scrollController,
                          status: 2,
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
