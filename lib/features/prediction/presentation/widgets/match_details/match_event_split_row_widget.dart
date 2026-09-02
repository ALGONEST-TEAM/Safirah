import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'match_events_list_widget.dart';
import 'match_event_away_content_widget.dart';
import 'match_event_home_content_widget.dart';
import 'match_event_minute_badge_widget.dart';
import 'match_event_added_time_widget.dart';
import 'match_event_score_row_widget.dart';

// ── Master Row to position items in a Split Timeline ────────────────────────
class MatchEventSplitRowWidget extends StatelessWidget {
  final MatchEventItem event;

  const MatchEventSplitRowWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    if (event.type == MatchEventType.addedTime) {
      return MatchEventAddedTimeWidget(label: event.label ?? '');
    }

    if (event.type == MatchEventType.halfTime || event.type == MatchEventType.fullTime) {
      return MatchEventScoreRowWidget(
        prefix: event.type == MatchEventType.halfTime ? 'HT' : 'FT',
        score: event.score ?? '',
      );
    }

    final isHome = event.isHome;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          // 1. Right Column (Home team content in RTL)
          Expanded(
            child: isHome
                ? MatchEventHomeContentWidget(event: event)
                : const SizedBox.shrink(),
          ),

          8.w.horizontalSpace,

          // 2. Center Column (Minute Badge)
          MatchEventMinuteBadgeWidget(minute: event.minute ?? 0),

          8.w.horizontalSpace,

          // 3. Left Column (Away team content in RTL)
          Expanded(
            child: isHome
                ? const SizedBox.shrink()
                : MatchEventAwayContentWidget(event: event),
          ),
        ],
      ),
    );
  }
}

