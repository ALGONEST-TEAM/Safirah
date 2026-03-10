import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../match_term_event/presntation/state_mangement/riverpod.dart';
import '../../data/model/match_model.dart';
import '../../data/model/round_model.dart';
import 'match_tile_widget.dart';
import 'matches_schedule_widget.dart';
class KnockoutRoundsListWidget extends ConsumerStatefulWidget {
  final String leagueSyncId;
  final String matchFilter;
  final String role;
  final Tuple3<String, String, String> refreshParam;
  final Tuple2<String, String> streamParam;

  const KnockoutRoundsListWidget({
    super.key,
    required this.leagueSyncId,
    required this.matchFilter,
    required this.role,
    required this.refreshParam,
    required this.streamParam,
  });

  @override
  ConsumerState<KnockoutRoundsListWidget> createState() => _KnockoutRoundsListWidgetState();
}

class _KnockoutRoundsListWidgetState extends ConsumerState<KnockoutRoundsListWidget> {

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(roundsRefreshKnockoutProvider(widget.refreshParam).notifier).refresh();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context,) {
    final asyncRounds =
    ref.watch(roundsWithKnockoutStreamProvider(widget.streamParam));

    return CheckStateInStreamWidget<List<RoundModel>>(
      async: asyncRounds,
      isEmpty: (rounds) => rounds.isEmpty,
      onRefresh: () => ref
          .read(roundsRefreshKnockoutProvider(widget.refreshParam).notifier)
          .refresh(),
      emptyBuilder: () => Center(
        child: AutoSizeTextWidget(
          text: ' لا توجد جولات اقصائية بعد',
          fontSize: 14.sp,
        ),
      ),
      keepPreviousDataWhileLoading: true,
      dataBuilder: (rounds) {
        // ✅ لا تفترض rounds[0]
        return RefreshIndicator(
          onRefresh: () => ref
              .read(roundsRefreshKnockoutProvider(widget.refreshParam).notifier)
              .refresh(),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: rounds.length,
            itemBuilder: (context, i) {
              final round = rounds[i];
              final matches = round.matches ?? const <MatchModel>[];

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
                              role: widget.role,
                              roundSyncId: round.syncId ?? '',
                              match: match,
                              leagueSyncId: widget.leagueSyncId,
                              matchFilter: widget.matchFilter,
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
      },
    );
  }
}