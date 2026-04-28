import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/widgets/buttons/default_button.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../../../../authorization/persntaion/riverpod/riverpod.dart';
import '../../../leagues/persntaion/widget/date_pickers.dart';
import '../../../match_term_event/presntation/state_mangement/riverpod.dart';
import '../state_managment/riverpod.dart';

// ✅ مودل بسيط للاختيار (اسم + syncId)
class _PickedUser {
  final String syncId;
  final String name;

  const _PickedUser({required this.syncId, required this.name});
}

class ScheduleMatchPage extends ConsumerStatefulWidget {
  const ScheduleMatchPage({
    super.key,
    required this.matchSyncId,
    required this.leagueSyncId,
  });

  final String leagueSyncId;
  final String matchSyncId;

  @override
  ConsumerState<ScheduleMatchPage> createState() => _ScheduleMatchPageState();
}

class _ScheduleMatchPageState extends ConsumerState<ScheduleMatchPage> {
  final TextEditingController dateMatch = TextEditingController();
  final TextEditingController timeMatch = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // ✅ الثلاثة الحقول المطلوبة
  _PickedUser? _referee;
  _PickedUser? _organizer;
  _PickedUser? _media;

  @override
  void dispose() {
    dateMatch.dispose();
    timeMatch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleState = ref.watch(scheduleMatchProvider);
    ref.watch(usersHasRoleRefreshProvider(widget.leagueSyncId));
    return Scaffold(
      appBar: SecondaryAppBarWidget(
        title: 'جدولة المباراة',
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
                  setState(() {
                    _selectedDate = picked;
                    dateMatch.text =
                        DatePickers.format(picked, pattern: 'yMMMMd');
                  });
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
            10.h.verticalSpace,

            AutoSizeTextWidget(text: 'وقت المباراة', fontSize: 10.sp),
            6.h.verticalSpace,
            InkWell(
              onTap: () async {
                final picked = await TimePickers.pick(context);
                if (picked != null) {
                  setState(() {
                    _selectedTime = picked;
                    timeMatch.text = TimePickers.format(picked);
                  });
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

            // ✅ هنا: إضافة الثلاثة الحقول بنفس شكل الصورة
            12.h.verticalSpace,

            _SectionTitle('الحكم'),
            6.h.verticalSpace,
            _PickTile(
              valueText: _referee?.name ?? '',
              onTap: () async {
                final picked = await _openUserPickerSheet(
                  context,
                  leagueSyncId: widget.leagueSyncId,
                  role: 'الحكم', // غيّرها لقيمة الدور عندك إن كانت بالعربي
                  title: 'اختر حكم',
                );
                if (picked != null) {
                  setState(() => _referee = picked);
                }
              },
            ),
            10.h.verticalSpace,
            _SectionTitle('الإعلامي'),
            6.h.verticalSpace,
            _PickTile(
              valueText: _media?.name ?? '',
              onTap: () async {
                final picked = await _openUserPickerSheet(
                  context,
                  leagueSyncId: widget.leagueSyncId,
                  role: 'الإعلامي', // غيّرها لقيمة الدور عندك
                  title: 'اختر إعلامي',
                );
                if (picked != null) {
                  setState(() => _media = picked);
                }
              },
            ),

            14.h.verticalSpace,

            CheckStateInPostApiDataWidget(
              state: scheduleState,
              functionSuccess: () {
                ref
                    .read(roundsRefreshProvider(
                            Tuple3(widget.leagueSyncId, 'unscheduled','organizer'))
                        .notifier)
                    .refresh();
                ref
                    .read(roundsRefreshProvider(
                            Tuple3(widget.leagueSyncId, 'scheduled,live','organizer'))
                        .notifier)
                    .refresh();
                ref
                    .read(roundsRefreshKnockoutProvider(
                    Tuple3(widget.leagueSyncId, 'unscheduled','organizer'))
                    .notifier)
                    .refresh();
                ref
                    .read(roundsRefreshKnockoutProvider(
                    Tuple3(widget.leagueSyncId, 'scheduled,live','organizer'))
                    .notifier)
                    .refresh();

                Navigator.pop(context);
              },
              bottonWidget: DefaultButtonWidget(
                text: '  جدولة  ',
                isLoading: scheduleState.stateData == States.loading,
                onPressed: () async {
                  if (_selectedDate == null || _selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('يرجى اختيار التاريخ والوقت أولاً')),
                    );
                    return;
                  }

                  // ✅ (اختياري) تحقق من اختيار الثلاثة
               //   لو تريدها إجبارية، فعّل هذا الشرط:
                  if (_referee == null  || _media == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى اختيار الحكم والمنظم والإعلامي')),
                    );
                    return;
                  }

                  final fullDateTime =
                      TimePickers.merge(_selectedDate!, _selectedTime!);

                  print('📅 التاريخ والوقت المدمجان: $fullDateTime');

                  print(_referee!.syncId);
                  print(_media!.syncId);

                  ref.read(scheduleMatchProvider.notifier).run(
                        matchSyncId: widget.matchSyncId,
                        scheduledDateTime: fullDateTime,
                        refereeSyncId: _referee!.syncId,
                        mediaSyncId: _media!.syncId,
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // UI helpers (شكل مطابق للصورة)
  // =========================

  Widget _SectionTitle(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: AutoSizeTextWidget(text: text, fontSize: 10.sp),
    );
  }
}

// ✅ Tile بنفس الشكل (خلفية رمادية + سهم + قيمة يمين)
class _PickTile extends StatelessWidget {
  final String valueText;
  final VoidCallback onTap;

  const _PickTile({
    required this.valueText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                valueText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11.sp),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_outlined, size: 18),
          ],
        ),
      ),
    );
  }
}

// =========================
// Picker Sheet
// =========================

Future<_PickedUser?> _openUserPickerSheet(
  BuildContext context, {
  required String leagueSyncId,
  required String role,
  required String title,
}) {
  return showModalBottomSheet<_PickedUser?>(
    context: context,
    isScrollControlled: false,
    backgroundColor: Colors.white,
    builder: (ctx) {
      return _UsersPickerSheet(
        leagueSyncId: leagueSyncId,
        role: role,
        title: title,
      );
    },
  );
}

class _UsersPickerSheet extends ConsumerWidget {
  const _UsersPickerSheet({
    required this.leagueSyncId,
    required this.role,
    required this.title,
  });

  final String leagueSyncId;
  final String role;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncList = ref.watch(usersHasRolesStreamProvider(
      (leagueSyncId: leagueSyncId, role: role),
    ));

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeTextWidget(text: title,),
            10.h.verticalSpace,
            asyncList.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text('خطأ: $e'),
              ),
              data: (list) {
                if (list.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('لا يوجد عناصر لهذا الدور'),
                  );
                }

                return Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const Divider(height: 0.2,thickness: 0.2,),
                    itemBuilder: (context, i) {
                      final u = list[i];
                      return ListTile(
                        title: Align(
                          alignment: Alignment.centerRight,
                          child: AutoSizeTextWidget(
                           text:  u.name,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(
                            context,
                            _PickedUser(syncId: u.syncId!, name: u.name),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
