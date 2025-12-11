import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/widgets/buttons/default_button.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../match/presntaion/state_managment/riverpod.dart';
import '../state_mangement/riverpod.dart';
import '../widget/knockout_rule_selector_widget.dart';
import '../widget/match_duration_selector_widget.dart';
import '../widget/term_count_selector_widget.dart';

class LeagueTermSetupPage extends ConsumerStatefulWidget {
  const LeagueTermSetupPage({super.key, required this.leagueId});

  final int leagueId;

  @override
  ConsumerState<LeagueTermSetupPage> createState() =>
      _LeagueTermSetupPageState();
}

class _LeagueTermSetupPageState extends ConsumerState<LeagueTermSetupPage> {
  int? selectedTermsCount; // 1 = شوط, 2 = شوطين
  bool includeExtraAndPenalties = false;
  int matchDuration = 60; // الوقت الافتراضي بالدقائق

  @override
  Widget build(BuildContext context) {
    final termsState = ref.watch(termsProvider);
    final leagueTermState = ref.watch(leagueTermProvider(widget.leagueId));

    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeTextWidget(
          text: "تهيئة الدوري",
          colorText: Colors.white,
        ),
        backgroundColor: AppColors.secondaryColor,
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: termsState.stateData == States.loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🏁 عدد الأشواط
                    TermCountSelectorWidget(
                      selectedTermsCount: selectedTermsCount,
                      onChanged: (v) => setState(() => selectedTermsCount = v),
                    ),

                    20.h.verticalSpace,

                    /// ⏱️ الوقت (عداد)
                    MatchDurationSelectorWidget(
                      matchDuration: matchDuration,
                      onChanged: (v) => setState(() => matchDuration = v),
                    ),

                    20.h.verticalSpace,

                    /// ⚽ البلنتيات / الأشواط الإضافية
                    KnockoutRuleSelectorWidget(
                      includeExtraAndPenalties: includeExtraAndPenalties,
                      onChanged: (v) =>
                          setState(() => includeExtraAndPenalties = v),
                    ),

                    const Spacer(),
                    CheckStateInPostApiDataWidget(
                      state: leagueTermState,
                      functionSuccess: () {
                        ref
                            .read(scheduleGroupStageMatchesRRProvider(
                                    (widget.leagueId, false))
                                .notifier)
                            .run();
                        ref
                            .read(roundsWithGroupsProvider(
                                    Tuple2(widget.leagueId, 'unscheduled'))
                                .notifier)
                            .run();
                        Navigator.pop(context);
                      },
                      messageSuccess:
                          'تم تهيئة الأشواط الخاصة بالدوري بنجاح',
                      bottonWidget: DefaultButtonWidget(
                        text: 'تم',
                        onPressed: () async {
                          await ref
                              .read(leagueTermProvider(widget.leagueId).notifier)
                              .initTermsUiLogic(
                                termsState.data,
                                selectedTermsCount,
                                includeExtraAndPenalties,
                                matchDuration,
                              );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
