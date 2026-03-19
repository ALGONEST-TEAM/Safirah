import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../authorization/persntaion/widgets/authorization_gate_hide_if_denied.dart';
import '../riverpod/riverpod.dart';
import '../widget/add_another_rule_for_league_widget.dart';

class ShowRuleLeaguePage extends ConsumerStatefulWidget {
  const ShowRuleLeaguePage({super.key, required this.leagueSyncId});
  final String leagueSyncId;

  @override
  ConsumerState<ShowRuleLeaguePage> createState() => _ShowRuleLeaguePageState();
}

class _ShowRuleLeaguePageState extends ConsumerState<ShowRuleLeaguePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(leagueRulesRefreshProvider(widget.leagueSyncId).notifier)
          .refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final rulesAsync = ref.watch(leagueRulesStreamProvider(widget.leagueSyncId));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: const SecondaryAppBarWidget(title: 'قواعد الدوري'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CheckStateInStreamWidget(
            async: rulesAsync,
            onRefresh: () async {
              await ref
                  .read(leagueRulesRefreshProvider(widget.leagueSyncId).notifier)
                  .refresh();
            },
            isEmpty: (rules) => rules.isEmpty,
            emptyBuilder: () => const _EmptyRulesState(),
            dataBuilder: (leagueRules) {

              final anyMandatory = leagueRules.any((e) => e.isMandatory);

              final defaultRulesText = RulesNotifier.defaultRulesText;

              final defaultRules = anyMandatory
                  ? leagueRules.where((e) => e.isMandatory).toList()
                  : leagueRules
                      .where((e) => defaultRulesText.contains(e.description))
                      .toList();

              final customRules = anyMandatory
                  ? leagueRules.where((e) => !e.isMandatory).toList()
                  : leagueRules
                      .where((e) => !defaultRulesText.contains(e.description))
                      .toList();

              return ListView(
                padding: EdgeInsets.only(bottom: 16.h),
                children: [
                  if (defaultRules.isNotEmpty) ...[
                    _RulesSectionCard(
                      title: 'القواعد الأساسية',
                      badgeText: 'أساسي',
                      badgeColor: AppColors.primaryColor,
                      icon: Icons.verified_outlined,
                      rules: defaultRules.map((e) => e.description).toList(),
                    ),
                    SizedBox(height: 12.h),
                  ],
                  _RulesSectionCard(
                    title: 'قواعد مخصصة',
                    badgeText: 'مخصص',
                    badgeColor: AppColors.secondaryColor,
                    icon: Icons.edit_note_outlined,
                    rules: customRules.map((e) => e.description).toList(),
                    trailingAction: AuthorizationGateHideIfDenied(
                      leagueSyncId: widget.leagueSyncId,
                      permissionKey: 'league.edit',
                      child: GestureDetector(
                        onTap: () => navigateTo(
                          context,
                          AddAnotherRuleForLeagueWidget(
                            leagueSyncId: widget.leagueSyncId,
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                          child: AutoSizeTextWidget(
                            text: 'اضافة',
                            fontSize: 10.5.sp,
                            colorText: Colors.white,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),

    );
  }
}

class _RulesSectionCard extends StatelessWidget {
  const _RulesSectionCard({
    required this.title,
    required this.badgeText,
    required this.badgeColor,
    required this.icon,
    required this.rules,
    this.trailingAction,
  });

  final String title;
  final String badgeText;
  final Color badgeColor;
  final IconData icon;
  final List<String> rules;
  final Widget? trailingAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.black12.withValues(alpha: .06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title: title,
            badgeText: badgeText,
            badgeColor: badgeColor,
            trailingAction: trailingAction,
          ),
          SizedBox(height: 12.h),
          if (rules.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: AutoSizeTextWidget(
                text: 'لا توجد قواعد مخصصة بعد.',
                fontSize: 11.5.sp,
                colorText: Colors.black54,
              ),
            )
          else
            ...rules.map(
              (text) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _RuleRow(
                  text: text,
                  icon: icon,
                  accentColor: badgeColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({
    required this.text,
    required this.icon,
    required this.accentColor,
  });

  final String text;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.black12.withValues(alpha: .05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30.r,
            width: 30.r,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 18.sp, color: accentColor),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: AutoSizeTextWidget(
              text: text,
              fontSize: 12.sp,
              colorText: AppColors.secondaryColor,
              maxLines: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String badgeText;
  final Color badgeColor;
  final Widget? trailingAction;

  const _SectionTitle({
    required this.title,
    required this.badgeText,
    required this.badgeColor,
    this.trailingAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AutoSizeTextWidget(
                      text: title,
                      fontSize: 12.5.sp,
                      colorText: AppColors.secondaryColor,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: AutoSizeTextWidget(
                      text: badgeText,
                      fontSize: 10.5.sp,
                      colorText: Colors.white,
                      maxLines: 1,
                    ),
                  ),
                  if (trailingAction != null) ...[
                    SizedBox(width: 6.w),
                    trailingAction!,
                  ],
                ],
              ),

            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyRulesState extends StatelessWidget {
  const _EmptyRulesState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 88.r,
              width: 88.r,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(
                Icons.inbox_outlined,
                size: 36.sp,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 12.h),
            AutoSizeTextWidget(
              text: 'لا توجد قواعد لعرضها',
              fontSize: 13.sp,
              colorText: AppColors.secondaryColor,
            ),
            SizedBox(height: 6.h),
            AutoSizeTextWidget(
              text: 'قم باختيار قواعد للدوري أو إضافة قواعد مخصصة أولاً.',
              fontSize: 11.5.sp,
              colorText: Colors.black54,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
