import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/presntation/page/teams_with_players_widget.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../../data/model/team_model.dart';
import '../state_mangment/riverpod.dart';
import '../widget/player_selection_team_widget.dart';
import '../widget/team_drop_down_filed_widget.dart';

class TeamStepPage extends ConsumerStatefulWidget {
  final int leagueId;
  final List<LeaguePlayerModel> players;
  final int maxPlayersTeam;

  const TeamStepPage(
      {super.key,
      required this.leagueId,
      required this.players,
      required this.maxPlayersTeam});

  @override
  ConsumerState<TeamStepPage> createState() => _TeamStepPageState();
}

class _TeamStepPageState extends ConsumerState<TeamStepPage> {
  TeamModel? _selectedTeam;
  final _searchCtrl = TextEditingController();
  final _pickedIds = <int>{};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final currentCount = (_selectedTeam?.id == null)
        ? 0
        : ref.watch(playersCountOfTeamProvider((_selectedTeam!.id!)));
    final remaining =
        (widget.maxPlayersTeam - currentCount).clamp(0, widget.maxPlayersTeam);
    final canCommit = _selectedTeam?.id != null &&
        _pickedIds.isNotEmpty &&
        _pickedIds.length <= remaining;
    final state = ref.watch(assignToTeamProvider(_selectedTeam?.id ?? 1));
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const AutoSizeTextWidget(
            text: 'تحديد اللاعبين', colorText: Colors.white),
        centerTitle: true,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.h.verticalSpace,
            TeamDropdownFieldWidget(
              leagueId: widget.leagueId,
              value: _selectedTeam,
              onChanged: (team) {
                setState(() {
                  _selectedTeam = team;
                  _pickedIds.clear();
                });
              },
              validator: (team) => team == null ? 'الرجاء اختيار فريق' : null,
              hintText: 'اسم الفريق',
            ),
            8.h.verticalSpace,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AutoSizeTextWidget(text: "البحث عن لاعب"),
                  8.h.verticalSpace,
                  TextFormFieldWidget(
                    controller: _searchCtrl,
                    hintFontSize: 12,
                    fillColor: AppColors.scaffoldColor,
                    hintText: "رقم المستخدم",
                    onChanged: (_) => setState(() {}),
                  ),
                ],
              ),
            ),
            8.h.verticalSpace,
            Expanded(
              child: PlayersSelectionTeamWidget(
                title: 'تحديد اللاعبين',
                pickedIds: _pickedIds,
                leagueId: widget.leagueId,
                searchController: _searchCtrl,
                searchLabel: 'البحث عن لاعب',
                searchHint: 'اسم اللاعب',
                listTitle: 'اللاعبون بدون فريق',
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
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DefaultButtonWidget(
                                onPressed: () {
                                  navigateTo(
                                      context,
                                      TeamsWithPlayersPage(
                                          leagueId: widget.leagueId));
                                },
                                background: AppColors.primaryColor,
                                text: 'متابعة',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckStateInPostApiDataWidget(
                          state: state,
                          messageSuccess: 'تمت اضافة اللعبين لفرقة بنجاح',
                          functionSuccess: () {
                            ref
                                .read(leaguePlayersWithoutTeamProvider(
                                        widget.leagueId)
                                    .notifier)
                                .load();
                          },
                          bottonWidget: DefaultButtonWidget(
                              onPressed: canCommit
                                  ? (_selectedTeam != null &&
                                          _pickedIds.isNotEmpty)
                                      ? () {
                                          ref
                                              .read(assignToTeamProvider(
                                                      _selectedTeam!.id!)
                                                  .notifier)
                                              .assign(_pickedIds.toList());
                                        }
                                      : null
                                  : () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'عدد لاعبين الفريق اكتمل')),
                                      );
                                    },
                              text: 'اضافة للفريق'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
