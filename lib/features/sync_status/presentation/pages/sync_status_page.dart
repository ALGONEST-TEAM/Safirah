import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/core/database/table/sync_queue_table.dart';
import 'package:safirah/core/helpers/flash_bar_helper.dart';
import 'package:safirah/core/state/check_state_in_get_api_data_widget.dart';
import 'package:safirah/core/theme/app_colors.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import 'package:safirah/core/widgets/secondary_app_bar_widget.dart';
import 'package:safirah/features/sync_status/presentation/riverpod/sync_status_riverpod.dart';

class SyncStatusPage extends ConsumerStatefulWidget {
  const SyncStatusPage({super.key});

  @override
  ConsumerState<SyncStatusPage> createState() => _SyncStatusPageState();
}

class _SyncStatusPageState extends ConsumerState<SyncStatusPage> {
  final Set<int> _retryingIds = <int>{};
  bool _retryingAll = false;
  bool _refreshing = false;

  Future<void> _retryOne(SyncQueueData row) async {
    if (_retryingIds.contains(row.id)) return;

    setState(() => _retryingIds.add(row.id));
    try {
      final updated = await ref.read(syncStatusActionsProvider).retryOne(row.id);
      if (!mounted) return;

      if (updated) {
        showFlashBarSuccess(
          context: context,
          message: 'تمت إعادة إدراج العملية في طابور المزامنة.',
        );
      } else {
        showFlashBarWarring(
          context: context,
          message: 'لا يمكن إعادة إرسال هذه العملية حالياً.',
        );
      }
    } catch (_) {
      if (!mounted) return;
      showFlashBarError(
        context: context,
        title: 'تعذر إعادة الإرسال',
        text: 'حدث خطأ أثناء محاولة إعادة إرسال العملية.',
      );
    } finally {
      if (mounted) {
        setState(() => _retryingIds.remove(row.id));
      }
    }
  }

  Future<void> _retryAllFailed() async {
    if (_retryingAll) return;

    setState(() => _retryingAll = true);
    try {
      final updated = await ref.read(syncStatusActionsProvider).retryAll();
      if (!mounted) return;

      if (updated > 0) {
        showFlashBarSuccess(
          context: context,
          message: 'تمت إعادة إدراج $updated عملية للمزامنة.',
        );
      } else {
        showFlashBarWarring(
          context: context,
          message: 'لا توجد عمليات فاشلة لإعادة إرسالها.',
        );
      }
    } catch (_) {
      if (!mounted) return;
      showFlashBarError(
        context: context,
        title: 'تعذر إعادة إرسال العمليات',
        text: 'حدث خطأ أثناء محاولة إعادة إرسال العمليات الفاشلة.',
      );
    } finally {
      if (mounted) {
        setState(() => _retryingAll = false);
      }
    }
  }

