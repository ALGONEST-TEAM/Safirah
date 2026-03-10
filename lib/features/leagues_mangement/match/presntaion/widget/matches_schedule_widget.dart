import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../match_term_event/presntation/state_mangement/riverpod.dart';
import '../../data/model/round_model.dart';
import '../state_managment/riverpod.dart';
import 'knockout_rounds_list_widget.dart';
import 'rounds_list_widget.dart';
class MatchesScheduleWidget extends ConsumerStatefulWidget {
  final String leagueSyncId;
  final String matchFilter;
  final String role;

  const MatchesScheduleWidget({
    super.key,
    required this.leagueSyncId,
    required this.matchFilter,
    required this.role,
  });

  @override
  ConsumerState<MatchesScheduleWidget> createState() => _MatchesScheduleWidgetState();
}

class _MatchesScheduleWidgetState extends ConsumerState<MatchesScheduleWidget> {
  late final Tuple3<String, String, String> refreshParam;
  late final Tuple2<String, String> streamParam;

  @override
  void initState() {
    super.initState();
    refreshParam = Tuple3(widget.leagueSyncId, widget.matchFilter, widget.role);
    streamParam = Tuple2(widget.leagueSyncId, widget.matchFilter);

  }

  @override
  Widget build(BuildContext context) {
    final checkFinishedAllMatchInGroup =
    ref.watch(checkGroupMatchesFinishedProvider(widget.leagueSyncId));

    if (checkFinishedAllMatchInGroup.data == true) {
      return KnockoutRoundsListWidget(

        leagueSyncId: widget.leagueSyncId,
        matchFilter: widget.matchFilter,
        role: widget.role,
        refreshParam: refreshParam,
        streamParam: streamParam,

      );
    }

    return RoundsListWidget(
      role: widget.role,
      leagueSyncId: widget.leagueSyncId,
      matchFilter: widget.matchFilter,
      refreshParam: refreshParam,
      streamParam: streamParam,
    );
  }
}