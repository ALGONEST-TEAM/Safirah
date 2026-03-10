import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/secondary_app_bar_widget.dart';
import 'package:safirah/features/leagues_mangement/leagues/persntaion/widget/rules_list_widget.dart';

import '../../../../../core/state/state.dart';
import '../../data/model/rule_league_model.dart';
import '../riverpod/riverpod.dart';
import 'add_more_role_widget.dart';

class AddAnotherRuleForLeagueWidget extends ConsumerWidget {
  const AddAnotherRuleForLeagueWidget({super.key, required this.leagueSyncId});

  final String leagueSyncId;

  @override
  Widget build(BuildContext context, ref) {
    TextEditingController rule = TextEditingController();
    final addRuleLeague = ref.watch(addRuleProvider);

    return Scaffold(
      appBar: SecondaryAppBarWidget(title: "اضافة قاعدة جديدة"),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            AddMoreRuleWidget(
              controller: rule,
              isLoading: addRuleLeague.stateData == States.loading,
              onAdd: () async {
                await ref
                    .read(addRuleProvider.notifier)
                    .addRuleList(leagueSyncId, [
                  LeagueRuleModel(
                    leagueSyncId: leagueSyncId,
                    description: rule.text,
                  )
                ]);
              },
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