  Future<void> _refreshQueue() async {
    if (_refreshing) return;
    setState(() => _refreshing = true);
    try {
      await ref.read(syncStatusActionsProvider).syncNow();
    } finally {
      if (mounted) {
        setState(() => _refreshing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(syncStatusQueueProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: const SecondaryAppBarWidget(
        title: 'حالة المزامنة',
      ),
      body: CheckStateInStreamWidget<List<SyncQueueData>>(
        async: async,
        isEmpty: (rows) => rows.isEmpty,
        onRefresh: _refreshQueue,
        emptyBuilder: () => RefreshIndicator(
          onRefresh: _refreshQueue,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.sp),
            children: [
              SizedBox(height: 140.h),
              Icon(
                Icons.cloud_done_outlined,
                size: 54.sp,
                color: AppColors.successSwatch.shade500,
              ),
              16.h.verticalSpace,
              AutoSizeTextWidget(
                text: 'لا توجد عمليات مزامنة تحتاج إلى متابعة حالياً',
                textAlign: TextAlign.center,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              8.h.verticalSpace,
              AutoSizeTextWidget(
                text: 'جميع العمليات الحالية تمت مزامنتها أو سيتم التعامل معها تلقائياً.',
                textAlign: TextAlign.center,
                fontSize: 11.5.sp,
                colorText: AppColors.fontColor2,
                maxLines: 3,
              ),
            ],
          ),
        ),
        dataBuilder: (rows) {
          final failedRows = rows
              .where((e) => e.status == SyncQueueStatus.failed)
              .toList();
          final inProgressRows = rows
              .where((e) => e.status == SyncQueueStatus.inProgress)
              .toList();
          final pendingRows = rows
              .where((e) => e.status == SyncQueueStatus.pending)
              .toList();

          return RefreshIndicator(
            onRefresh: _refreshQueue,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(12.sp),
              children: [
                _SummaryCard(
                  pendingCount: pendingRows.length,
                  inProgressCount: inProgressRows.length,
                  failedCount: failedRows.length,
                  retryingAll: _retryingAll,
                  refreshing: _refreshing,
                  onRetryAll: failedRows.isEmpty ? null : _retryAllFailed,
                ),
                if (failedRows.isNotEmpty) ...[
                  12.h.verticalSpace,
                  _SectionHeader(
                    title: 'فشلت وتحتاج مراجعة',
                    count: failedRows.length,
                    color: AppColors.dangerColor,
                  ),
                  ...failedRows.map(
                    (row) => _QueueCard(
                      row: row,
                      retrying: _retryingIds.contains(row.id),
                      onRetry: () => _retryOne(row),
                    ),
                  ),
                ],
                if (inProgressRows.isNotEmpty) ...[
                  12.h.verticalSpace,
                  _SectionHeader(
                    title: 'قيد التنفيذ حالياً',
                    count: inProgressRows.length,
                    color: AppColors.primaryColor,
                  ),
                  ...inProgressRows.map(
                    (row) => _QueueCard(row: row),
                  ),
                ],
                if (pendingRows.isNotEmpty) ...[
                  12.h.verticalSpace,
                  _SectionHeader(
                    title: 'بانتظار الإرسال',
                    count: pendingRows.length,
                    color: AppColors.secondaryColor,
                  ),
                  ...pendingRows.map(
                    (row) => _QueueCard(row: row),
                  ),
                ],
                16.h.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final int pendingCount;
  final int inProgressCount;
  final int failedCount;
  final bool retryingAll;
  final bool refreshing;
  final VoidCallback? onRetryAll;

  const _SummaryCard({
    required this.pendingCount,
    required this.inProgressCount,
    required this.failedCount,
    required this.retryingAll,
    required this.refreshing,
    required this.onRetryAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.sync, color: AppColors.secondaryColor, size: 20.sp),
              8.w.horizontalSpace,
              Expanded(
                child: AutoSizeTextWidget(
                  text: 'ملخص المزامنة',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          12.h.verticalSpace,
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _CountPill(label: 'فاشلة', value: failedCount, color: AppColors.dangerColor),
              _CountPill(label: 'قيد التنفيذ', value: inProgressCount, color: AppColors.primaryColor),
              _CountPill(label: 'بانتظار الإرسال', value: pendingCount, color: AppColors.secondaryColor),
            ],
          ),
          12.h.verticalSpace,
          AutoSizeTextWidget(
            text: failedCount > 0
                ? 'يمكنك إعادة إرسال العمليات الفاشلة يدويًا من هنا.'
                : 'المزامنة التلقائية ما زالت تعمل. يمكنك السحب للتحديث في أي وقت.',
            fontSize: 11.sp,
            colorText: AppColors.fontColor2,
            maxLines: 3,
          ),
          if (onRetryAll != null) ...[
            14.h.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: retryingAll || refreshing ? null : onRetryAll,
                icon: retryingAll
                    ? SizedBox(
                        height: 16.sp,
                        width: 16.sp,
                        child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.refresh),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 11.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                label: AutoSizeTextWidget(
                  text: retryingAll ? 'جارٍ إعادة الإرسال...' : 'إعادة إرسال الكل',
                  colorText: Colors.white,
                  fontSize: 11.5.sp,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CountPill extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _CountPill({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8.sp, color: color),
          6.w.horizontalSpace,
          AutoSizeTextWidget(
            text: '$label: $value',
            fontSize: 10.5.sp,
            colorText: color,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const _SectionHeader({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Container(
            width: 4.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(999.r),
            ),
          ),
          8.w.horizontalSpace,
          Expanded(
            child: AutoSizeTextWidget(
              text: title,
              fontSize: 12.4.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: AutoSizeTextWidget(
              text: '$count',
              fontSize: 10.5.sp,
              colorText: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _QueueCard extends StatelessWidget {
  final SyncQueueData row;
  final bool retrying;
  final VoidCallback? onRetry;

  const _QueueCard({
    required this.row,
    this.retrying = false,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(row.status);
    final label = _statusLabel(row.status);
    final date = DateFormat('yyyy/MM/dd - hh:mm a').format(row.createdAt.toLocal());
    final lastAttempt = row.lastAttemptAt == null
        ? 'لم تتم أي محاولة بعد'
        : DateFormat('yyyy/MM/dd - hh:mm a').format(row.lastAttemptAt!.toLocal());

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: .18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 34.sp,
                width: 34.sp,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  row.status == SyncQueueStatus.failed
                      ? Icons.error_outline
                      : row.status == SyncQueueStatus.inProgress
                          ? Icons.sync
                          : Icons.schedule,
                  color: color,
                  size: 18.sp,
                ),
              ),
              10.w.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text: _entityTitle(row.entityType),
                      fontSize: 12.2.sp,
                      fontWeight: FontWeight.w700,
                      maxLines: 2,
                    ),
                    4.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: 'العملية: ${_operationTitle(row.operation)}',
                      fontSize: 10.8.sp,
                      colorText: AppColors.fontColor2,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: AutoSizeTextWidget(
                  text: label,
                  fontSize: 10.sp,
                  colorText: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          12.h.verticalSpace,
          _MetaLine(title: 'تاريخ الإنشاء', value: date),
          6.h.verticalSpace,
          _MetaLine(title: 'آخر محاولة', value: lastAttempt),
          6.h.verticalSpace,
          _MetaLine(title: 'عدد المحاولات', value: '${row.attemptCount}'),
          if ((row.lastError ?? '').trim().isNotEmpty) ...[
            10.h.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                color: AppColors.dangerColor.withValues(alpha: .06),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: AutoSizeTextWidget(
                text: row.lastError!.trim(),
                fontSize: 10.8.sp,
                maxLines: 5,
                colorText: AppColors.dangerColor,
              ),
            ),
          ],
          if (onRetry != null) ...[
            12.h.verticalSpace,
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: OutlinedButton.icon(
                onPressed: retrying ? null : onRetry,
                icon: retrying
                    ? SizedBox(
                        height: 15.sp,
                        width: 15.sp,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.secondaryColor,
                        ),
                      )
                    : const Icon(Icons.refresh),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.secondaryColor),
                  foregroundColor: AppColors.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                label: AutoSizeTextWidget(
                  text: retrying ? 'جارٍ الإرسال...' : 'إعادة الإرسال',
                  fontSize: 10.8.sp,
                  colorText: AppColors.secondaryColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static Color _statusColor(String status) {
    switch (status) {
      case SyncQueueStatus.failed:
        return AppColors.dangerColor;
      case SyncQueueStatus.inProgress:
        return AppColors.primaryColor;
      case SyncQueueStatus.pending:
      default:
        return AppColors.secondaryColor;
    }
  }

  static String _statusLabel(String status) {
    switch (status) {
      case SyncQueueStatus.failed:
        return 'فشلت';
      case SyncQueueStatus.inProgress:
        return 'قيد التنفيذ';
      case SyncQueueStatus.pending:
      default:
        return 'بانتظار الإرسال';
    }
  }

  static String _operationTitle(String operation) {
    switch (operation) {
      case 'create':
        return 'إنشاء';
      case 'update':
        return 'تحديث';
      case 'delete':
        return 'حذف';
      default:
        return operation;
    }
  }

  static String _entityTitle(String entityType) {
    switch (entityType) {
      case 'league':
        return 'الدوري';
      case 'team':
        return 'الفريق';
      case 'match':
        return 'المباراة';
      case 'goal':
        return 'الهدف';
      case 'assist':
        return 'التمريرات الحاسمة';
      case 'warning':
        return 'الإنذارات';
      case 'invitations':
        return 'الرد على الدعوات';
      case 'playerToTeam':
        return 'توزيع اللاعبين';
      case 'drawGroups':
        return 'القرعة';
      case 'rounds':
        return 'الجولات';
      case 'leagueTerm':
        return 'أشواط الدوري';
      case 'leagueStatus':
        return 'حالة الدوري';
      case 'qualifiedTeam':
        return 'ترتيب وتأهل الفرق';
      case 'rule':
        return 'قوانين الدوري';
      default:
        return entityType;
    }
  }
}

class _MetaLine extends StatelessWidget {
  final String title;
  final String value;

  const _MetaLine({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 88.w,
          child: AutoSizeTextWidget(
            text: '$title:',
            fontSize: 10.6.sp,
            colorText: AppColors.fontColor2,
            maxLines: 2,
          ),
        ),
        Expanded(
          child: AutoSizeTextWidget(
            text: value,
            fontSize: 10.8.sp,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}


