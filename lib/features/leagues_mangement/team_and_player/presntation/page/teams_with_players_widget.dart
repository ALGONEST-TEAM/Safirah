import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/widgets/buttons/default_button.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../leagues/persntaion/page/details_league_widget.dart';
import '../../../leagues/persntaion/riverpod/riverpod.dart';
import '../state_mangment/riverpod.dart';
import '../widget/all_team_of_league_widget.dart';

class TeamsWithPlayersPage extends ConsumerWidget {
  const TeamsWithPlayersPage({super.key, required this.leagueSyncId});

  final String leagueSyncId;

  @override
  Widget build(BuildContext context, ref) {
    final leagueStatusUpdate = ref.watch(leagueStatusUpdateProvider);
    final countPlayerWithTeam = ref.watch(playersCountOfTeamProvider(leagueSyncId));
    final leagueStatus = ref.watch(leagueStatusStreamProvider(leagueSyncId));

    return Scaffold(
      appBar:SecondaryAppBarWidget(title: 'اعتماد الفرق',),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
        child: Column(
          children: [
            Expanded(
              child: AllTeamOfLeagueWidget(
                leagueSyncId: leagueSyncId,
                isNavToEditor: false,
              ),
            ),
            leagueStatus.asData!.value!.hasPlayersInTeams
                ? const SizedBox()
                : SafeArea(
                    child: CheckStateInPostApiDataWidget(
                      state: leagueStatusUpdate,
                      functionSuccess: () {
                        // ref
                        //     .read(leagueStatusProvider(leagueSyncId).notifier)
                        //     .refresh();
                        navigateTo(context, DetailsLeagueWidget(leagueSyncId:leagueSyncId,));
                      },
                      bottonWidget: DefaultButtonWidget(
                        onPressed: () {
                          ref
                              .read(leagueStatusUpdateProvider.notifier)
                              .update(
                                  leagueSyncId: leagueSyncId,
                                  hasPlayersAssigned: true);
                        },
                        text: 'اعتماد الفرق',
                        background: AppColors.primaryColor,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
