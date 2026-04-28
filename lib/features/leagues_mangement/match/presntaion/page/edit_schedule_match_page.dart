import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/widgets/buttons/default_button.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../../../../authorization/data/model/user_has_role_model.dart';
import '../../../../authorization/persntaion/riverpod/riverpod.dart';
import '../../../leagues/persntaion/widget/date_pickers.dart';
import '../../../match_term_event/presntation/state_mangement/riverpod.dart';
import '../state_managment/riverpod.dart';

class _PickedUser {
  final String syncId;
  final String name;

  const _PickedUser({required this.syncId, required this.name});
}

class EditScheduleMatchPage extends ConsumerStatefulWidget {
  const EditScheduleMatchPage({
    super.key,
    required this.matchSyncId,
    required this.leagueSyncId,
  });

  final String leagueSyncId;
  final String matchSyncId;

  @override
  ConsumerState<EditScheduleMatchPage> createState() =>
      _EditScheduleMatchPageState();
}

class _EditScheduleMatchPageState extends ConsumerState<EditScheduleMatchPage> {
  final TextEditingController dateMatch = TextEditingController();
  final TextEditingController timeMatch = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  _PickedUser? _referee;
  _PickedUser? _media;
  bool _prefilledBaseFields = false;

  @override
  void dispose() {
    dateMatch.dispose();
    timeMatch.dispose();
    super.dispose();
  }

  void _prefillBaseFields(DateTime scheduledAt) {
    if (_prefilledBaseFields) return;
    _prefilledBaseFields = true;
    _selectedDate = scheduledAt;
    _selectedTime = TimeOfDay.fromDateTime(scheduledAt);
    dateMatch.text = DatePickers.format(scheduledAt, pattern: 'yMMMMd');
    timeMatch.text = TimePickers.format(_selectedTime!);
  }

  _PickedUser? _findPickedUser(
    List<UserHasRoleModel> users,
    String? syncId,
    String fallbackName,
  ) {
    final normalizedSyncId = (syncId ?? '').trim();
    if (normalizedSyncId.isEmpty) return null;

    for (final user in users) {
      if ((user.syncId ?? '').trim() == normalizedSyncId) {
        return _PickedUser(syncId: normalizedSyncId, name: user.name);
      }
    }

    return _PickedUser(syncId: normalizedSyncId, name: fallbackName);
  }

  void _syncInitialPickedUsers({
    required String? refereeSyncId,
    required String? mediaSyncId,
    required List<UserHasRoleModel> refereeUsers,
    required List<UserHasRoleModel> mediaUsers,
  }) {
    final nextReferee = _referee ??
        _findPickedUser(refereeUsers, refereeSyncId, 'الحكم الحالي');
    final nextMedia =
        _media ?? _findPickedUser(mediaUsers, mediaSyncId, 'الإعلامي الحالي');

    if (nextReferee == _referee && nextMedia == _media) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _referee = nextReferee;
        _media = nextMedia;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheduleState = ref.watch(scheduleMatchProvider);
    final matchState = ref.watch(getFullMatchDataProvider(widget.matchSyncId));
    ref.watch(usersHasRoleRefreshProvider(widget.leagueSyncId));

    final refereeUsersAsync = ref.watch(
      usersHasRolesStreamProvider(
        (leagueSyncId: widget.leagueSyncId, role: 'الحكم'),
      ),
    );
    final mediaUsersAsync = ref.watch(
      usersHasRolesStreamProvider(
        (leagueSyncId: widget.leagueSyncId, role: 'الإعلامي'),
      ),
    );

    final match = matchState.data;
    final scheduledAt = match.scheduledStartTime ?? match.matchDate;

    if (matchState.stateData == States.loaded &&
        match.syncId != null &&
        scheduledAt != null) {
      _prefillBaseFields(scheduledAt);
      _syncInitialPickedUsers(
        refereeSyncId: match.refereeSyncId,
        mediaSyncId: match.mediaSyncId,
        refereeUsers: refereeUsersAsync.asData?.value ?? const [],
        mediaUsers: mediaUsersAsync.asData?.value ?? const [],
      );
    }

    return Scaffold(
      appBar: const SecondaryAppBarWidget(
        title: 'تعديل جدولة المباراة',
      ),
      body: matchState.stateData == States.loading && !_prefilledBaseFields
          ? const Center(child: CircularProgressIndicator())
          : matchState.stateData == States.error
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: const AutoSizeTextWidget(
                      text: 'تعذر تحميل بيانات المباراة الحالية',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeTextWidget(
                        text: 'تاريخ المباراة',
                        fontSize: 10.sp,
                      ),
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
                      AutoSizeTextWidget(
                        text: 'وقت المباراة',
                        fontSize: 10.sp,
                      ),
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
                      12.h.verticalSpace,
                      const _SectionTitle('الحكم'),
                      6.h.verticalSpace,
                      _PickTile(
                        valueText: _referee?.name ?? '',
                        onTap: () async {
                          final picked = await _openUserPickerSheet(
                            context,
                            leagueSyncId: widget.leagueSyncId,
                            role: 'الحكم',
                            title: 'اختر حكم',
                          );
                          if (picked != null) {
                            setState(() => _referee = picked);
                          }
                        },
                      ),
                      10.h.verticalSpace,
                      const _SectionTitle('الإعلامي'),
                      6.h.verticalSpace,
                      _PickTile(
                        valueText: _media?.name ?? '',
                        onTap: () async {
                          final picked = await _openUserPickerSheet(
                            context,
                            leagueSyncId: widget.leagueSyncId,
                            role: 'الإعلامي',
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
                              .read(roundsRefreshProvider(Tuple3(
                                      widget.leagueSyncId,
                                      'unscheduled',
                                      'organizer'))
                                  .notifier)
                              .refresh();
                          ref
                              .read(roundsRefreshProvider(Tuple3(
                                      widget.leagueSyncId,
                                      'scheduled,live',
                                      'organizer'))
                                  .notifier)
                              .refresh();
                          ref
                              .read(roundsRefreshKnockoutProvider(Tuple3(
                                      widget.leagueSyncId,
                                      'unscheduled',
                                      'organizer'))
                                  .notifier)
                              .refresh();
                          ref
                              .read(roundsRefreshKnockoutProvider(Tuple3(
                                      widget.leagueSyncId,
                                      'scheduled,live',
                                      'organizer'))
                                  .notifier)
                              .refresh();

                          Navigator.pop(context);
                        },
                        bottonWidget: DefaultButtonWidget(
                          text: 'حفظ التعديلات',
                          isLoading: scheduleState.stateData == States.loading,
                          onPressed: () async {
                            if (_selectedDate == null || _selectedTime == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('يرجى اختيار التاريخ والوقت أولاً'),
                                ),
                              );
                              return;
                            }

                            if (_referee == null || _media == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('يرجى اختيار الحكم والإعلامي'),
                                ),
                              );
                              return;
                            }

                            final fullDateTime =
                                TimePickers.merge(_selectedDate!, _selectedTime!);

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
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: AutoSizeTextWidget(text: text, fontSize: 10.sp),
    );
  }
}

class _PickTile extends StatelessWidget {
  final String valueText;
  final VoidCallback onTap;

  const _PickTile({required this.valueText, required this.onTap});

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
            AutoSizeTextWidget(text: title),
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
                    separatorBuilder: (_, __) =>
                        const Divider(height: 0.2, thickness: 0.2),
                    itemBuilder: (context, i) {
                      final u = list[i];
                      return ListTile(
                        title: Align(
                          alignment: Alignment.centerRight,
                          child: AutoSizeTextWidget(text: u.name),
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


