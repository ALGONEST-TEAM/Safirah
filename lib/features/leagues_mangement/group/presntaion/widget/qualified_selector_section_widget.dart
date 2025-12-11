import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../widget/chip_selector_widget.dart';
import '../page/divide_group_page.dart';
import '../state_managment/riverpod.dart';
import 'group_count_suggestion.dart';

class QualifiedSelectorSectionWidget extends ConsumerWidget {
  const QualifiedSelectorSectionWidget({
    super.key,
    required this.leagueId,
    required this.selectedQualifiedIndex,
    required this.selectedGroups,
  });

  final int leagueId;
  final int? selectedQualifiedIndex;
  final int selectedGroups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qualifiedAsync = ref.watch(
      qualifiedSuggestionsProvider((leagueId: leagueId, groups: selectedGroups)),
    );

    return qualifiedAsync.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, _) => Center(child: Text('خطأ في تحميل المتأهلين: $e')),
      data: (qualifiedList) {
        if (qualifiedList.isEmpty) {
          return const Center(
            child: Text('لا يوجد اقتراح متاح للمتأهلين'),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AutoSizeTextWidget(
              text: "اختر عدد المتأهلين من كل مجموعة",
            ),
            4.h.verticalSpace,
            ChipSelectorWidget(
              items: qualifiedList.map((e) => e.labelArabic()).toList(),
              selectedIndex: selectedQualifiedIndex,
              onSelected: (i) {
                ref
                    .read(selectedQualifiedIndexProvider(leagueId).notifier)
                    .state = i;
              },
            ),
          ],
        );
      },
    );
  }
}

