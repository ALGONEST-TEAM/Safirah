import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/presntation/widget/player_tiles_widget.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../data/model/team_model.dart';
import '../state_mangment/riverpod.dart';
import 'empty_card_player_widget.dart';

class PlayersOfCategoryWidget extends ConsumerWidget {
  const PlayersOfCategoryWidget({
    super.key,
    required this.leagueId,
    required this.category,
  });

  final int leagueId;
  final TeamPlayerCategoryModel category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersState =
        ref.watch(playersByCategoryProvider((leagueId, category.id!)));

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 10.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckStateInGetApiDataWidget(
              state: playersState,
              widgetOfData: playersState.data.isEmpty
                  ? const EmptyCardPlayerWidget(
                      title: 'لا يوجد لاعبون في هذه الفئة')
                  : Expanded(
                      child: ListView.builder(
                        itemCount: playersState.data.length,
                        itemBuilder: (context, index) => PlayerTilesWidget(
                          playersState.data[index],
                          categoryId: category.id!,
                          leagueId: leagueId,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
