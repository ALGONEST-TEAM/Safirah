import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import '../../../match_term_event/presntation/state_mangement/riverpod.dart';
import '../widget/knockout_rounds_list_widget.dart';
import '../widget/rounds_list_widget.dart';

class MatchesInDetailsLeaguePage extends ConsumerStatefulWidget {
  final String leagueSyncId;
  final String matchFilter;
  final String role;

  const MatchesInDetailsLeaguePage({
    super.key,
    required this.leagueSyncId,
    required this.matchFilter,
    required this.role,
  });

  @override
  ConsumerState<MatchesInDetailsLeaguePage> createState() => _MatchesScheduleWidgetState();
}

class _MatchesScheduleWidgetState extends ConsumerState<MatchesInDetailsLeaguePage> {
  late final Tuple3<String, String, String> refreshParam;
  late final Tuple2<String, String> streamParam;

  bool _showKnockouts = false;

  @override
  void initState() {
    super.initState();
    refreshParam = Tuple3(widget.leagueSyncId, widget.matchFilter, widget.role);
    streamParam = Tuple2(widget.leagueSyncId, widget.matchFilter);
  }

  Widget _stageToggle({required bool showKnockouts}) {
    final theme = Theme.of(context);

    Widget buildItem({
      required String title,
      required bool selected,
      required VoidCallback onTap,
    }) {
      return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 30.h,
          width: 90.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ?  AppColors.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? AppColors.primaryColor
                  : const Color(0xffE6E6E6),
            ),
          ),
          child: AutoSizeTextWidget(
           text:  title,
            fontSize: 12.sp,
            colorText: selected ? Colors.white : theme.textTheme.bodyMedium?.color,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          buildItem(
            title: 'دور المجموعات',
            selected: !showKnockouts,
            onTap: () => setState(() => _showKnockouts = false),
          ),
          const SizedBox(width: 12),
          buildItem(
            title: 'الإقصائيات',
            selected: showKnockouts,
            onTap: () => setState(() => _showKnockouts = true),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final body = _showKnockouts
        ? KnockoutRoundsListWidget(
      leagueSyncId: widget.leagueSyncId,
      matchFilter: widget.matchFilter,
      role: widget.role,
      refreshParam: refreshParam,
      streamParam: streamParam,
    )
        : RoundsListWidget(
      role: widget.role,
      leagueSyncId: widget.leagueSyncId,
      matchFilter: widget.matchFilter,
      refreshParam: refreshParam,
      streamParam: streamParam,
    );

    return Column(
      children: [
        _stageToggle(showKnockouts: _showKnockouts),
        Expanded(child: body),
      ],
    );
  }
}
