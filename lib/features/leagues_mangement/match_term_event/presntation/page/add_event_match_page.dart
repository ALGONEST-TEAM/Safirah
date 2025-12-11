import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../match/data/model/match_model.dart';
import '../../../team_and_player/data/model/team_model.dart';
import '../../data/model/goal_model.dart';
import '../../data/model/match_term_model.dart';
import '../../data/model/warring_model.dart';
import '../state_mangement/riverpod.dart';
import '../widget/control_button_widget.dart';
import '../widget/match_app_bar_widget.dart';
import '../widget/players_tab_view_widget.dart';
import '../widget/team_tabs_widget.dart';

class AddEventMatchPage extends ConsumerStatefulWidget {
  final TeamModel homeTeam;
  final TeamModel awayTeam;
  final List<MatchTermModel> matchTerm;
  final int matchId;
  final int roundId;
  final int leagueId;

  const AddEventMatchPage({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    required this.matchTerm,
    required this.matchId,
    required this.roundId,
    required this.leagueId,
  });

  @override
  ConsumerState<AddEventMatchPage> createState() => _AddEventMatchPageState();
}

class _AddEventMatchPageState extends ConsumerState<AddEventMatchPage> {
  @override
  Widget build(BuildContext context) {
    final currentTermState =
        ref.watch(getCurrentMatchTermProvider(widget.matchId));

    final termId = currentTermState.data?.id ?? 0;
    return Scaffold(
      appBar: MatchAppBarWidget(matchId: widget.matchId),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TeamTabsWidget(
              homeTeam: widget.homeTeam,
              awayTeam: widget.awayTeam,
            ),
            Expanded(
                child: PlayersTabViewWidget(
                  homeTeamId: widget.homeTeam.id!,
                  awayTeamId: widget.awayTeam.id!,
                  matchId: widget.matchId,
                  termId: termId,
                ),
              ),

            ControlButtonWidget(
              matchId: widget.matchId,
              leagueId: widget.leagueId,
              roundId: widget.roundId,
            ),
          ],
        ),
      ),
    );
  }
}




