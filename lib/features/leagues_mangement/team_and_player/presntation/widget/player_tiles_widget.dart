import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/team_model.dart';
import '../state_mangment/riverpod.dart';

class PlayerTilesWidget extends ConsumerWidget {
  const PlayerTilesWidget(this.player,
      {super.key, required this.categoryId, required this.leagueId});

  final int leagueId;
  final int categoryId;
  final LeaguePlayerModel player;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(11.w),
      decoration: BoxDecoration(
        color: const Color(0xffEDF0FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage('assets/images/avatar_placeholder.png'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                player.id.toString(),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(
                '@${player.id ?? 'user${player.id}'}',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                ref
                    .read(setPlayerCategoryProvider.notifier)
                    .deletePlayerCategory(
                        leaguePlayerId: player.id!, categoryId: categoryId);
                ref
                    .read(playersByCategoryProvider((leagueId, categoryId))
                        .notifier)
                    .load();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
