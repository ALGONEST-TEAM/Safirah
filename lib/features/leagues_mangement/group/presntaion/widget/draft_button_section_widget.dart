import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/state/state.dart';
import 'package:safirah/core/state/data_state.dart';
import 'package:safirah/core/widgets/buttons/default_button.dart';
import '../../../leagues/persntaion/riverpod/riverpod.dart';
import '../../../match/presntaion/state_managment/riverpod.dart';
import '../state_managment/riverpod.dart';
import 'group_count_suggestion.dart';

class DraftButtonSectionWidget extends ConsumerWidget {
  const DraftButtonSectionWidget({
    super.key,
    required this.leagueSyncId,
    required this.draftState,
    required this.hasGroupSelection,
    required this.selectedQualifiedIndex,
    required this.selectedGroups,
  });

  final String leagueSyncId;
  final DataState draftState;
  final bool hasGroupSelection;
  final int? selectedQualifiedIndex;
  final int? selectedGroups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: CheckStateInPostApiDataWidget(
            state: draftState,
            functionSuccess: () {
              ref.read(ensureGroupRoundsProvider(leagueSyncId).notifier).run();
              ref
                  .read(groupRefreshProvider(leagueSyncId).notifier)
                  .refresh();
                ref.read(leagueStatusUpdateProvider.notifier).update(leagueSyncId: leagueSyncId,hasGroups: true);
              // ref.read(leagueStatusStreamProvider(leagueSyncId));
              // ref.read(leagueStatusProvider(leagueSyncId).notifier).refresh();

              Navigator.pop(context);
            },
            bottonWidget: DefaultButtonWidget(
              isLoading: draftState.stateData == States.loading,
              text: 'قرعة',
              onPressed: hasGroupSelection && selectedQualifiedIndex != null
                  ? () async {
                print(selectedGroups);
                      final qualifiedList = ref
                          .read(
                            qualifiedSuggestionsProvider(
                              (
                              leagueSyncId: leagueSyncId,
                                groups: selectedGroups!,
                              ),
                            ),
                          )
                          .value;

                      final qualifiedPerGroup =
                          qualifiedList![selectedQualifiedIndex!].count;
                      ref
                          .read(groupsDraftProvider(
                                  (leagueSyncId, selectedGroups)).notifier)
                          .run(
                            qualifiedPerGroup: qualifiedPerGroup,
                            seed: DateTime.now().millisecondsSinceEpoch,
                          );
                    }
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
