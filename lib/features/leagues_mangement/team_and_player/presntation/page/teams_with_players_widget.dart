import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/widgets/buttons/default_button.dart';
import '../../../../authorization/persntaion/riverpod/riverpod.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/bottomNavbar/bottom_navigation_bar_of_mange_league_widget.dart';
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
    final leagueStatus = ref.watch(leagueStatusStreamProvider(leagueSyncId));
    final leaguePermissions = ref.watch(leaguePermissionsProvider(leagueSyncId));
    final canEditLeague = leaguePermissions.asData?.value.contains('league.edit') ?? false;
    final unassignedPlayersCount =
        ref.watch(leaguePlayersWithoutTeamCountProvider(leagueSyncId));
    final canApproveTeams = (unassignedPlayersCount ?? 1) == 0;
    final hasPlayersInTeams =
        leagueStatus.asData?.value?.hasPlayersInTeams ?? false;

    return Scaffold(
      appBar: SecondaryAppBarWidget(
        title: canEditLeague ? 'اعتماد الفرق' : 'فرق الدوري',
      ),

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
            if (!canEditLeague && !hasPlayersInTeams)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: AutoSizeTextWidget(
                  text:
                      'يمكنك متابعة فرق الدوري والضغط على كل فريق لمشاهدة لاعبيه حتى يكتمل توزيع اللاعبين من قبل المنظم.${(unassignedPlayersCount != null && unassignedPlayersCount > 0) ? ' المتبقي: $unassignedPlayersCount' : ''}',
                  fontSize: 11.sp,
                  colorText: AppColors.fontColor2,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),
            hasPlayersInTeams || !canEditLeague
                ? const SizedBox()
                : SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!canApproveTeams)
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: AutoSizeTextWidget(
                              text:
                                  'لا يمكن اعتماد الفرق حتى يتم توزيع جميع اللاعبين على الفرق. المتبقي: ${unassignedPlayersCount ?? 0}',
                              fontSize: 11.sp,
                              colorText: AppColors.dangerColor,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            ),
                          ),
                        CheckStateInPostApiDataWidget(
                          state: leagueStatusUpdate,

messageSuccess: ' تم اعتماد تقسيم اللعبين على الفرق بنجاح',

                          functionSuccess: () {
                            ref.read(activeIndexProvider.notifier).state = 2;

                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const BottomNavigationBarOfMangeLeagueWidget(),
                              ),
                              (route) => false,
                            );

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DetailsLeagueWidget(
                                    leagueSyncId: leagueSyncId,
                                  ),
                                ),
                              );
                            });
                          },
                          bottonWidget: DefaultButtonWidget(
                            onPressed: canApproveTeams
                                ? () {
                                    ref
                                        .read(leagueStatusUpdateProvider.notifier)
                                        .update(
                                            leagueSyncId: leagueSyncId,
                                            hasPlayersAssigned: true);
                                  }
                                : null,
                            text: 'اعتماد الفرق',
                            background: canApproveTeams
                                ? AppColors.primaryColor
                                : AppColors.greySwatch.shade400,
                          ),
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
