import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../match/data/model/match_model.dart';
import '../../../match/presntaion/helpers/match_score_presentation_helper.dart';
import '../state_mangement/riverpod.dart';

String buildMatchScoreLabel(MatchModel? match) {
  final score = buildMatchScorePresentation(
    match,
    showPenaltyOnlyWhenFinished: false,
  );
  if (!score.hasSecondaryText) {
    return score.primaryText;
  }

  return '${score.primaryText} • ${score.secondaryText}';
}

class MatchAppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  final String matchSyncId;
  const MatchAppBarWidget({super.key, required this.matchSyncId});

  String _formatTime(int seconds) {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final termState = ref.watch(matchTermCounterProvider(matchSyncId));
    final matchState = ref.watch(getFullMatchDataProvider(matchSyncId));
    final scoreLabel = buildMatchScoreLabel(
      matchState.stateData == States.loaded ? matchState.data : null,
    );

    return SecondaryAppBarWidget(

      title: 'احداث المباراة',

      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Container(
            constraints: BoxConstraints(maxWidth: 170.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border:
                  const Border.fromBorderSide(BorderSide(color: Color(0x2E1D1750))),
            ),
            child: AutoSizeTextWidget(
              text: scoreLabel,
              fontSize: 11.sp,
              maxFontSize: 12,
              minFontSize: 8,
              fontWeight: FontWeight.w700,
              colorText: AppColors.secondaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: AutoSizeTextWidget(
              text: _formatTime(termState.data.elapsedSeconds),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              colorText: Colors.white,
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
