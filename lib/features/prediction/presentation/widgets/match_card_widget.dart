import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../../data/model/league_for_prediction_model.dart';
import '../../data/model/matches_predictions_model.dart';
import '../pages/match_details_page.dart';
import '../riverpod/prediction_riverpod.dart';
import 'live_match_item_widget.dart';
import 'normal_match_item_widget.dart';

class MatchCardWidget extends ConsumerWidget {
  final LeagueForPredictionModel data;
  final String date;
  final bool hideHeader;

  const MatchCardWidget({
    super.key,
    required this.data,
    required this.date,
    this.hideHeader = false,
  });

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
          if (!hideHeader) ...[
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
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            Divider(
              height: 6.h,
              color: AppColors.fontColor2.withValues(alpha: .15),
            ),
          ],
          Column(
            children: List.generate(data.matches.length, (i) {
              final item = data.matches[i];
              final isLiveMatch = statusHelper.isLive(item.status);

              return Column(
                children: [
                  if (isLiveMatch)
                    LiveMatchItemWidget(item: item,isInMatchesTeam: hideHeader,)
                  else
                    NormalMatchItemWidget(item: item,isInMatchesTeam: hideHeader,),
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
