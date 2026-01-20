import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/extension/string.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/matches_predictions_model.dart';
import '../riverpod/prediction_riverpod.dart';
import 'prediction_fields_widget.dart';
import 'team_widget.dart';

class SendPredictionWidget extends ConsumerStatefulWidget {
  final String league;
  final String date;

  final MatchesPredictionsModel matches;

  const SendPredictionWidget({
    super.key,
    required this.league,
    required this.date,
    required this.matches,
  });

  @override
  ConsumerState<SendPredictionWidget> createState() =>
      _SendPredictionWidgetState();
}

class _SendPredictionWidgetState extends ConsumerState<SendPredictionWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _homeController = TextEditingController();
  final TextEditingController _awayController = TextEditingController();

  @override
  void dispose() {
    _homeController.dispose();
    _awayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(sendPredictionProvider);

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeTextWidget(
              text: widget.league,
              fontSize: 10.6.sp,
            ),
            Divider(
              height: 18.h,
              color: AppColors.fontColor2.withValues(alpha: .15),
            ),
            AutoSizeTextWidget(
              text: widget.date,
              fontSize: 10.6.sp,
            ),
            Divider(
              height: 18.h,
              color: AppColors.fontColor2.withValues(alpha: .15),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TeamWidget(
                  name: widget.matches.homeTeam.name,
                  image: widget.matches.homeTeam.logo,
                  alignRight: true,
                  fontSize: 11.8.sp,
                  sizeImage: Size(26.w, 26.h),
                  width: 120.w,
                ),
                Expanded(
                  child: AutoSizeTextWidget(
                    text: widget.matches.matchTime.substring(0, 5),
                    fontSize: 13.6.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
                TeamWidget(
                  name: widget.matches.awayTeam.name,
                  image: widget.matches.awayTeam.logo,
                  alignRight: false,
                  fontSize: 11.8.sp,
                  sizeImage: Size(26.w, 26.h),
                  width: 120.w,
                ),
              ],
            ),
            PredictionFieldsWidget(
              homeController: _homeController,
              awayController: _awayController,
            ),
            20.h.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CheckStateInPostApiDataWidget(
                    state: state,
                    functionSuccess: () {
                      Navigator.pop(context);
                      ref.invalidate(getAllMatchesProvider);
                      ref.invalidate(getAllPredictionsProvider);
                    },
                    bottonWidget: DefaultButtonWidget(
                      text: S.of(context).confirm,
                      height: 38.h,
                      borderRadius: 12.sp,
                      textSize: 12.sp,
                      isLoading: state.stateData == States.loading,
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        ref.read(sendPredictionProvider.notifier).send(
                              matchId: widget.matches.matchId,
                              homeScore: _homeController.text.toInt(),
                              awayScore: _awayController.text.toInt(),
                            );
                      },
                    ),
                  ),
                ),
                30.w.horizontalSpace,
                Expanded(
                  child: DefaultButtonWidget(
                    text: S.of(context).cancel,
                    height: 38.h,
                    borderRadius: 12.sp,
                    textSize: 12.sp,
                    background: AppColors.scaffoldColor,
                    textColor: AppColors.fontColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
