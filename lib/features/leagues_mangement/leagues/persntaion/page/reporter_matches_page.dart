import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safirah/core/widgets/secondary_app_bar_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../match/presntaion/widget/matches_schedule_widget.dart';

class ReporterMatchesPage extends ConsumerWidget {
  const ReporterMatchesPage(
      {super.key, required this.leagueSyncId, required this.role});

  final String leagueSyncId;
  final String role;

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: 'ادارة التقارير',),

      body: SafeArea(
        child: MatchesScheduleWidget(
          role: role,
          leagueSyncId: leagueSyncId,
          matchFilter: 'scheduled,live,finished',
        ),
      ),
    );
  }
}
