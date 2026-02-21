import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../widget/league_list_widget.dart';

class ShowLeaguesPage extends StatefulWidget {
  const ShowLeaguesPage({super.key});

  @override
  State<ShowLeaguesPage> createState() => _ShowLeaguesPageState();
}

class _ShowLeaguesPageState extends State<ShowLeaguesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: const AutoSizeTextWidget(
          text: 'الدوريات',
          colorText: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.0.w, right: 2.w),
                    child: TabBar(
                      isScrollable: false,
                      dividerColor: Colors.transparent,
                      tabAlignment: TabAlignment.fill,
                      indicator: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                      indicatorSize: TabBarIndicatorSize.tab,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      labelPadding: EdgeInsets.zero,
                      indicatorPadding:
                          EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 2),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.secondaryColor,
                      tabs: const [
                        Tab(text: 'دوريات عامة'),
                        Tab(text: 'دوريات خاصة'),
                        Tab(text: 'دورياتي'),
                      ],
                    ),
                  ),
                ),
              ),
              // ===== المحتوى =====
              const Expanded(
                child: TabBarView(
                  children: [
                    LeaguesListWidget(
                      isPrivate: false,
                    ),
                    LeaguesListWidget(
                      isPrivate: true,
                    ),
                    LeaguesListWidget(
                      isPrivate: true,
                    ),
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
