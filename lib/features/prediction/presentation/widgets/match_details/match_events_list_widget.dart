import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_events_model.dart';
import '../../provider/match_events_ui_provider.dart';
import 'match_event_split_row_widget.dart';

export '../../provider/match_events_ui_provider.dart'
    show MatchEventType, MatchEventItem;

class MatchEventsListWidget extends StatelessWidget {
  final List<MatchSingleEventModel> events;
  final List<MatchEventPeriodModel> periods;
  final List<MatchEventItem>? precomputedTimelineItems;

  const MatchEventsListWidget({
    super.key,
    required this.events,
    required this.periods,
    this.precomputedTimelineItems,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
        ),
        child: Center(
          child: AutoSizeTextWidget(
            text: 'لا توجد أحداث حالياً',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            colorText: AppColors.fontColor2,
          ),
        ),
      );
    }

    final List<MatchEventItem> items =
        precomputedTimelineItems ?? _fallbackBuildItems();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header matching MatchEventsKeyStatsWidget & MatchEventsBestPlayerWidget
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: AutoSizeTextWidget(
              text: 'الأحداث',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              colorText: AppColors.fontColor,
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(height: 1, color: Color(0xfff5f3f9)),

          // Event rows using the split layout orchestrator
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return MatchEventSplitRowWidget(event: items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<MatchEventItem> _fallbackBuildItems() {
    final List<MatchEventItem> items = [];
    final firstHalfEvents = events.where((e) => e.parsedMinute <= 45).toList();
    final secondHalfEvents = events.where((e) => e.parsedMinute > 45).toList();

    final p2 = periods.firstWhere(
      (p) => p.code == '2nd-half' || p.code.contains('2'),
      orElse: () => MatchEventPeriodModel(
        sportmonksPeriodId: 0,
        code: '',
        name: '',
      ),
    );
    if (p2.scoreAtEnd != null && p2.scoreAtEnd!.isNotEmpty) {
      items.add(MatchEventItem(
        type: MatchEventType.fullTime,
        score: p2.scoreAtEnd,
      ));
    }
    if (p2.timeAdded != null && p2.timeAdded! > 0) {
      items.add(MatchEventItem(
        type: MatchEventType.addedTime,
        label: 'تم إضافة ${p2.timeAdded}+ دقائق',
      ));
    }

    for (final e in secondHalfEvents.reversed) {
      items.add(e.toUIItem());
    }

    final p1 = periods.firstWhere(
      (p) => p.code == '1st-half' || p.code.contains('1'),
      orElse: () => MatchEventPeriodModel(
        sportmonksPeriodId: 0,
        code: '',
        name: '',
      ),
    );
    if (p1.scoreAtEnd != null && p1.scoreAtEnd!.isNotEmpty) {
      items.add(MatchEventItem(
        type: MatchEventType.halfTime,
        score: p1.scoreAtEnd,
      ));
    } else if (events.isNotEmpty) {
      items.add(const MatchEventItem(type: MatchEventType.halfTime, score: 'HT'));
    }
    if (p1.timeAdded != null && p1.timeAdded! > 0) {
      items.add(MatchEventItem(
        type: MatchEventType.addedTime,
        label: 'تم إضافة ${p1.timeAdded}+ دقائق',
      ));
    }

    for (final e in firstHalfEvents.reversed) {
      items.add(e.toUIItem());
    }

    return items;
  }
}
