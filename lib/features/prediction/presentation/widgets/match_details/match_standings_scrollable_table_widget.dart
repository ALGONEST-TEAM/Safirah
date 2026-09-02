import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/model/match_fixture_standings_model.dart';
import 'match_standings_cell_widget.dart';
import 'match_standings_scrollable_row_widget.dart';

class MatchStandingsScrollableTableWidget extends StatelessWidget {
  final List<MatchTeamStandingItemModel> standingsItems;
  final double dynamicGap;
  final Color Function(MatchTeamStandingItemModel) getHighlightColor;

  const MatchStandingsScrollableTableWidget({
    super.key,
    required this.standingsItems,
    required this.dynamicGap,
    required this.getHighlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(), // Non-stretching clamp
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Scrollable Table Header
              Container(
                height: 32.h,
                padding: EdgeInsets.only(right: 8.w, left: 8.w),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                     MatchStandingsCellWidget(text: '', width: 105.w, isHeader: true),
                    SizedBox(width: dynamicGap),
                     MatchStandingsCellWidget(text: 'لعب', width: 32.w, isHeader: true),
                     MatchStandingsCellWidget(text: '+/-', width: 48.w, isHeader: true),
                     MatchStandingsCellWidget(text: 'نقاط', width: 36.w, isHeader: true),
                     MatchStandingsCellWidget(text: 'ف', width: 28.w, isHeader: true),
                     MatchStandingsCellWidget(text: 'ت', width: 28.w, isHeader: true),
                     MatchStandingsCellWidget(text: 'خ', width: 28.w, isHeader: true),
                     MatchStandingsCellWidget(text: 'فارق', width: 36.w, isHeader: true),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xfff5f3f9)),

              // Scrollable Data Rows
              for (int i = 0; i < standingsItems.length; i++) ...[
                if (i > 0) const Divider(height: 1, color: Color(0xfff5f3f9)),
                MatchStandingsScrollableRowWidget(
                  item: standingsItems[i],
                  dynamicGap: dynamicGap,
                  highlightColor: getHighlightColor(standingsItems[i]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
