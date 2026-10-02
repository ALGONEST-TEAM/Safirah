import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/design_please_login_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../../data/model/matches_predictions_model.dart';
import '../pages/match_details_page.dart';
import '../riverpod/prediction_riverpod.dart';
import 'send_or_edit_prediction_widget.dart';
import 'team_widget.dart';

class NormalMatchItemWidget extends StatelessWidget {
  final MatchesPredictionsModel item;
  final bool isInMatchesTeam;
  final String? leagueName;
  final String? date;

  const NormalMatchItemWidget({
    super.key,
    required this.item,
    this.isInMatchesTeam = false,
    this.leagueName,
    this.date,
  });

  static String _formatTime(String time) {
    if (time.isEmpty || time.contains('ص') || time.contains('م')) return time;
    try {
      final parts = time.split(':');
      if (parts.length >= 2) {
        int hour = int.parse(parts[0]);
        final String minute = parts[1].substring(0, 2);
        String amPm = 'ص';
        if (hour >= 12) {
          amPm = 'م';
          if (hour > 12) hour -= 12;
        } else if (hour == 0) {
          hour = 12;
        }
        final String hourStr = hour.toString().padLeft(2, '0');
        return '$hourStr:$minute $amPm';
      }
    } catch (_) {}
    if (time.length >= 5) return time.substring(0, 5);
    return time;
  }

  @override
  Widget build(BuildContext context) {
    const statusHelper = MatchStatusHelper();
    final bool canPredict = statusHelper.isNotStarted(item.status) && !isInMatchesTeam;

    return GestureDetector(
      onTap: isInMatchesTeam == true
          ? null
          : () {
              navigateTo(
                context,
                MatchDetailsPage(
                  matchId: item.matchId,
                ),
              );
            },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          children: [
            if (statusHelper.isFinished(item.status)) ...[
              AutoSizeTextWidget(
                text: S.of(context).finished,
                fontSize: 7.sp,
                minFontSize: 8.sp,
                colorText: const Color(0xff454545),
              ),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TeamWidget(
                  name: item.homeTeam.name,
                  image: item.homeTeam.logo,
                  alignRight: true,
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                ),
                Expanded(
                  child: AutoSizeTextWidget(
                    text: statusHelper.isNotStarted(item.status)
                        ? _formatTime(item.matchTime)
                        : "${item.homeTeam.score} - ${item.awayTeam.score}",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
                TeamWidget(
                  name: item.awayTeam.name,
                  image: item.awayTeam.logo,
                  alignRight: false,
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                ),
              ],
            ),
            if (canPredict) ...[
              6.h.verticalSpace,
              _PredictButton(
                item: item,
                leagueName: leagueName,
                date: date,
              ),
              2.h.verticalSpace,
            ],
          ],
        ),
      ),
    );
  }
}

class _PredictButton extends StatelessWidget {
  final MatchesPredictionsModel item;
  final String? leagueName;
  final String? date;

  const _PredictButton({
    required this.item,
    this.leagueName,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasPrediction = item.hasPrediction == true;
    final Color secondaryColor = AppColors.secondaryColor;

    final String buttonText;
    if (hasPrediction) {
      if (item.homeScore != null && item.awayScore != null) {
        buttonText = 'تعديل التوقع (${item.homeScore} - ${item.awayScore})';
      } else {
        buttonText = 'تعديل التوقع';
      }
    } else {
      buttonText = 'توقع النتيجة';
    }

    final borderRadius = BorderRadius.circular(8.r);

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (!Auth().loggedIn) {
              showModalBottomSheetWidget(
                context: context,
                page: const DesignPleaseLoginWidget(),
              );
              return;
            }

            showModalBottomSheetWidget(
              context: context,
              page: SendOrEditPredictionWidget(
                league: leagueName ?? '',
                date: date ?? item.matchDate,
                matches: item,
                isEdit: hasPrediction,
              ),
            );
          },
          borderRadius: borderRadius,
          splashColor: secondaryColor.withValues(alpha: 0.12),
          highlightColor: secondaryColor.withValues(alpha: 0.05),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 5.5.h),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: borderRadius,
              border: Border.all(
                color: secondaryColor,
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  hasPrediction ? Icons.edit_outlined : Icons.stars_rounded,
                  color: secondaryColor,
                  size: 13.5.r,
                ),
                6.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: buttonText,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  colorText: secondaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
