import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../match_term_event/presntation/state_mangement/riverpod.dart';
import '../../data/model/round_model.dart';
import '../state_managment/riverpod.dart';
import 'knockout_rounds_list_widget.dart';
import 'rounds_list_widget.dart';
class MatchesScheduleWidget extends ConsumerStatefulWidget {
  final String leagueSyncId;
  final String matchFilter;
  final String role;

  const MatchesScheduleWidget({
    super.key,
    required this.leagueSyncId,
    required this.matchFilter,
    required this.role,
  });

  @override
  ConsumerState<MatchesScheduleWidget> createState() => _MatchesScheduleWidgetState();
}

class _MatchesScheduleWidgetState extends ConsumerState<MatchesScheduleWidget> {
  late final Tuple3<String, String, String> refreshParam;
  late final Tuple2<String, String> streamParam;

  @override
  void initState() {
    super.initState();
    refreshParam = Tuple3(widget.leagueSyncId, widget.matchFilter, widget.role);
    streamParam = Tuple2(widget.leagueSyncId, widget.matchFilter);

  }

  @override
  Widget build(BuildContext context) {
    final checkFinishedAllMatchInGroup =
    ref.watch(checkGroupMatchesFinishedProvider(widget.leagueSyncId));

    if (checkFinishedAllMatchInGroup.data == true) {
      return KnockoutRoundsListWidget(

        leagueSyncId: widget.leagueSyncId,
        matchFilter: widget.matchFilter,
        role: widget.role,
        refreshParam: refreshParam,
        streamParam: streamParam,

      );
    }

    return RoundsListWidget(
      role: widget.role,
      leagueSyncId: widget.leagueSyncId,
      matchFilter: widget.matchFilter,
      refreshParam: refreshParam,
      streamParam: streamParam,
    );
  }
}
// class MatchesScheduleWidget extends ConsumerStatefulWidget {
//   final String leagueSyncId;
//   final String matchFilter;
//   final String role;
//
//   const MatchesScheduleWidget({
//     super.key,
//     required this.leagueSyncId,
//     required this.matchFilter,
//     required this.role,
//   });
//
//   @override
//   ConsumerState<MatchesScheduleWidget> createState() =>
//       _MatchesScheduleWidgetState();
// }
//
// class _MatchesScheduleWidgetState extends ConsumerState<MatchesScheduleWidget> {
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(ensureKnockoutProgressProvider(widget.leagueSyncId).notifier)
//           .run(qualifiedPerGroup: 4);
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final hasKnockout =
//     ref.watch(hasAnyKnockoutRoundsProvider(widget.leagueSyncId));
//
//     return Scaffold(
//       body: hasKnockout
//           ? KnockoutRoundsListWidget(
//         leagueSyncId: widget.leagueSyncId,
//         matchFilter: widget.matchFilter,
//         role: widget.role,
//       )
//           : RoundsListWidget(
//         role: widget.role,
//         leagueSyncId: widget.leagueSyncId,
//         matchFilter: widget.matchFilter,
//       ),
//     );
//   }
// }

/// 🔹 قسم الجولة الإقصائية (بدون مجموعات)
// class KnockoutRoundSectionWidget extends StatelessWidget {
//   final RoundModel? round;
//   final int leagueId;
//   final String matchFilter;
//
//   const KnockoutRoundSectionWidget({
//     super.key,
//     required this.round,
//     required this.leagueId,
//     required this.matchFilter,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (round == null) {
//       return const Center(child: Text('لا توجد بيانات لهذه الجولة.'));
//     }
//
//     final matches = round!.matches ?? [];
//
//     if (matches.isEmpty) {
//       return const Center(child: Text('لا توجد مباريات بعد.'));
//     }
//
//     return ListView(
//       padding: const EdgeInsets.all(12),
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: AutoSizeTextWidget(
//             text: round!.id != 0 ? round!.id.toString() : 'المباريات الإقصائية',
//             fontSize: 16.sp,
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             children: List.generate(matches.length, (i) {
//               final match = matches[i];
//               return Column(
//                 children: [
//                   MatchTileWidget(
//                     roundId: round!.id ?? 0,
//                     match: match,
//                     leagueId: leagueId,
//                     matchFilter: matchFilter,
//                   ),
//                   if (i != matches.length - 1)
//                     const Divider(height: 1, color: Color(0xffF2F0FB)),
//                 ],
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }
// }
