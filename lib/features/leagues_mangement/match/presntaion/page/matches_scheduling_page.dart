import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../widget/matches_schedule_widget.dart';

class MatchesSchedulingPage extends ConsumerWidget {
  const MatchesSchedulingPage(
      {super.key, required this.leagueSyncId, required this.role});

  final String leagueSyncId;
  final String role;

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: SecondaryAppBarWidget(
        title: 'جدولة المباريات',
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
                        padding: EdgeInsets.all(2.r),
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
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                            indicatorSize: TabBarIndicatorSize.tab,
                            overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                            labelPadding: EdgeInsets.zero,
                            indicatorPadding:
                            EdgeInsets.symmetric(
                                horizontal: 4.5.w, vertical: 0),
                            labelColor: Colors.white,
                            unselectedLabelColor: AppColors.secondaryColor,
                            tabs: const [
                              Tab(text: 'لم تجدول'),
                              Tab(text: 'تم الجدولة'),
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
                      matchFilter: 'unscheduled',
                    ),
                    Visibility(
                      visible: role=='organizer',
                      replacement: MatchesScheduleWidget(
                        role: role,
                        leagueSyncId: leagueSyncId,
                        matchFilter: 'scheduled,live,finished',
                      ),
                      child: MatchesScheduleWidget(
                        role: role,
                        leagueSyncId: leagueSyncId,
                        matchFilter: 'scheduled,live',
                      ),
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
