import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_lineups_model.dart';
import 'match_lineups_subbed_player_row_widget.dart';
import 'match_lineups_unused_player_row_widget.dart';

class MatchLineupsBenchWidget extends StatelessWidget {
  final List<MatchLineupPlayerModel> bench;
  final List<MatchLineupPlayerModel> starters;
  final List<MatchLineupSubEventModel> substitutions;

  const MatchLineupsBenchWidget({
    super.key,
    required this.bench,
    this.starters = const [],
    required this.substitutions,
  });

  @override
  Widget build(BuildContext context) {
    if (bench.isEmpty) {
      return const SizedBox.shrink();
    }

    // 1. Map team-level substitution events
    final Map<int, MatchLineupSubEventModel> teamSubByEventId = {};
    final Map<int, MatchLineupSubEventModel> teamSubByPlayerId = {};

    for (final sub in substitutions) {
      if (sub.eventId > 0) teamSubByEventId[sub.eventId] = sub;
      if (sub.playerId > 0) teamSubByPlayerId[sub.playerId] = sub;
    }

    // Starters mapped by ID
    final Map<int, MatchLineupPlayerModel> startersById = {
      for (final s in starters) s.id: s
    };

    // Starters subbed out list
    final List<MatchLineupPlayerModel> availableStartersOut =
        starters.where((s) {
      return s.substitutionEvents.any((e) => e.direction == 'out');
    }).toList();

    // 2. Process bench players
    final List<_BenchItem> items = [];

    for (final player in bench) {
      // Find matching sub event
      MatchLineupSubEventModel? subEvent = teamSubByPlayerId[player.id];

      if (subEvent == null && player.substitutionEvents.isNotEmpty) {
        final pEvt = player.substitutionEvents.first;
        subEvent = teamSubByEventId[pEvt.eventId];
      }

      final bool isSubbedIn = subEvent != null ||
          player.substitutionEvents.any((e) => e.direction == 'in');

      if (isSubbedIn) {
        final int min = subEvent?.minute ??
            (player.substitutionEvents.isNotEmpty
                ? player.substitutionEvents.first.minute
                : 0);

        String outName = '';
        int outNumber = 0;

        // Try getting related player out from team subEvent
        if (subEvent != null) {
          if (subEvent.relatedPlayerId > 0 &&
              startersById.containsKey(subEvent.relatedPlayerId)) {
            final pOut = startersById[subEvent.relatedPlayerId]!;
            outName = pOut.commonName.isNotEmpty ? pOut.commonName : pOut.name;
            outNumber = pOut.jerseyNumber;
          } else if (subEvent.relatedPlayerName.isNotEmpty) {
            outName = subEvent.relatedPlayerName;
          }
        }

        // Fallback: match with a starter subbed out at or near the same minute
        if (outName.isEmpty && availableStartersOut.isNotEmpty) {
          MatchLineupPlayerModel? matchedStarter;
          try {
            matchedStarter = availableStartersOut.firstWhere(
              (s) => s.substitutionEvents.any((e) => e.minute == min),
            );
            availableStartersOut.remove(matchedStarter);
          } catch (_) {
            matchedStarter = availableStartersOut.removeAt(0);
          }
          if (matchedStarter != null) {
            outName = matchedStarter.commonName.isNotEmpty
                ? matchedStarter.commonName
                : matchedStarter.name;
            outNumber = matchedStarter.jerseyNumber;
          }
        }

        items.add(_BenchItem.subbed(
          playerIn: player,
          outName: outName,
          outNumber: outNumber,
          minute: min,
        ));
      } else {
        items.add(_BenchItem.unused(player: player));
      }
    }

    // 3. Sort items: Subbed players FIRST, Unused players AFTER
    items.sort((a, b) {
      if (a.isSubbed && !b.isSubbed) return -1;
      if (!a.isSubbed && b.isSubbed) return 1;
      return 0;
    });

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Title
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Center(
              child: AutoSizeTextWidget(
                text: 'مقاعد البدلاء',
                fontWeight: FontWeight.w800,
                fontSize: 13.sp,
                colorText: AppColors.mainColorFont,
              ),
            ),
          ),

          const Divider(height: 1, color: Color(0xfff5f3f9)),

          // List of bench items
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: items.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Color(0xfff5f3f9)),
            itemBuilder: (context, index) {
              final item = items[index];
              if (item.isSubbed) {
                return MatchLineupsSubbedPlayerRowWidget(
                  playerIn: item.playerIn!,
                  outName: item.outName,
                  outNumber: item.outNumber,
                  minute: item.minute,
                );
              } else {
                return MatchLineupsUnusedPlayerRowWidget(
                  player: item.player!,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _BenchItem {
  final bool isSubbed;
  final MatchLineupPlayerModel? playerIn;
  final MatchLineupPlayerModel? player;
  final String outName;
  final int outNumber;
  final int minute;

  _BenchItem.subbed({
    required this.playerIn,
    required this.outName,
    required this.outNumber,
    required this.minute,
  })  : isSubbed = true,
        player = null;

  _BenchItem.unused({
    required this.player,
  })  : isSubbed = false,
        playerIn = null,
        outName = '',
        outNumber = 0,
        minute = 0;
}
