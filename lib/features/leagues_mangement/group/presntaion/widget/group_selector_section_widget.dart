import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../widget/chip_selector_widget.dart';
import '../widget/group_count_suggestion.dart';
import '../page/divide_group_page.dart';

class GroupSelectorSectionWidget extends ConsumerWidget {
  const GroupSelectorSectionWidget({
    super.key,
    required this.leagueId,
    required this.groups,
    required this.selectedGroupIndex,
  });

  final int leagueId;
  final List<GroupCountSuggestion> groups;
  final int? selectedGroupIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AutoSizeTextWidget(text: "اختر عدد المجموعات"),
        4.h.verticalSpace,
        ChipSelectorWidget(
          items: groups.map((e) => e.labelArabic()).toList(),
          selectedIndex: selectedGroupIndex,
          onSelected: (i) {
            ref.read(selectedGroupIndexProvider(leagueId).notifier).state = i;
            ref
                .read(selectedQualifiedIndexProvider(leagueId).notifier)
                .state = null;
          },
        ),
      ],
    );
  }
}

