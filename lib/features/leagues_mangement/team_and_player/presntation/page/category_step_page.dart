import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../../../team_and_player/data/model/team_model.dart';
import '../../../team_and_player/presntation/state_mangment/riverpod.dart';
import '../widget/category_drop_down_filed_widget.dart';
import '../widget/player_selection_cat_widget.dart';
import 'category_tab_page.dart';

class CategoryStepPage extends ConsumerStatefulWidget {
  final int leagueId;
  final int maxTeam;
  final List<LeaguePlayerModel> players;

  const CategoryStepPage(
      {super.key,
      required this.leagueId,
      required this.players,
      required this.maxTeam});

  @override
  ConsumerState<CategoryStepPage> createState() => _CategoryStepPageState();
}

class _CategoryStepPageState extends ConsumerState<CategoryStepPage> {
  TeamPlayerCategoryModel? _selectedCategory;
  final _searchCtrl = TextEditingController();
  final _pickedIds = <int>{};

  @override
  Widget build(BuildContext context) {
    final currentCount = (_selectedCategory == null)
        ? 0
        : ref.watch(playersCountByCategoryProvider((
            widget.leagueId,
            _selectedCategory!.id!,
          )));
    final remaining = (widget.maxTeam - currentCount).clamp(0, widget.maxTeam);
    final canCommit = _selectedCategory != null &&
        _pickedIds.isNotEmpty &&
        _pickedIds.length <= remaining;

    final state = ref.watch(setPlayerCategoryProvider);
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 12.h),
            CategoryDropdownFieldWidget(
              leagueId: widget.leagueId, // يجلب الفئات داخليًا
              value: _selectedCategory,
              onChanged: (cat) {
                setState(() {
                  _selectedCategory = cat;
                  _pickedIds.clear();
                });
              },
              validator: (cat) => cat == null ? 'الرجاء اختيار فئة' : null,
            ),
            SizedBox(height: 8.h),
            const AutoSizeTextWidget(text: "البحث عن لاعب"),
            SizedBox(height: 8.h),
            TextFormFieldWidget(
              controller: _searchCtrl,
              hintFontSize: 12,
              fillColor: Colors.white,
              hintText: "اسم اللعب",
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: PlayersSelectionCatWidget(
                title: 'تحديد اللاعبين',
                pickedIds: _pickedIds,
                leagueId: widget.leagueId,
                searchController: _searchCtrl,
                searchLabel: 'البحث عن لاعب',
                searchHint: 'رقم المستخدم',
                listTitle: 'اللاعبون',
                onToggle: (id) {
                  setState(() {
                    _pickedIds.contains(id)
                        ? _pickedIds.remove(id)
                        : _pickedIds.add(id);
                  });
                },
              ),
            ),
            SafeArea(
              child: Container(
                height: 50.h,
                color: AppColors.scaffoldColor,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(children: [
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DefaultButtonWidget(
                              onPressed: () {
                                navigateTo(
                                    context,
                                    CategoryTabsPage(
                                      numOfLeaguePlayerWithOutCate: 0,
                                      // numOfLeaguePlayerWithOutCate:_visiblePlayers.length ,
                                      leagueId: widget.leagueId,
                                      leagueName: 'دوري الاشول',
                                    ));
                              },
                              background: AppColors.primaryColor,
                              text: 'متابعة',
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckStateInPostApiDataWidget(
                            state: state,
                            functionSuccess: () {
                              ref
                                  .read(leaguePlayersWithoutCategoryProvider(
                                          widget.leagueId)
                                      .notifier)
                                  .load();
                            },
                            bottonWidget: DefaultButtonWidget(
                              onPressed: canCommit
                                  ? () async {
                                      for (final id in _pickedIds) {
                                        await ref
                                            .read(setPlayerCategoryProvider
                                                .notifier)
                                            .setCategory(
                                              leaguePlayerId: id,
                                              categoryId:
                                                  _selectedCategory!.id!,
                                            );
                                      }
                                      ref
                                          .read(playersByCategoryProvider((
                                            widget.leagueId,
                                            _selectedCategory!.id!
                                          )).notifier)
                                          .load();
                                      setState(_pickedIds.clear);
                                    }
                                  : () {
                                      showFlashBarError(
                                          context: context,
                                          title:
                                              "عدد اللعبين المختارين غير مناسب للفئة",
                                          text:
                                              'قم بالتاكد من عدد اللعبين الخاصة بالفئة المختارة');
                                    },
                              text: 'اضافة للفئة',
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
