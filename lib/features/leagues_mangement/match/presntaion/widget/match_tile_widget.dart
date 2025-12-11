import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../match_term_event/presntation/page/add_event_match_page.dart';
import '../../data/model/match_model.dart';
import '../page/schedule_match_page.dart';

class MatchTileWidget extends StatelessWidget {
  final MatchModel match;
  final int leagueId;
  final String matchFilter;
  final int roundId;

  const MatchTileWidget(
      {super.key,
        required this.match,
        required this.leagueId,
        required this.roundId,
        required this.matchFilter});

  String dataInMatch() {
    if (match.status == 'unscheduled') {
      return '-:-';
    } else if (match.status == 'scheduled') {
      return DateFormat('hh:mm a', 'ar').format(match.scheduledStartTime!);
    } else {
      return '${match.awayScore}:${match.homeScore}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          match.status == 'unscheduled'
              ? ScheduleMatchPage(
            leagueId: leagueId,
            matchId: match.id!,
          )
              : AddEventMatchPage(
            awayTeam: match.awayTeam!,
            homeTeam: match.homeTeam!,
            matchTerm: match.matchTerms ?? [],
            matchId: match.id ?? 0,
            roundId: roundId,
            leagueId: leagueId,
          ),
        );
      },
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AutoSizeTextWidget(
                      text: match.homeTeam!.teamName, fontSize: 11.5.sp),
                  const SizedBox(width: 6),
                  OnlineImagesWidget(
                    imageUrl: '',
                    fit: BoxFit.cover,
                    size: Size(23.w, 23.h),
                    borderRadius: 12.r,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            AutoSizeTextWidget(
              text: dataInMatch(),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Row(
                children: [
                  OnlineImagesWidget(
                    imageUrl: '',
                    fit: BoxFit.cover,
                    size: Size(23.w, 23.h),
                    borderRadius: 8.r,
                  ),
                  const SizedBox(width: 6),
                  AutoSizeTextWidget(
                      text: match.awayTeam!.teamName, fontSize: 11.5.sp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
