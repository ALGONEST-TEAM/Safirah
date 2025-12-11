import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../state_mangment/riverpod.dart';
import '../widget/category_tab_widget.dart';

class CategoryTabsPage extends ConsumerWidget {
  const CategoryTabsPage(
      {super.key,
        required this.leagueId,
        required this.leagueName,
        required this.numOfLeaguePlayerWithOutCate});

  final int numOfLeaguePlayerWithOutCate;
  final int leagueId;
  final String leagueName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catsState = ref.watch(categoriesProvider(leagueId));
    final  countPlayerWithOutCategory = ref.watch(leaguePlayersWithoutCategoryCountProvider(leagueId));
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const AutoSizeTextWidget(
          text: 'تحديد اللعبين',
          colorText: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: catsState.stateData == States.loading
          ? const Center(child: CircularProgressIndicator())
          : !(catsState.data.isNotEmpty )
          ? const Center(child: Text('لا توجد فئات بعد'))
          : CategoryTabWidget(
        leagueId: leagueId,
        categories: catsState.data,
        numOfLeaguePlayerWithOutCate: countPlayerWithOutCategory,
      ),
    );
  }
}
