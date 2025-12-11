import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../match_term_event/presntation/state_mangement/riverpod.dart';
import 'match_tile_widget.dart';
import 'matches_schedule_widget.dart';

class KnockoutRoundsListWidget extends ConsumerWidget {
  final int leagueId;
  final String matchFilter;

  const KnockoutRoundsListWidget({
    super.key,
    required this.leagueId,
    required this.matchFilter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
        knockoutRoundsWithMatchesProvider(Tuple2(leagueId, matchFilter)));
    return CheckStateInGetApiDataWidget(
      state: state,
      widgetOfData: ListView.builder(
        padding: const EdgeInsets.all(12),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.data.length,
        itemBuilder: (context, i) {
          final round = state.data[i];
          final matches = round.matches ?? [];
          if (matches.isEmpty) return const SizedBox();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: AutoSizeTextWidget(
                  text: round.roundName,
                  fontSize: 16.sp,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: List.generate(matches.length, (j) {
                    final match = matches[j];
                    return Column(
                      children: [
                        MatchTileWidget(
                          roundId: round.id ?? 0,
                          match: match,
                          leagueId: leagueId,
                          matchFilter: matchFilter,
                        ),
                        if (j != matches.length - 1)
                          const Divider(height: 1, color: Color(0xffF2F0FB)),
                      ],
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
