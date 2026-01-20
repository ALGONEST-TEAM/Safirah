import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/constants/app_icons.dart';
import 'package:safirah/core/extension/string.dart';

import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/league_for_prediction_model.dart';
import '../riverpod/prediction_riverpod.dart';
import 'matches_widget.dart';
import 'shimmer_matches_widget.dart';
import 'team_widget.dart';

class PredictionWidget extends ConsumerStatefulWidget {
  const PredictionWidget({super.key});

  @override
  ConsumerState<PredictionWidget> createState() => _PredictionWidgetState();
}

class _PredictionWidgetState extends ConsumerState<PredictionWidget> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getAllPredictionsProvider);

    return CheckStateInGetApiDataWidget(
      state: state,
      refresh: () {
        ref.invalidate(getAllPredictionsProvider);
      },
      widgetOfLoading: const ShimmerMatchesWidget(),
      widgetOfData: RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primaryColor,
        onRefresh: () async {
          ref.invalidate(getAllPredictionsProvider);
        },
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 12.h),
          itemCount: state.data.data.length,
          itemBuilder: (context, index) {
            final day = state.data.data[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 16.h),
                  child: AutoSizeTextWidget(
                    text: day.date,
                    fontSize: 10.6.sp,
                  ),
                ),
                ...day.leagues.map(
                  (league) => Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: PredictionCardWidget(
                      data: league,
                      date: day.date,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class PredictionCardWidget extends StatefulWidget {
  final LeagueForPredictionModel data;
  final String date;

  const PredictionCardWidget(
      {super.key, required this.data, required this.date});

  @override
  State<PredictionCardWidget> createState() => _PredictionCardWidgetState();
}

class _PredictionCardWidgetState extends State<PredictionCardWidget> {
  bool tempId = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4.sp),
          child: AutoSizeTextWidget(
            text: widget.data.name,
            fontSize: 10.6.sp,
          ),
        ),
        2.h.verticalSpace,
        Column(
          spacing: 6.h,
          children: List.generate(widget.data.matches.length, (i) {
            final item = widget.data.matches[i];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        tempId =!tempId;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: tempId == true ? 10.w : 6.w,
                              vertical: 3.h),
                          decoration: BoxDecoration(
                            color: item.statusColor!.toColor(),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r),
                            ),
                          ),
                          child: Column(
                            spacing: 2.h,
                            children: [
                              Row(
                                spacing: 2.w,
                                children: [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.white,
                                    size: 13.sp,
                                  ),
                                  AutoSizeTextWidget(
                                    text: "4",
                                    fontSize: 9.sp,
                                    colorText: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: tempId == true,
                                replacement: SvgPicture.asset(
                                  AppIcons.arrowBackEn,
                                  color: Colors.white,
                                  height: 15.h,
                                ),
                                child: AutoSizeTextWidget(
                                  text: "${item.homeScore} - ${item.awayScore}",
                                  colorText: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TeamWidget(
                            name: item.homeTeam.name,
                            image: item.homeTeam.logo,
                            alignRight: true),
                        Expanded(
                          child: AutoSizeTextWidget(
                            text: item.status == 1
                                ? item.matchTime.substring(0, 5)
                                : "${item.homeTeam.score} - ${item.awayTeam.score}",
                            fontSize: 12.2.sp,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TeamWidget(
                          name: item.awayTeam.name,
                          image: item.awayTeam.logo,
                          alignRight: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
