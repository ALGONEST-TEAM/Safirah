import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../../data/model/league_for_prediction_model.dart';
import '../riverpod/prediction_riverpod.dart';
import 'send_or_edit_prediction_widget.dart';
import 'team_widget.dart';

class MatchCardWidget extends ConsumerWidget {
  final LeagueForPredictionModel data;
  final String date;

  const MatchCardWidget({super.key, required this.data, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusHelper = ref.watch(matchStatusHelperProvider);

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              spacing: 6.w,
              children: [
                OnlineImagesWidget(
                  imageUrl: data.logo,
                  backgroundColor: Colors.transparent,
                  size: Size(18.w, 18.h),
                ),
                AutoSizeTextWidget(
                  text: data.name,
                  fontSize: 10.6.sp,
                ),
              ],
            ),
          ),
          Divider(
            height: 6.h,
            color: AppColors.fontColor2.withValues(alpha: .15),
          ),
          Column(
            children: List.generate(data.matches.length, (i) {
              final item = data.matches[i];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (statusHelper.isNotStarted(item.status) &&
                          item.hasPrediction == false &&
                          Auth().loggedIn) {
                        showModalBottomSheetWidget(
                          context: context,
                          page: SendOrEditPredictionWidget(
                            league: data.name,
                            date: date,
                            matches: item,
                          ),
                        );
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (statusHelper.isNotStarted(item.status) &&
                            item.hasPrediction == false &&
                            Auth().loggedIn) ...[
                          6.w.horizontalSpace,
                          Icon(
                            Icons.arrow_circle_right_outlined,
                            color:
                                const Color(0xff5e5e84).withValues(alpha: .8),
                            size: 14.8.sp,
                          ),
                          4.w.horizontalSpace,
                        ],
                        TeamWidget(
                          name: item.homeTeam.name,
                          image: item.homeTeam.logo,
                          alignRight: true,
                        ),
                        Expanded(
                          child: AutoSizeTextWidget(
                            text: statusHelper.isNotStarted(item.status)
                                ? item.matchTime.substring(0, 5)
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
                        ),
                        2.w.horizontalSpace,
                        if (statusHelper.isLive(item.status))
                          AutoSizeTextWidget(
                            text: S.of(context).live,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w400,
                            colorText: AppColors.successSwatch.shade600,
                          ),
                        if (statusHelper.isFinished(item.status))
                          AutoSizeTextWidget(
                            text: S.of(context).finished,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w400,
                            colorText: AppColors.dangerSwatch.shade500,
                          ),
                        6.w.horizontalSpace,
                      ],
                    ),
                  ),
                  if (i != data.matches.length - 1)
                    Divider(
                      height: 4.h,
                      color: AppColors.fontColor2.withValues(alpha: .14),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
