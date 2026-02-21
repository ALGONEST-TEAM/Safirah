import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../data/model/round_model.dart';
import '../state_managment/riverpod.dart';
import 'round_section_widget.dart';
//
// class RoundsListWidget extends ConsumerWidget {
//   final String role;
//   final String leagueSyncId;
//   final String matchFilter;
//
//   const RoundsListWidget(
//       {super.key,
//       required this.role,
//       required this.leagueSyncId,
//       required this.matchFilter});
//
//   @override
//   Widget build(BuildContext context, ref) {
//     ref.watch(roundsRefreshProvider(Tuple3(leagueSyncId, matchFilter,role)));
//
//     final roundsAsync = ref.watch(
//         roundsWithGroupsStreamProvider(Tuple2(leagueSyncId, matchFilter)));
//
//     return CheckStateInStreamWidget<List<RoundModel>>(
//       async: roundsAsync,
//       isEmpty: (rounds) => rounds.isEmpty,
//       onRefresh: () {
//         return ref
//             .read(roundsRefreshProvider(Tuple3(leagueSyncId, matchFilter, role))
//                 .notifier)
//             .refresh();
//       },
//       keepPreviousDataWhileLoading: true,
//       dataBuilder: (rounds) {
//         return RefreshIndicator(
//           onRefresh: () => ref
//               .read(
//                   roundsRefreshProvider(Tuple3(leagueSyncId, matchFilter, role))
//                       .notifier)
//               .refresh(),
//           child: ListView.builder(
//             // physics: NeverScrollableScrollPhysics(),
//             // shrinkWrap: true,
//             padding: const EdgeInsets.all(12),
//             itemCount: rounds.length,
//             itemBuilder: (context, roundIndex) {
//               final round = rounds[roundIndex];
//               return RoundSectionWidget(
//                 round: round,
//                 leagueSyncId: leagueSyncId,
//                 matchFilter: matchFilter,
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
class RoundsListWidget extends ConsumerWidget {
  final String role;
  final String leagueSyncId;
  final String matchFilter;
  final Tuple3<String, String, String> refreshParam;
  final Tuple2<String, String> streamParam;

  const RoundsListWidget({
    super.key,
    required this.role,
    required this.leagueSyncId,
    required this.matchFilter,
    required this.refreshParam,
    required this.streamParam,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(roundsRefreshProvider(refreshParam));
    final asyncRounds = ref.watch(roundsWithGroupsStreamProvider(streamParam));

    return CheckStateInStreamWidget<List<RoundModel>>(
      async: asyncRounds,
      isEmpty: (rounds) => rounds.isEmpty,
      onRefresh: () => ref.read(roundsRefreshProvider(refreshParam).notifier).refresh(),
      keepPreviousDataWhileLoading: true,
      dataBuilder: (rounds) {
        return RefreshIndicator(
          onRefresh: () => ref.read(roundsRefreshProvider(refreshParam).notifier).refresh(),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: rounds.length,
            itemBuilder: (context, i) {
              final round = rounds[i];
              return RoundSectionWidget(
                round: round,
                leagueSyncId: leagueSyncId,
                matchFilter: matchFilter,
              );
            },
          ),
        );
      },
    );
  }
}