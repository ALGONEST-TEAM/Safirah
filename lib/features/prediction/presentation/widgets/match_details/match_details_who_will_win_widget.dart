import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../riverpod/match_details_riverpod.dart';
import 'match_details_who_will_win_team_logo_widget.dart';
import '../../../data/model/match_details_model.dart';
import '../../../data/model/matches_predictions_model.dart';
import '../send_or_edit_prediction_widget.dart';

class MatchDetailsWhoWillWinWidget extends ConsumerWidget {
  final String leagueName;
  final MatchesPredictionsModel? match;
  final MatchDetailsModel? matchDetails;

  const MatchDetailsWhoWillWinWidget({
    super.key,
    required this.leagueName,
    this.match,
    this.matchDetails,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeLogo =
        matchDetails?.teams?.home?.logo ?? match?.homeTeam.logo ?? '';
    final awayLogo =
        matchDetails?.teams?.away?.logo ?? match?.awayTeam.logo ?? '';
    final homeName =
        matchDetails?.teams?.home?.name ?? match?.homeTeam.name ?? '';
    final awayName =
        matchDetails?.teams?.away?.name ?? match?.awayTeam.name ?? '';

    final bool hasPrediction =
        matchDetails?.hasPrediction == true || match?.hasPrediction == true;
    final int userHomeScore =
        matchDetails?.userHomeScore ?? match?.homeScore?.toInt() ?? 0;
    final int userAwayScore =
        matchDetails?.userAwayScore ?? match?.awayScore?.toInt() ?? 0;
    final int predictionId =
        matchDetails?.predictionId ?? match?.productionId ?? 0;

    // Create prediction model with the latest prediction details
    final MatchesPredictionsModel predictionModel = match?.copyWith(
          hasPrediction: hasPrediction,
          homeScore: userHomeScore,
          awayScore: userAwayScore,
          productionId: predictionId,
        ) ??
        MatchesPredictionsModel(
          matchId: matchDetails?.id ?? 0,
          matchDate: matchDetails?.date ?? '',
          matchTime: matchDetails?.time ?? '',
          hasPrediction: hasPrediction,
          homeScore: userHomeScore,
          awayScore: userAwayScore,
          productionId: predictionId,
          homeTeam: TeamModelForPrediction(
            id: matchDetails?.teams?.home?.id ?? 0,
            name: homeName,
            logo: homeLogo,
          ),
          awayTeam: TeamModelForPrediction(
            id: matchDetails?.teams?.away?.id ?? 0,
            name: awayName,
            logo: awayLogo,
          ),
        );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.greySwatch.shade100, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Card Title
          AutoSizeTextWidget(
            text: 'من سيربح؟',
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            colorText: AppColors.mainColorFont,
          ),
          16.h.verticalSpace,

          // Vote Options Row (RTL Layout: Child 0 = Home / Right side, Child 2 = Away / Left side)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Home Team (Right side in RTL)
              Expanded(
                child: Column(
                  children: [
                    MatchDetailsWhoWillWinTeamLogoWidget(logoUrl: homeLogo),
                    8.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: homeName,
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w600,
                      colorText: AppColors.mainColorFont,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Draw (X - Center)
              Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.greySwatch.shade50,
                  border: Border.all(
                      color: AppColors.greySwatch.shade200, width: 1),
                ),
                alignment: Alignment.center,
                child: AutoSizeTextWidget(
                  text: 'X',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  colorText: AppColors.fontColor2,
                ),
              ),

              // Away Team (Left side in RTL)
              Expanded(
                child: Column(
                  children: [
                    MatchDetailsWhoWillWinTeamLogoWidget(logoUrl: awayLogo),
                    8.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: awayName,
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w600,
                      colorText: AppColors.mainColorFont,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.h.verticalSpace,

          // Always Active Predict Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  hasPrediction ? Colors.white : AppColors.primaryColor,
              foregroundColor:
                  hasPrediction ? AppColors.primaryColor : Colors.white,
              minimumSize: Size(double.infinity, 38.h),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
                side: BorderSide(
                  color: hasPrediction
                      ? AppColors.primaryColor
                      : AppColors.greySwatch.shade100,
                  width: 0.8,
                ),
              ),
            ),
            onPressed: () {
              showModalBottomSheetWidget(
                context: context,
                page: SendOrEditPredictionWidget(
                  league: leagueName,
                  date: predictionModel.matchDate,
                  matches: predictionModel,
                  isEdit: hasPrediction,
                  onSuccess: (homeScore, awayScore) {
                    ref
                        .read(matchDetailsProvider(predictionModel.matchId).notifier)
                        .updatePrediction(
                          homeScore: homeScore,
                          awayScore: awayScore,
                        );
                    ref
                        .read(matchDetailsProvider(predictionModel.matchId).notifier)
                        .getMatchDetails(isRefresh: true);
                  },
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  hasPrediction ? Icons.edit : Icons.edit_outlined,
                  color: hasPrediction ? AppColors.primaryColor : Colors.white,
                  size: 16.r,
                ),
                8.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: hasPrediction ? 'تعديل التوقع' : 'توقع الآن',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  colorText:
                      hasPrediction ? AppColors.primaryColor : Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
