import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../data/model/team_model.dart';
import '../page/category_step_page.dart';
import '../page/invitations_players_page.dart';
import '../page/team_step_page.dart';
import '../state_mangment/riverpod.dart';

class AllPlayersOfLeagueWidget extends ConsumerStatefulWidget {
  final String leagueSyncId;
  final int maxTeam;
  final int maxPlayer;

  const AllPlayersOfLeagueWidget(
      {super.key,
      required this.leagueSyncId,
      required this.maxTeam,
      required this.maxPlayer});

  @override
  ConsumerState<AllPlayersOfLeagueWidget> createState() =>
      _AllPlayersOfLeagueWidgetState();
}

class _AllPlayersOfLeagueWidgetState
    extends ConsumerState<AllPlayersOfLeagueWidget> {
  @override
  void initState() {
    super.initState();

    // Future.microtask(() {
    //   // ref
    //   //     .read(playerLeagueRefreshProvider(widget.leagueSyncId).notifier)
    //   //     .refresh();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final playersAsync =
        ref.watch(leaguePlayerStreamProvider(widget.leagueSyncId));

    return Column(
      children: [
      DefaultButtonWidget(
      background: AppColors.secondaryColor,
      textColor: Colors.white,
      onPressed: () {
        //  print(players.length<=widget.maxPlayer*widget.maxTeam);
        navigateTo(
          context,
          InvitationsPlayersPage(
            leagueSyncId: widget.leagueSyncId,
          ),
        );
      },
      text: "طلبات الانضمام",
    ),
        Expanded(
          child: CheckStateInStreamWidget<List<LeaguePlayerModel>>(
            async: playersAsync,
            isEmpty: (rounds) {
              return rounds.isEmpty;
            },
            onRefresh: () => ref
                .read(playerLeagueRefreshProvider(widget.leagueSyncId).notifier)
                .refresh(),
            keepPreviousDataWhileLoading: true,
            dataBuilder: (players) {
              return Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemCount: players.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 10),
                            itemBuilder: (_, i) {
                              return PlayerTile(
                                  name: players[i].name ?? '', avatar: '');
                            },
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Visibility(
                          visible:
                              players.length >= widget.maxPlayer * widget.maxTeam,
                          replacement: DefaultButtonWidget(
                            background: AppColors.secondaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              print(players.length <=
                                  widget.maxPlayer * widget.maxTeam);
                              navigateTo(
                                context,
                                InvitationsPlayersPage(
                                  leagueSyncId: widget.leagueSyncId,
                                ),
                              );
                            },
                            text: "طلبات الانضمام",
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: DefaultButtonWidget(
                                  background: Colors.white,
                                  textColor: Colors.black,
                                  onPressed: () {
                                    print(widget.leagueSyncId);
                                    navigateTo(
                                      context,
                                      TeamStepPage(
                                        leagueSyncId: widget.leagueSyncId,
                                        players: players,
                                        maxPlayersTeam: widget.maxPlayer,
                                      ),
                                    );
                                  },
                                  text: 'يدوي',
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: DefaultButtonWidget(
                                  onPressed: () {
                                    navigateTo(
                                      context,
                                      CategoryStepPage(
                                        leagueSyncId: widget.leagueSyncId,
                                        players: players,
                                        maxTeam: widget.maxTeam,
                                      ),
                                    );
                                  },
                                  text: 'فئات',
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
            },
          ),
        ),
      ],
    );
// return  DefaultButtonWidget(
//   background: AppColors.secondaryColor,
//   textColor: Colors.white,
//   onPressed: () {
//   //  print(players.length<=widget.maxPlayer*widget.maxTeam);
//     navigateTo(
//       context,
//       InvitationsPlayersPage(
//         leagueSyncId: widget.leagueSyncId,
//       ),
//     );
//   },
//   text: "طلبات الانضمام",
// );
  }
}

class PlayerTile extends StatelessWidget {
  final String name, avatar;

  const PlayerTile({super.key, required this.name, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        CircleAvatar(backgroundImage: NetworkImage(avatar)),
        SizedBox(width: 10.w),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AutoSizeTextWidget(text: name, fontWeight: FontWeight.w600),
        ])),
      ]),
    );
  }
}
