import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/widgets/buttons/default_button.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../../../leagues/persntaion/widget/date_pickers.dart';
import '../../../match_term_event/presntation/state_mangement/riverpod.dart';
import '../state_managment/riverpod.dart';

class ScheduleMatchPage extends ConsumerWidget {
  ScheduleMatchPage({
    super.key,
    required this.matchId,
    required this.leagueId,
  });

  final int leagueId;
  final int matchId;

  final TextEditingController dateMatch = TextEditingController();
  final TextEditingController timeMatch = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleState = ref.watch(scheduleMatchProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const AutoSizeTextWidget(
          text: 'جدولة المباراة',
          colorText: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(text: 'تاريخ المباراة', fontSize: 10.sp),
            6.h.verticalSpace,
            InkWell(
              onTap: () async {
                final picked = await DatePickers.pick(context);
                if (picked != null) {
                  _selectedDate = picked;
                  dateMatch.text =
                      DatePickers.format(picked, pattern: 'yMMMMd');
                }
              },
              child: IgnorePointer(
                child: TextFormFieldWidget(
                  controller: dateMatch,
                  type: TextInputType.text,
                  fillColor: Colors.white,
                  suffixIcon: const Icon(Icons.date_range),
                ),
              ),
            ),
            6.h.verticalSpace,
            AutoSizeTextWidget(text: 'وقت المباراة', fontSize: 10.sp),
            6.h.verticalSpace,
            InkWell(
              onTap: () async {
                final picked = await TimePickers.pick(context);
                if (picked != null) {
                  _selectedTime = picked;
                  timeMatch.text = TimePickers.format(picked);
                }
              },
              child: IgnorePointer(
                child: TextFormFieldWidget(
                  controller: timeMatch,
                  type: TextInputType.text,
                  fillColor: Colors.white,
                  suffixIcon: const Icon(Icons.access_time),
                ),
              ),
            ),
            12.h.verticalSpace,
            CheckStateInPostApiDataWidget(
              state: scheduleState,
              functionSuccess: () {
                ref
                    .read(roundsWithGroupsProvider(
                            Tuple2(leagueId, 'unscheduled'))
                        .notifier)
                    .run();
                ref
                    .read(roundsWithGroupsProvider(
                            Tuple2(leagueId, 'scheduled,live'))
                        .notifier)
                    .run();
                ref
                    .read(knockoutRoundsWithMatchesProvider(
                            Tuple2(leagueId, 'unscheduled'))
                        .notifier)
                    .load();
                ref
                    .read(knockoutRoundsWithMatchesProvider(
                            Tuple2(leagueId, 'scheduled,live'))
                        .notifier)
                    .load();

                Navigator.pop(context);
              },
              bottonWidget: DefaultButtonWidget(
                text: '📅  جدولة المباراة ',
                isLoading: scheduleState.stateData == States.loading,
                onPressed: () async {
                  if (_selectedDate == null || _selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('يرجى اختيار التاريخ والوقت أولاً')),
                    );
                    return;
                  }

                  final fullDateTime =
                      TimePickers.merge(_selectedDate!, _selectedTime!);

                  print('📅 التاريخ والوقت المدمجان: $fullDateTime');

                  ref.read(scheduleMatchProvider.notifier).run(
                        matchId: matchId,
                        scheduledDateTime: fullDateTime,
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
