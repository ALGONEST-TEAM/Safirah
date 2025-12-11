import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/state/state.dart';
import 'package:safirah/core/theme/app_colors.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import 'package:safirah/core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/bottomNavbar/bottom_navigation_bar_of_mange_league_widget.dart';
import '../../data/model/league_model.dart';
import '../../data/model/rule_league_model.dart';
import '../riverpod/riverpod.dart';
import '../widget/add_more_role_widget.dart';
import '../widget/rules_list_widget.dart';

class LeagueRulesPage extends ConsumerStatefulWidget {
  const LeagueRulesPage(
      {super.key,
      this.name,
      this.type,
      this.scope,
      this.maxTeams,
      this.maxMainPlayers,
      this.maxSubPlayers,
      this.isPrivate = false,
      this.status = 'active',
        this.logoPath,
      this.subscriptionPrice});

  final String? name;
  final String? subscriptionPrice;
  final String? logoPath;

  final String? type;
  final String? scope;
  final int? maxTeams;
  final int? maxMainPlayers;
  final int? maxSubPlayers;
  final bool isPrivate;
  final String status;

  @override
  ConsumerState<LeagueRulesPage> createState() => _LeagueRulesPageState();
}

class _LeagueRulesPageState extends ConsumerState<LeagueRulesPage> {
  TextEditingController rule = TextEditingController();
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final rules = ref.watch(rulesProvider);
    final notifier = ref.read(rulesProvider.notifier);
    final addLeague = ref.watch(addLeagueProvider);
    final addRuleLeague = ref.watch(addRuleProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const AutoSizeTextWidget(
          text: "إنشاء الدوري",
          colorText: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AutoSizeTextWidget(text: "القواعد الخاصة بالدوري"),
                SizedBox(height: 8.h),
                RulesListSectionWidget(
                  rules: rules,
                  onToggle: notifier.toggleSelection,
                ),
                SizedBox(height: 8.h),
                AddMoreRuleWidget(
                  controller: rule,
                  isLoading: addRuleLeague.stateData == States.loading,
                  onAdd: () {
                    if (rule.text.isNotEmpty) {
                      notifier.addCustomRule(rule.text);
                      rule.clear();
                    }
                  },
                ),
                SizedBox(height: 12.h),
                // LeagueDatesWidget(
                //   dateStartCtrl: dateStart,
                //   dateEndCtrl: dateEnd,
                // ),
                SizedBox(height: 12.h),
                CheckStateInPostApiDataWidget(
                  state: addLeague,
                  hasMessageSuccess: false,
                  functionSuccess: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      final selectedRules = rules
                          .where((rule) => rule.selected)
                          .map((r) => LeagueRuleModel(
                                description: r.rule,
                                leagueId: addLeague.data,
                              ))
                          .toList();
                      ref
                          .read(addRuleProvider.notifier)
                          .addRuleList(addLeague.data, selectedRules);
                      ref
                          .read(leaguesByPrivacyProvider(widget.isPrivate)
                              .notifier)
                          .load();
                      navigateAndFinish(context,
                          const BottomNavigationBarOfMangeLeagueWidget());
                    });
                  },
                  bottonWidget: DefaultButtonWidget(
                    text: 'انشاء الدوري',
                    textColor: Colors.white,
                    background: AppColors.primaryColor,
                    onPressed: () {
                      LeagueModel league = LeagueModel(
                        name: widget.name,
                        maxTeams: widget.maxTeams,
                        maxSubPlayers: widget.maxSubPlayers,
                        maxMainPlayers: widget.maxMainPlayers,
                        isPrivate: widget.isPrivate,
                        type: widget.type,
                        scope: widget.scope,
                        subscriptionPrice: widget.subscriptionPrice,
                        logoPath: widget.logoPath,
                        startDate: DateTime.tryParse(dateStart.text),
                        endDate: DateTime.tryParse(dateEnd.text),
                      );
                      ref.read(addLeagueProvider.notifier).addLeague(league);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
