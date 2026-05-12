import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../state_mangement/riverpod.dart';

class PenaltyScoreFinishWidget extends ConsumerStatefulWidget {
  const PenaltyScoreFinishWidget({
    super.key,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.matchSyncId,
    required this.matchTermSyncId,
    this.initialHomePenaltyScore,
    this.initialAwayPenaltyScore,
    this.isStandaloneScreen = false,
  });

  final String homeTeamName;
  final String awayTeamName;
  final String matchSyncId;
  final String matchTermSyncId;
  final int? initialHomePenaltyScore;
  final int? initialAwayPenaltyScore;
  final bool isStandaloneScreen;

  @override
  ConsumerState<PenaltyScoreFinishWidget> createState() =>
      _PenaltyScoreFinishWidgetState();
}

class _PenaltyScoreFinishWidgetState
    extends ConsumerState<PenaltyScoreFinishWidget> {
  late final TextEditingController _homePenaltyController;
  late final TextEditingController _awayPenaltyController;

  @override
  void initState() {
    super.initState();
    _homePenaltyController = TextEditingController(
      text: widget.initialHomePenaltyScore?.toString() ?? '',
    );
    _awayPenaltyController = TextEditingController(
      text: widget.initialAwayPenaltyScore?.toString() ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant PenaltyScoreFinishWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldHome = oldWidget.initialHomePenaltyScore?.toString() ?? '';
    final oldAway = oldWidget.initialAwayPenaltyScore?.toString() ?? '';
    final newHome = widget.initialHomePenaltyScore?.toString() ?? '';
    final newAway = widget.initialAwayPenaltyScore?.toString() ?? '';

    if (_homePenaltyController.text.trim() == oldHome && oldHome != newHome) {
      _homePenaltyController.text = newHome;
    }
    if (_awayPenaltyController.text.trim() == oldAway && oldAway != newAway) {
      _awayPenaltyController.text = newAway;
    }
  }

  @override
  void dispose() {
    _homePenaltyController.dispose();
    _awayPenaltyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(penaltyShootoutFinishProvider);
    final isStandaloneScreen = widget.isStandaloneScreen;
    final outerPadding = isStandaloneScreen
        ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h)
        : EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h);
    final cardPadding = EdgeInsets.all(isStandaloneScreen ? 22.r : 12.r);
    final titleFontSize = isStandaloneScreen ? 18.sp : 13.sp;
    final subtitleFontSize = isStandaloneScreen ? 12.5.sp : 10.5.sp;
    final sectionSpacing = isStandaloneScreen ? 18.h : 12.h;

    return Padding(
      padding: outerPadding,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: isStandaloneScreen ? 320.h : 0,
        ),
        padding: cardPadding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isStandaloneScreen ? 20.r : 12.r),
          boxShadow: isStandaloneScreen
              ? [
                  BoxShadow(
                    color: AppColors.secondaryColor.withValues(alpha: .08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
          border: Border.all(
            color: AppColors.secondaryColor
                .withValues(alpha: isStandaloneScreen ? .18 : .12),
          ),
        ),
        child: Column(
          mainAxisAlignment:
              isStandaloneScreen ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AutoSizeTextWidget(
              text: 'إدخال نتيجة ركلات الترجيح',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
              colorText: AppColors.secondaryColor,
            ),
            (isStandaloneScreen ? 10.h : 6.h).verticalSpace,
            AutoSizeTextWidget(
              text: 'أدخل نتيجة البلنتيات النهائية ثم أنهِ المباراة.',
              fontSize: subtitleFontSize,
              textAlign: TextAlign.center,
              colorText: Colors.black87,
              maxLines: 2,
            ),
            sectionSpacing.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: _PenaltyTeamField(
                    label: widget.homeTeamName,
                    controller: _homePenaltyController,
                    isStandaloneScreen: isStandaloneScreen,
                  ),
                ),
                10.w.horizontalSpace,
                Expanded(
                  child: _PenaltyTeamField(
                    label: widget.awayTeamName,
                    controller: _awayPenaltyController,
                    isStandaloneScreen: isStandaloneScreen,
                  ),
                ),
              ],
            ),
            sectionSpacing.verticalSpace,
            CheckStateInPostApiDataWidget(
              state: state,
              hasMessageSuccess: true,
              messageSuccess: 'تم حفظ نتيجة البلنتيات وإنهاء المباراة',
              functionSuccess: () {},
              bottonWidget: DefaultButtonWidget(
                text: 'حفظ نتيجة البلنتيات وإنهاء المباراة',
                height: isStandaloneScreen ? 52.h : null,
                textSize: isStandaloneScreen ? 14.sp : null,
                borderRadius: isStandaloneScreen ? 12.r : null,
                isLoading: state.stateData == States.loading,
                onPressed: () async {
                  final homePenaltyScore =
                      int.tryParse(_homePenaltyController.text.trim());
                  final awayPenaltyScore =
                      int.tryParse(_awayPenaltyController.text.trim());

                  if (homePenaltyScore == null || awayPenaltyScore == null) {
                    showFlashBarError(
                      context: context,
                      title: 'بيانات غير مكتملة',
                      text: 'يرجى إدخال نتيجة صحيحة لكلا الفريقين قبل إنهاء المباراة.',
                    );
                    return;
                  }

                  await ref.read(penaltyShootoutFinishProvider.notifier).run(
                        matchSyncId: widget.matchSyncId,
                        matchTermSyncId: widget.matchTermSyncId,
                        homePenaltyScore: homePenaltyScore,
                        awayPenaltyScore: awayPenaltyScore,
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PenaltyTeamField extends StatelessWidget {
  const _PenaltyTeamField({
    required this.label,
    required this.controller,
    required this.isStandaloneScreen,
  });

  final String label;
  final TextEditingController controller;
  final bool isStandaloneScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AutoSizeTextWidget(
          text: label,
          textAlign: TextAlign.center,
          fontSize: isStandaloneScreen ? 13.sp : 11.sp,
          fontWeight: FontWeight.w600,
        ),
        (isStandaloneScreen ? 8.h : 6.h).verticalSpace,
        TextFormFieldWidget(
          controller: controller,
          type: TextInputType.number,
          fillColor: AppColors.scaffoldColor,
          hintText: '0',
          textAlign: TextAlign.center,
          fontSizeText: isStandaloneScreen ? 16.sp : null,
          hintFontSize: isStandaloneScreen ? 14.sp : null,
          contentPadding: EdgeInsets.symmetric(
            vertical: isStandaloneScreen ? 18.h : 12.h,
            horizontal: 12.w,
          ),
        ),
      ],
    );
  }
}



