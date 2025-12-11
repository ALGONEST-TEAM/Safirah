import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/presntation/widget/tab_category_header_widget.dart';
import '../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../leagues/persntaion/page/details_league_widget.dart';
import '../../../leagues/persntaion/riverpod/riverpod.dart';
import '../../data/model/team_model.dart';
import '../state_mangment/riverpod.dart';
import 'tab_category_body_widget.dart';

class CategoryTabWidget extends ConsumerStatefulWidget {
  const CategoryTabWidget(
      {super.key,
      required this.leagueId,
      required this.categories,
      required this.numOfLeaguePlayerWithOutCate});

  final int numOfLeaguePlayerWithOutCate;
  final int leagueId;
  final List<TeamPlayerCategoryModel> categories;

  @override
  ConsumerState<CategoryTabWidget> createState() => _CategoryTabWidgetState();
}

class _CategoryTabWidgetState extends ConsumerState<CategoryTabWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.categories.length, vsync: this);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draftState = ref.watch(runDraftProvider(widget.leagueId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabsCategoryHeaderWidget(
          controller: _controller,
          leagueId: widget.leagueId,
          categories: widget.categories,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const AutoSizeTextWidget(text: 'لاعبين الفئة'),
        ),
        6.verticalSpace,
        Expanded(
          child: TabsCategoryBodyWidget(
            controller: _controller,
            leagueId: widget.leagueId,
            categories: widget.categories,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: CheckStateInPostApiDataWidget(
              state: draftState,
              functionSuccess: () {
                ref.read(leagueStatusUpdateProvider.notifier).update(
                    leagueId: widget.leagueId, hasPlayersAssigned: true);
                ref.read(leagueStatusProvider(widget.leagueId).notifier).load();
                navigateAndFinish(
                    context,
                    DetailsLeagueWidget(
                      leagueId: widget.leagueId,
                    ));
              },
              bottonWidget: DefaultButtonWidget(
                text: 'القرعة',
                onPressed: widget.numOfLeaguePlayerWithOutCate != 0
                    ? () {
                        showFlashBarError(
                            context: context,
                            title: "عذرا لاتستطيع عمل القرعة الان",
                            text:
                                'قم باستكمال تقسيم اللعبين للفئات الخاصة بهم');
                      }
                    : () {
                        ref
                            .read(runDraftProvider(widget.leagueId).notifier)
                            .run();
                      },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
