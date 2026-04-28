import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/widgets/buttons/default_button.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../leagues/persntaion/riverpod/riverpod.dart';
import '../../../match/presntaion/state_managment/riverpod.dart';
import '../state_mangement/riverpod.dart';
import '../widget/knockout_rule_selector_widget.dart';
import '../widget/match_duration_selector_widget.dart';
import '../widget/term_count_selector_widget.dart';

class LeagueTermSetupPage extends ConsumerStatefulWidget {
  const LeagueTermSetupPage({super.key, required this.leagueSyncId});

  final String leagueSyncId;

  @override
  ConsumerState<LeagueTermSetupPage> createState() =>
      _LeagueTermSetupPageState();
}

class _LeagueTermSetupPageState extends ConsumerState<LeagueTermSetupPage> {
  int? selectedTermsCount = 2; // شوطين إلزامي
  bool includeExtraAndPenalties = false;
  int matchDuration = 60; // الوقت الافتراضي بالدقائق

  @override
  Widget build(BuildContext context) {
    final termsState = ref.watch(termsProvider);
    final leagueTermState = ref.watch(leagueTermProvider(widget.leagueSyncId));

    return Scaffold(
      appBar: const SecondaryAppBarWidget(
        title: 'تهيئة الاشواط',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: termsState.stateData == States.loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TermCountSelectorWidget(
                      selectedTermsCount: selectedTermsCount,
                      onChanged: (_) {},
                      enabled: false,
                    ),
                    8.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: 'عدد الأشواط ثابت على شوطين ولا يمكن تعديله',
                      fontSize: 10.sp,
                      colorText: AppColors.fontColor2,
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
                                    (widget.leagueSyncId, false))
                                .notifier)
                            .run();
                        ref
                            .read(
                          leagueStatusUpdateProvider.notifier,
                        )
                            .update(
                          leagueSyncId: widget.leagueSyncId,
                          hasMatches: true,
                        );
                        //  ref.read(leagueStatusStreamProvider(widget.leagueSyncId));
                        // ref
                        //     .read(leagueStatusProvider(widget.leagueSyncId)
                        //     .notifier)
                        //     .refresh();
                        // ref
                        //     .read(roundsRefreshProvider(
                        //             Tuple3(widget.leagueSyncId, 'unscheduled','organizer'))
                        //         .notifier)
                        //     .refresh();
                        Navigator.pop(context);
                      },
                      messageSuccess:
                          'تم تهيئة الأشواط الخاصة بالدوري بنجاح',
                      bottonWidget: DefaultButtonWidget(
                        text: 'تم',
                        isLoading: leagueTermState.stateData == States.loading,
                        onPressed: () async {
                          await ref
                              .read(leagueTermProvider(widget.leagueSyncId).notifier)
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
