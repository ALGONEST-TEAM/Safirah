import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/database/safirah_database.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../injection.dart' as di;
import '../widget/all_players_of_league_widget.dart';
import '../widget/all_team_of_league_widget.dart';

class ShowTeamAndPlayerPage extends ConsumerWidget {
  final int leagueId;
  final int maxTeam;
  final int maxPlayer;

  const ShowTeamAndPlayerPage(
      {super.key,
      required this.leagueId,
      required this.maxTeam,
      required this.maxPlayer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          title: const AutoSizeTextWidget(
            text: 'تحديد الفرق',
            colorText: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: AppColors.secondaryColor,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
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
                        Tab(text: 'الفرق'),
                        Tab(text: 'اللعبين'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: TabBarView(
                    children: [
                      AllTeamOfLeagueWidget(
                        leagueId: leagueId,

                      ),
                      AllPlayersOfLeagueWidget(
                        leagueId: leagueId,
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