// class MatchDetailsPage extends ConsumerWidget {
//   final int matchId;
//
//   const MatchDetailsPage({super.key, required this.matchId});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final matchState = ref.watch(getFullMatchDataProvider(matchId));
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         leading: const BackButton(color: Colors.white),
//         backgroundColor: AppColors.secondaryColor,
//         title: const AutoSizeTextWidget(
//           text: 'تفاصيل المباراة',
//           colorText: Colors.white,
//         ),
//       ),
//       body: _buildMatchView(context, matchState.data),
//     );
//   }
//
//   /// 🏟️ بناء واجهة المباراة كاملة
//   Widget _buildMatchView(BuildContext context, MatchModel match) {
//     final home = match.homeTeam;
//     final away = match.awayTeam;
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           /// 🏆 رأس الصفحة (الفريقين + النتيجة)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _teamHeader(home, match.homeScore, true),
//               Column(
//                 children: [
//                   Text(
//                     "-",
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineSmall!
//                         .copyWith(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 6),
//                   // Text(
//                   //   _statusLabel(match.status),
//                   //   style: TextStyle(
//                   //     color: _statusColor(match.status),
//                   //     fontWeight: FontWeight.w600,
//                   //   ),
//                   // ),
//                 ],
//               ),
//               _teamHeader(away, match.awayScore, false),
//             ],
//           ),
//           const SizedBox(height: 24),
//           Text(
//             _statusLabel(match.status),
//             style: TextStyle(
//               color: _statusColor(match.status),
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//
//           /// 🕒 الأشواط والأحداث
//           for (final term in match.matchTerms)
//             _buildTermCard(context, term, match),
//         ],
//       ),
//     );
//   }
//
//   /// ⚽️ رأس كل فريق
//   Widget _teamHeader(TeamModel? team, int score, bool isHome) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         !isHome
//             ? AutoSizeTextWidget(
//                 text: "$score",
//                 fontSize: 24.sp,
//                 fontWeight: FontWeight.bold,
//               )
//             : SizedBox(),
//         Row(
//           children: [
//             if (isHome && team?.logoUrl != null)
//               CircleAvatar(
//                 backgroundImage: NetworkImage(team!.logoUrl!),
//                 radius: 20,
//               ),
//             if (isHome) const SizedBox(width: 8),
//             Text(
//               team?.teamName ?? "غير معروف",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             if (!isHome) const SizedBox(width: 8),
//             if (!isHome && team?.logoUrl != null)
//               CircleAvatar(
//                 backgroundImage: NetworkImage(team!.logoUrl!),
//                 radius: 20,
//               ),
//           ],
//         ),
//         //   Spacer(),
//         const SizedBox(width: 6),
//         isHome
//             ? AutoSizeTextWidget(
//                 text: "$score",
//                 fontSize: 24.sp,
//                 fontWeight: FontWeight.bold,
//               )
//             : SizedBox(),
//       ],
//     );
//   }
//
//   /// 🕒 كرت كل شوط
//   Widget _buildTermCard(
//       BuildContext context, MatchTermModel term, MatchModel match) {
//     final termGoals =
//         match.goals.where((g) => g.matchTermId == term.id).toList();
//     final termWarnings =
//         match.warnings.where((w) => w.matchTermId == term.id).toList();
//
//     final homeEvents =
//         _extractEvents(termGoals, termWarnings, match.homeTeamId);
//     final awayEvents =
//         _extractEvents(termGoals, termWarnings, match.awayTeamId);
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       // elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Text(
//               "🕒 ${term.id ?? 'الشوط'} (${term.startTime})",
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const Divider(height: 20),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// أحداث الفريق المضيف
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: _buildEventWidgets(homeEvents, true),
//                   ),
//                 ),
//
//                 Container(
//                   width: 1,
//                   height: 140,
//                   color: Colors.grey.shade300,
//                   margin: const EdgeInsets.symmetric(horizontal: 12),
//                 ),
//
//                 /// أحداث الفريق الضيف
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: _buildEventWidgets(awayEvents, false),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// 🧩 استخراج الأحداث الخاصة بكل فريق
//   List<Map<String, dynamic>> _extractEvents(
//     List<GoalModel> goals,
//     List<WarningModel> warnings,
//     int? teamId,
//   ) {
//     final goalEvents = goals
//         .where((g) => g.teamId == teamId)
//         .map((g) => {
//               "type": "goal",
//               "player": g.playerId.toString(),
//               "minute": g.goalTime,
//               "icon": "⚽️",
//             })
//         .toList();
//
//     final warnEvents = warnings
//         .where((w) => w.teamId == teamId)
//         .map((w) => {
//               "type": w.warningType,
//               "player": w.playerId.toString(),
//               "minute": w.warningTime,
//               "icon": w.warningType == "red" ? "🟥" : "🟨",
//             })
//         .toList();
//
//     final all = [...goalEvents, ...warnEvents];
//     //  all.sort((a, b) => (a["minute"] ?? 0).compareTo(b["minute"] ?? 0));
//     return all;
//   }
//
//   /// 🧱 بناء عناصر الأحداث
//   List<Widget> _buildEventWidgets(
//       List<Map<String, dynamic>> events, bool isHome) {
//     if (events.isEmpty) {
//       return [
//         Text(
//           "— لا توجد أحداث —",
//           style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
//         ),
//       ];
//     }
//
//     return events.map((e) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 3),
//         child: Row(
//           mainAxisAlignment:
//               isHome ? MainAxisAlignment.end : MainAxisAlignment.start,
//           children: [
//             if (!isHome)
//               Text("${e['icon']} ", style: const TextStyle(fontSize: 18)),
//             Text(
//               "${e['player']} (${e['minute']}')",
//               style: const TextStyle(fontWeight: FontWeight.w600),
//             ),
//             if (isHome)
//               Text(" ${e['icon']}", style: const TextStyle(fontSize: 18)),
//           ],
//         ),
//       );
//     }).toList();
//   }
//
//   /// 🎯 لون الحالة
//   Color _statusColor(String status) {
//     switch (status) {
//       case 'live':
//         return Colors.green;
//       case 'finished':
//         return Colors.grey;
//       default:
//         return Colors.orange;
//     }
//   }
//
//   /// 🎯 نص الحالة
//   String _statusLabel(String status) {
//     switch (status) {
//       case 'live':
//         return 'جارية';
//       case 'finished':
//         return 'انتهت';
//       default:
//         return 'قادمة';
//     }
//   }
// }
