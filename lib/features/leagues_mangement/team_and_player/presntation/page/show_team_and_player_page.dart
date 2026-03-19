import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/secondary_app_bar_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../widget/all_players_of_league_widget.dart';
import '../widget/all_team_of_league_widget.dart';

class ShowTeamAndPlayerPage extends ConsumerWidget {
  final String leagueSyncId;
  final int maxTeam;
  final int maxPlayer;

  const ShowTeamAndPlayerPage(
      {super.key,
      required this.leagueSyncId,
      required this.maxTeam,
      required this.maxPlayer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: SecondaryAppBarWidget(title: 'تحديد الفرق',),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 45.h,
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
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      labelPadding: EdgeInsets.zero,
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.secondaryColor,
                      tabs: const [
                        Tab(text: 'الفرق'),
                        Tab(text: 'اللعبين'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: TabBarView(
                    children: [
                      AllTeamOfLeagueWidget(
                        leagueSyncId: leagueSyncId,

                      ),
                      AllPlayersOfLeagueWidget(
                        leagueSyncId: leagueSyncId,
                        maxTeam: maxTeam,
                        maxPlayer: maxPlayer,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
