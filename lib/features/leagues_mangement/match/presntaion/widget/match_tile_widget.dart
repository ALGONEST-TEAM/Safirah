import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../match_term_event/presntation/page/add_event_match_page.dart';
import '../../../leagues/persntaion/page/report_of_match_in_league_page.dart';
import '../../data/model/match_model.dart';
import '../page/match_details_page.dart';
import '../page/schedule_match_page.dart';

class MatchTileWidget extends StatelessWidget {
  final MatchModel match;
  final String leagueSyncId;
  final String matchFilter;
  final String roundSyncId;
  final String role;

  const MatchTileWidget(
      {super.key,
      required this.match,
      required this.leagueSyncId,
      required this.roundSyncId,
      required this.role,
      required this.matchFilter});

  String dataInMatch() {
    if (match.status == 'unscheduled') {
      return '-:-';
    } else if (match.status == 'scheduled') {
      final dt = match.scheduledStartTime ?? match.matchDate;
      if (dt == null) return '-:-';
      return DateFormat('hh:mm a', 'ar').format(dt);
    } else {
      return '${match.awayScore}:${match.homeScore}';
    }
  }

  void _handleTap(BuildContext context) {
    // 1) إذا المباراة غير مجدولة، دائماً نذهب لصفحة الجدولة
    if (match.status == 'unscheduled') {
      navigateTo(
        context,
        ScheduleMatchPage(
          leagueSyncId: leagueSyncId,
          matchSyncId: match.syncId!,
        ),
      );
      return;
    }

    // 2) Role: media -> تقرير المباراة داخل الدوري
    if (role == 'Media') {
      navigateTo(
        context,
        ReportOfMatchInLeaguePage(
          leagueSyncId: leagueSyncId,
          matchSyncId: (match.syncId ?? 0).toString(),
        ),
      );
      return;
    }
    if (role == 'organizer' ||
        (match.status == 'finished' && role != 'Referee')) {
      navigateTo(
          context,
          MatchDetailsPage(
            matchSyncId: match.syncId!,

          ));
      return;
    }
    // 3) Role: organizer -> يبقى على صفحة الجدولة (حسب السلوك الحالي عندك)
    if (role == 'organizer') {
      navigateTo(
        context,
        ScheduleMatchPage(
          leagueSyncId: leagueSyncId,
          matchSyncId: match.syncId!,
        ),
      );
      return;
    }

    // 4) باقي الأدوار -> إضافة أحداث/تفاصيل المباراة
    navigateTo(
      context,
      AddEventMatchPage(
        awayTeam: match.awayTeam!,
        homeTeam: match.homeTeam!,
        matchTerm: match.matchTerms,
        matchSyncId: (match.syncId ?? 0).toString(),
        roundSyncId: roundSyncId,
        leagueSyncId: leagueSyncId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dt = match.matchDate;
    final dateText = dt == null
        ? ''
        : '${DateFormat('EEEE', 'ar').format(dt)}  ${DateFormat.yMMMMd('ar').format(dt)}';

    return GestureDetector(
      onTap: () => _handleTap(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            child: AutoSizeTextWidget(
              text: dateText,
            ),
          ),
          const Divider(height: 1, color: Color(0xffF2F0FB)),
          ListTile(
            title: Row(

              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AutoSizeTextWidget(
                          text: match.homeTeam!.teamName, fontSize: 11.5.sp),
                       SizedBox(width: 6.w),
                      OnlineImagesWidget(
                        imageUrl: '',
                        fit: BoxFit.cover,
                        size: Size(23.w, 23.h),
                        borderRadius: 12.r,
                      ),
                    ],
                  ),
                ),
                 SizedBox(width: 10.w),
                AutoSizeTextWidget(
                  text: dataInMatch(),
                ),
                 SizedBox(width: 10.w),
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
        ],
      ),
    );
  }
}
