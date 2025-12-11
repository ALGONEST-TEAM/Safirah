import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import 'package:safirah/features/leagues_mangement/match/data/model/round_model.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../group/data/model/model.dart';
import '../../../match_term_event/presntation/page/add_event_match_page.dart';
import '../../../match_term_event/presntation/state_mangement/riverpod.dart';
import '../../data/model/match_model.dart';
import '../page/schedule_match_page.dart';
import '../state_managment/riverpod.dart';
import 'knockout_rounds_list_widget.dart';
import 'rounds_list_widget.dart';

class MatchesScheduleWidget extends ConsumerWidget {
  final int leagueId;
  final String matchFilter;

  const MatchesScheduleWidget(
      {super.key, required this.leagueId, required this.matchFilter});

  @override
  Widget build(BuildContext context, ref) {
    final state =
        ref.watch(roundsWithGroupsProvider(Tuple2(leagueId, matchFilter)));
    final checkFinishedAllMatchInGroup =
        ref.watch(checkGroupMatchesFinishedProvider(leagueId));
    return Scaffold(
      body: checkFinishedAllMatchInGroup.data == true
          ? KnockoutRoundsListWidget(
              leagueId: leagueId,
              matchFilter: matchFilter,
            )
          : CheckStateInGetApiDataWidget(
              state: state,
              widgetOfData: RoundsListWidget(
                rounds: state.data,
                leagueId: leagueId,
                matchFilter: matchFilter,
              ),
            ),
    );
  }
}



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



