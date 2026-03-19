import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/state.dart';
  import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../state_mangment/riverpod.dart';
import '../widget/category_tab_widget.dart';

class CategoryTabsPage extends ConsumerWidget {
  const CategoryTabsPage(
      {super.key,
        required this.leagueSyncId,
        required this.leagueName,
        required this.numOfLeaguePlayerWithOutCate});

  final int numOfLeaguePlayerWithOutCate;
  final String leagueSyncId;
  final String leagueName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catsState = ref.watch(categoriesProvider(leagueSyncId));
    final  countPlayerWithOutCategory = ref.watch(leaguePlayersWithoutCategoryCountProvider(leagueSyncId));
    return Scaffold(
      appBar:const SecondaryAppBarWidget(title: 'تقسيم الفئات',),

      body: catsState.stateData == States.loading
          ? const Center(child: CircularProgressIndicator())
          : !(catsState.data.isNotEmpty )
          ? const Center(child: Text('لا توجد فئات بعد'))
          : CategoryTabWidget(
        leagueSyncId: leagueSyncId,
        categories: catsState.data,
        numOfLeaguePlayerWithOutCate: countPlayerWithOutCategory,
      ),
    );
  }
}
