import 'package:flutter/material.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/presntation/widget/players_of_category_widget.dart';

import '../../data/model/team_model.dart';

class TabsCategoryBodyWidget extends StatelessWidget {
  const TabsCategoryBodyWidget(
      {super.key, required this.leagueId,
        required this.categories,
        required this.controller});

  final TabController controller;
  final int leagueId;
  final List<TeamPlayerCategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: [
        for (final cat in categories)
          PlayersOfCategoryWidget(
            leagueId: leagueId,
            category: cat,
          ),
      ],
    );
  }
}
