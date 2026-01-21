import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../data/model/league_for_prediction_model.dart';
import '../riverpod/prediction_riverpod.dart';
import 'match_points_status_widget.dart';
import 'match_status_action_widget.dart';
import 'send_or_edit_prediction_widget.dart';
import 'team_widget.dart';

class PredictionCardWidget extends ConsumerStatefulWidget {
  final LeagueForPredictionModel data;
  final String date;

  const PredictionCardWidget(
      {super.key, required this.data, required this.date});

  @override
  ConsumerState<PredictionCardWidget> createState() =>
      _PredictionCardWidgetState();
}

class _PredictionCardWidgetState extends ConsumerState<PredictionCardWidget> {
  final Set<int> openedMatches = {};

  @override
  Widget build(BuildContext context) {
    final statusHelper = ref.watch(matchStatusHelperProvider);
    final rtl = Directionality.of(context) == TextDirection.rtl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.sp),
          child: Row(
            spacing: 6.w,
            children: [
              OnlineImagesWidget(
                imageUrl: widget.data.logo,
                backgroundColor: Colors.transparent,
                size:  Size(18.w, 18.h),
              ),
              AutoSizeTextWidget(
                text: widget.data.name,
                fontSize: 10.6.sp,
              ),
            ],
          ),
        ),
        Column(
          spacing: 6.h,
          children: List.generate(widget.data.matches.length, (i) {
            final item = widget.data.matches[i];
            final isOpened = openedMatches.contains(item.matchId);

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8.r)),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (isOpened) {
                      openedMatches.remove(item.matchId);
                    } else {
                      openedMatches.add(item.matchId);
                    }
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MatchPointsStatusWidget(
                      isOpened: isOpened,
                      rtl: rtl,
                      statusColor: item.statusColor,
                      pointsEarned: item.pointsEarned,
                      homeScore: item.homeScore,
                      awayScore: item.awayScore,
                    ),
                    Flexible(
                      child: TeamWidget(
                        name: item.homeTeam.name,
                        image: item.homeTeam.logo,
                        alignRight: true,
                      ),
                    ),
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: statusHelper.isNotStarted(item.status)
                            ? item.matchTime.substring(0, 5)
                            : "${item.homeTeam.score} - ${item.awayTeam.score}",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      child: TeamWidget(
                        name: item.awayTeam.name,
                        image: item.awayTeam.logo,
                        alignRight: false,
                      ),
                    ),
                    MatchStatusActionWidget(
                      status: item.status,
                      rtl: rtl,
                      onEditTap: () {
                        showModalBottomSheetWidget(
                          context: context,
                          page: SendOrEditPredictionWidget(
                            league: widget.data.name,
                            date: widget.date,
                            matches: item,
                            isEdit: true,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
