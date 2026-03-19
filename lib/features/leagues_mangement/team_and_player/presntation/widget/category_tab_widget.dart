import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/presntation/widget/tab_category_header_widget.dart';
import '../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../leagues/persntaion/page/details_league_widget.dart';
import '../../../leagues/persntaion/riverpod/riverpod.dart';
import '../../data/model/team_model.dart';
import '../state_mangment/riverpod.dart';
import 'tab_category_body_widget.dart';
import 'package:safirah/core/widgets/bottomNavbar/bottom_navigation_bar_of_mange_league_widget.dart';

class CategoryTabWidget extends ConsumerStatefulWidget {
  const CategoryTabWidget(
      {super.key,
      required this.leagueSyncId,
      required this.categories,
      required this.numOfLeaguePlayerWithOutCate});

  final int numOfLeaguePlayerWithOutCate;
  final String leagueSyncId;
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
    final draftState = ref.watch(runDraftProvider(widget.leagueSyncId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabsCategoryHeaderWidget(
          controller: _controller,
          leagueSyncId: widget.leagueSyncId,
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
            leagueSyncId: widget.leagueSyncId,
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
                    leagueSyncId: widget.leagueSyncId,
                    hasPlayersAssigned: true);

                // ✅ حل نهائي:
                // 1) أعد المستخدم لجذر التطبيق (BottomNavigation) بدل أن تكون Details هي آخر route.
                // 2) اضبط تبويب الدوريات (index=2).
                // 3) افتح تفاصيل الدوري فوق الجذر.
                // عند الضغط على رجوع من DetailsLeagueWidget سيعود لتبويب الدوريات (LeaguesListWidget)
                // بدل الخروج من التطبيق.

                // اضبط التبويب قبل الانتقال
                ref.read(activeIndexProvider.notifier).state = 2;

                // اذهب للجذر (BottomNavigation) وامسح مسار القرعة
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const BottomNavigationBarOfMangeLeagueWidget(),
                  ),
                  (route) => false,
                );

                // افتح التفاصيل فوق الجذر
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailsLeagueWidget(
                      leagueSyncId: widget.leagueSyncId,
                    ),
                  ),
                );
              },
              bottonWidget: DefaultButtonWidget(
                text: 'القرعة',
                isLoading: draftState.stateData == States.loading,
                onPressed: widget.numOfLeaguePlayerWithOutCate != 0
                    ? () {
                  print(widget.leagueSyncId);
                        showFlashBarError(
                            context: context,
                            title: "عذرا لاتستطيع عمل القرعة الان",
                            text:
                                'قم باستكمال تقسيم اللعبين للفئات الخاصة بهم');
                      }
                    : () {
                        ref
                            .read(runDraftProvider(widget.leagueSyncId).notifier)
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
