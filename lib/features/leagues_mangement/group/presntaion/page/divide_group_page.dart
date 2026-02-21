import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../widget/divide_group_content_widget.dart';
import '../widget/group_count_suggestion.dart';
import '../widget/divide_group_appbar_widget.dart';
final selectedGroupIndexProvider =
    StateProvider.family<int?, String>((ref, leagueSyncId) => null);

final selectedQualifiedIndexProvider =
    StateProvider.family<int?, String>((ref, leagueSyncId) => null);

class DivideGroupPage extends ConsumerWidget {
  const DivideGroupPage({super.key, required this.leagueSyncId});

  final String leagueSyncId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupSuggestions =
        ref.watch(powerOfTwoGroupSuggestionsProvider(leagueSyncId));

    return Scaffold(
      appBar: const DivideGroupAppBarWidget(),
      body: groupSuggestions.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('حدث خطأ: $e')),
        data: (groups) {
          if (groups.isEmpty) {
            return const Center(child: Text('لا اقتراحات متاحة'));
          }

          return DivideGroupContentWidget(
            leagueSyncId: leagueSyncId,
            groups: groups,
          );
        },
      ),
    );
  }
}

