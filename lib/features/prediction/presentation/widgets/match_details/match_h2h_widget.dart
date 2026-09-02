import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../provider/match_details_providers.dart';
import '../../riverpod/match_details_riverpod.dart';
import 'match_h2h_content_widget.dart';

class MatchH2hWidget extends ConsumerWidget {
  final int matchId;

  const MatchH2hWidget({
    super.key,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchH2HProvider(matchId));
    final h2hUI = ref.watch(matchH2hUIProvider(matchId));
    final teamColors = ref.watch(matchTeamColorsProvider(matchId));

    return CheckStateInGetApiDataWidget(
      state: state,
      refresh: () =>
          ref.read(matchH2HProvider(matchId).notifier).getMatchH2H(),
      widgetOfData: state.data != null
          ? MatchH2hContentWidget(
              matchId: matchId,
              h2hData: state.data!,
              h2hUI: h2hUI,
              homeColor: teamColors.homeColor,
              awayColor: teamColors.awayColor,
            )
          : const SizedBox(),
    );
  }
}
