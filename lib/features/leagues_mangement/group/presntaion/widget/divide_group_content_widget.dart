import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/leagues_mangement/group/presntaion/widget/qualified_selector_section_widget.dart';
import '../page/divide_group_page.dart';
import '../state_managment/riverpod.dart';
import 'draft_button_section_widget.dart';
import 'group_count_suggestion.dart';
import 'group_selector_section_widget.dart';

class DivideGroupContentWidget extends ConsumerWidget {
  const DivideGroupContentWidget({super.key,
    required this.leagueId,
    required this.groups,
  });

  final int leagueId;
  final List<GroupCountSuggestion> groups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGroupIndex = ref.watch(selectedGroupIndexProvider(leagueId));
    final selectedQualifiedIndex =
    ref.watch(selectedQualifiedIndexProvider(leagueId));

    final hasGroupSelection = selectedGroupIndex != null;

    final selectedGroups = hasGroupSelection
        ? groups[selectedGroupIndex].groups
        : null;

    final draftState = ref.watch(
      groupsDraftProvider(
        (
        leagueId,
        selectedGroups ?? groups[0].groups,
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GroupSelectorSectionWidget(
            leagueId: leagueId,
            groups: groups,
            selectedGroupIndex: selectedGroupIndex,
          ),
          12.h.verticalSpace,
          if (hasGroupSelection)
            QualifiedSelectorSectionWidget(
              leagueId: leagueId,
              selectedQualifiedIndex: selectedQualifiedIndex,
              selectedGroups: selectedGroups!,
            ),
          20.h.verticalSpace,
          DraftButtonSectionWidget(
            leagueId: leagueId,
            draftState: draftState,
            hasGroupSelection: hasGroupSelection,
            selectedQualifiedIndex: selectedQualifiedIndex,
            selectedGroups: selectedGroups,
          ),
        ],
      ),
    );
  }
}
