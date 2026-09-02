import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_fixture_standings_model.dart';
import 'match_standings_pinned_row_widget.dart';

class MatchStandingsPinnedColumnWidget extends StatelessWidget {
  final List<MatchTeamStandingItemModel> standingsItems;
  final Color Function(MatchTeamStandingItemModel) getHighlightColor;
  final Color Function(MatchTeamStandingItemModel) getQualificationColor;

  const MatchStandingsPinnedColumnWidget({
    super.key,
    required this.standingsItems,
    required this.getHighlightColor,
    required this.getQualificationColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.w,
      child: Column(
        children: [
          // Pinned Table Header (#)
          Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: AutoSizeTextWidget(
              text: '#',
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              colorText: AppColors.fontColor2,
            ),
          ),
          const Divider(height: 1, color: Color(0xfff5f3f9)),

          // Pinned Team Logo Rows
          for (int i = 0; i < standingsItems.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: Color(0xfff5f3f9)),
            MatchStandingsPinnedRowWidget(
              item: standingsItems[i],
              highlightColor: getHighlightColor(standingsItems[i]),
              qualificationColor: getQualificationColor(standingsItems[i]),
            ),
          ],
        ],
      ),
    );
  }
}
