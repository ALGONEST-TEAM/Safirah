import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../data/model/team_model.dart';
import '../state_mangment/riverpod.dart';
import '../widget/all_players_of_league_widget.dart';

class LeaguePlayersPage extends ConsumerStatefulWidget {
  const LeaguePlayersPage({
    super.key,
    required this.leagueSyncId,
  });

  final String leagueSyncId;

  @override
  ConsumerState<LeaguePlayersPage> createState() => _LeaguePlayersPageState();
}

class _LeaguePlayersPageState extends ConsumerState<LeaguePlayersPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(playerLeagueRefreshProvider(widget.leagueSyncId).notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final playersAsync = ref.watch(leaguePlayerStreamProvider(widget.leagueSyncId));

    return Scaffold(
      appBar: const SecondaryAppBarWidget(title: 'جميع لاعبي الدوري'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AutoSizeTextWidget(text: 'لاعبو الدوري'),
              6.h.verticalSpace,
              Expanded(
                child: CheckStateInStreamWidget<List<LeaguePlayerModel>>(
                  async: playersAsync,
                  isEmpty: (players) => players.isEmpty,
                  onRefresh: () => ref
                      .read(playerLeagueRefreshProvider(widget.leagueSyncId).notifier)
                      .refresh(),
                  keepPreviousDataWhileLoading: true,
                  dataBuilder: (players) => ListView.separated(
                    itemCount: players.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) {
                      final player = players[i];
                      return PlayerTile(
                        name: player.name ?? '',
                        avatar: '',
                        subtitle: (player.teamName ?? '').trim().isNotEmpty
                            ? ' ${player.teamName}'
                            : 'بدون فريق',
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


