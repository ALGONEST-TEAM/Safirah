import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/state/state.dart';
import 'package:safirah/core/theme/app_colors.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../data/model/team_model.dart';
import '../state_mangment/riverpod.dart';

class CardInvitationsPlayerWidget extends StatelessWidget {
  const CardInvitationsPlayerWidget(
      {super.key,
      required this.leagueSyncId,
      required this.playerName,
      required this.idInvitation});

  final String leagueSyncId;

  final String playerName;

  final int idInvitation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 6.w),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage:
                          AssetImage('assets/images/player_avatar.png'),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeTextWidget(
                          text: playerName,
                        ),
                      ],
                    ),
                  ],
                ),
                5.h.verticalSpace,
                Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(addPlayerLeagueProvider);
                    return Row(children: [
                      Expanded(
                        child: CheckStateInPostApiDataWidget(
                          state: state,
                          messageSuccess: 'تم قبول انضمام اللاعب للدوري بنجاح',
                          functionSuccess: () {
                            ref.invalidate(invitationsPlayersProvider);
                            ref.invalidate(leaguePlayerStreamProvider);
                          },
                          bottonWidget: DefaultButtonWidget(
                            isLoading: state.stateData == States.loading,
                            textSize: 11.sp,
                            height: 35.h,
                            onPressed: () {
                              print(idInvitation);
                              final player = InvitationsPlayersModel(
                                id: idInvitation,
                                action: 'accepted',
                                userName: playerName,
                                leagueSyncId: leagueSyncId,
                              );
                              ref
                                  .read(addPlayerLeagueProvider.notifier)
                                  .add(player);
                            },
                            text: 'قبول',
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: DefaultButtonWidget(
                          height: 35.h,
                          textSize: 11.sp,
                          background: AppColors.scaffoldColor,
                          textColor: Colors.black,
                          onPressed: () {},
                          text: 'رفض',
                        ),
                      ),
                    ]);
                  },
                ),
                5.h.verticalSpace,
              ],
            ),
          )),
    );
  }
}
