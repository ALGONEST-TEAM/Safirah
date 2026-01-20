import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/design_please_login_widget.dart';
import '../../../../core/widgets/main_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../widgets/leader_board_widget.dart';
import '../widgets/matches_widget.dart';
import '../widgets/prediction_card_widget.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<String> _tabs = [
    "المباريات",
    "توقعاتي",
    "الترتيب",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MainAppBarWidget(title: S.of(context).expectations),
      body: !Auth().loggedIn
          ? const DesignPleaseLoginWidget()
          : DefaultTabController(
              length: 3,
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    2.h.verticalSpace,
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                                  width: 102.w,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 6.4.w),
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
                                          fontSize: 12.sp,
                                          color: textColor)));
                            },
                          ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        physics: const BouncingScrollPhysics(),
                        children:const [
                          MatchesWidget(),
                          PredictionWidget(),
                          LeaderboardWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
