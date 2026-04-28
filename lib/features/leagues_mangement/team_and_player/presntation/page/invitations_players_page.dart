import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safirah/core/state/check_state_in_get_api_data_widget.dart';
import 'package:safirah/core/widgets/secondary_app_bar_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../state_mangment/riverpod.dart';
import '../widget/card_invitations_player_widget.dart';

class InvitationsPlayersPage extends ConsumerWidget {
  const InvitationsPlayersPage({super.key, required this.leagueSyncId,});

  final String leagueSyncId;

  @override
  Widget build(BuildContext context, ref) {
    final invitationsPlayersState =
    ref.watch(invitationsPlayersProvider(leagueSyncId));
    return Scaffold(
      appBar: SecondaryAppBarWidget( title: 'طلبات الانضمام',),
      body: CheckStateInGetApiDataWidget(
        state: invitationsPlayersState,

        widgetOfData: ListView.builder(
          itemCount: invitationsPlayersState.data.length,
          itemBuilder: (context, index) {
            return CardInvitationsPlayerWidget(
              leagueSyncId: leagueSyncId,
              playerName: invitationsPlayersState.data[index].userName!,
              idInvitation: invitationsPlayersState.data[index].id!,
            );
          },
        ),
      ),
    );
  }
}
