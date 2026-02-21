import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/constants/app_icons.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../match_term_event/presntation/page/initialization_term_page.dart';
import '../widget/matches_schedule_widget.dart';

class RefereeMatchesPage extends ConsumerWidget {
  const RefereeMatchesPage({super.key, required this.leagueSyncId , required this.role});

  final String leagueSyncId;
  final String role;
  @override
  Widget build(BuildContext context,ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const AutoSizeTextWidget(
          text: 'ادارة مبارياتي',
          colorText: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: AppColors.secondaryColor,

      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
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
                              Tab(text: 'لم تلعب'),
                              Tab(text: 'لعبت'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // ===== المحتوى =====
              Expanded(
                child: TabBarView(
                  children: [
                    MatchesScheduleWidget(
                      role: role,
                      leagueSyncId: leagueSyncId,
                      matchFilter: 'scheduled',
                    ),
                    MatchesScheduleWidget(
                      role: role,
                      leagueSyncId: leagueSyncId,
                      matchFilter: 'live',
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
