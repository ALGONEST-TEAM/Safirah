import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../state_mangment/riverpod.dart';

class PlayersSelectionTeamWidget extends ConsumerWidget {
  const PlayersSelectionTeamWidget({
    super.key,
    required this.title,
    required this.pickedIds,
    required this.onToggle,
    required this.searchController,
    required this.leagueId,
    this.searchLabel = 'البحث عن لاعب',
    this.searchHint = 'اسم اللاعب',
    this.listTitle = 'اللاعبون',
  });

  final String title;
  final Set<int> pickedIds;
  final void Function(int id) onToggle;
  final TextEditingController searchController;
  final String searchLabel;
  final String searchHint;
  final String listTitle;
  final int leagueId;
  @override
  Widget build(BuildContext context,ref) {
    final playerWithOutTeamState= ref.watch(leaguePlayersWithoutTeamProvider(leagueId));
    return Column(
      children: [
        // قائمة اللاعبين
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(text: listTitle),
                8.h.verticalSpace,
                Expanded(
                  child: CheckStateInGetApiDataWidget(
                    state:playerWithOutTeamState ,
                    widgetOfData: ListView.separated(
                      itemCount: playerWithOutTeamState.data.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) {
                        final p = playerWithOutTeamState.data[i];
                        final selected = pickedIds.contains(p.id!);
                        return InkWell(
                          onTap: () => onToggle(p.id!),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color(0xFFEFF3FF)
                                    : AppColors.scaffoldColor,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Player #${p.id}',
                                            style: const TextStyle(fontWeight: FontWeight.w600)),
                                        const Text('@username',
                                            style: TextStyle(color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    selected ? Icons.check_circle : Icons.circle_outlined,
                                    color: selected ? Theme.of(context).colorScheme.primary : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
