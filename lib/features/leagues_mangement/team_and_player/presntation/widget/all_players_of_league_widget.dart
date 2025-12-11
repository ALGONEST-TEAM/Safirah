import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../page/category_step_page.dart';
import '../page/team_step_page.dart';
import '../state_mangment/riverpod.dart';

class AllPlayersOfLeagueWidget extends ConsumerWidget {
  final int leagueId;
  final int maxTeam;
  final int maxPlayer;

  const AllPlayersOfLeagueWidget(
      {super.key,
      required this.leagueId,
      required this.maxTeam,
      required this.maxPlayer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.watch(leagueUsersProvider(leagueId));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(children: [
            CheckStateInGetApiDataWidget(
              state: players,
              widgetOfData: Expanded(
                child: ListView.separated(
                  itemCount: players.data.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    return PlayerTile(
                        name: players.data[i].userId.toString(),
                        handle: '@ldfxbn',
                        avatar: '');
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: DefaultButtonWidget(
                  background: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    navigateTo(
                        context,
                        TeamStepPage(
                          leagueId: leagueId,
                          players: players.data,
                          maxPlayersTeam: maxPlayer,
                        ));
                  },
                  text: 'يدوي',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DefaultButtonWidget(
                  onPressed: () {
                    navigateTo(
                        context,
                        CategoryStepPage(
                          leagueId: leagueId,
                          players: players.data,
                          maxTeam: maxTeam,
                        ));
                  },
                  text: 'فئات',
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}

class PlayerTile extends StatelessWidget {
  final String name, handle, avatar;

  const PlayerTile(
      {super.key,
      required this.name,
      required this.handle,
      required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        CircleAvatar(backgroundImage: NetworkImage(avatar)),
        const SizedBox(width: 10),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(handle, style: const TextStyle(color: Colors.black54)),
        ])),
      ]),
    );
  }
}
