import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import '../riverpod/prediction_riverpod.dart';

class LiveMatchTimerWidget extends ConsumerStatefulWidget {
  final num? status;
  final int? minute;
  final int? second;
  final bool? ticking;
  final int? timeAdded;

  const LiveMatchTimerWidget({
    super.key,
    required this.status,
    this.minute,
    this.second,
    this.ticking,
    this.timeAdded,
  });

  @override
  ConsumerState<LiveMatchTimerWidget> createState() => _LiveMatchTimerWidgetState();
}

class _LiveMatchTimerWidgetState extends ConsumerState<LiveMatchTimerWidget>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late int _minute;
  late int _second;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _minute = widget.minute ?? 0;
    _second = widget.second ?? 0;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _startTimerIfNeeded();
  }

  @override
  void didUpdateWidget(covariant LiveMatchTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool needTimerReset = false;

    if (widget.minute != oldWidget.minute || widget.second != oldWidget.second) {
      _minute = widget.minute ?? _minute;
      _second = widget.second ?? _second;
      needTimerReset = true;
    }

    if (widget.ticking != oldWidget.ticking ||
        widget.status != oldWidget.status ||
        needTimerReset) {
      _startTimerIfNeeded();
    }
  }

  void _startTimerIfNeeded() {
    _timer?.cancel();
    final statusHelper = ref.read(matchStatusHelperProvider);
    final isLive = statusHelper.isLive(widget.status);
    final isTicking = widget.ticking ?? isLive;

    if (isLive && isTicking) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() {
          _second++;
          if (_second >= 60) {
            _second = 0;
            _minute++;
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusHelper = ref.watch(matchStatusHelperProvider);
    final isLive = statusHelper.isLive(widget.status);

    if (!isLive && _minute == 0) {
      return const SizedBox.shrink();
    }

    final int statusId = widget.status?.toInt() ?? 0;
    final isTicking = widget.ticking ?? (isLive && statusId != 3 && statusId != 9 && statusId != 21);

    String labelText;
    Color badgeBgColor;
    Color badgeBorderColor;
    Color textColor;
    Color dotColor;

    final bool isHalfTime = statusId == 3 || (!isTicking && _minute >= 44 && _minute <= 46);
    final bool isExtraBreak = statusId == 9 || statusId == 21 || (!isTicking && _minute >= 90 && _minute <= 106);

    if (isHalfTime) {
      labelText = "استراحة (HT)";
      badgeBgColor = Colors.orange.shade50;
      badgeBorderColor = Colors.orange.shade300;
      textColor = Colors.orange.shade800;
      dotColor = Colors.orange.shade700;
    } else if (isExtraBreak) {
      labelText = "استراحة الإضافي";
      badgeBgColor = Colors.amber.shade50;
      badgeBorderColor = Colors.amber.shade300;
      textColor = Colors.amber.shade900;
      dotColor = Colors.amber.shade700;
    } else if (statusId == 23) {
      labelText = "ركلات ترجيحية";
      badgeBgColor = Colors.purple.shade50;
      badgeBorderColor = Colors.purple.shade300;
      textColor = Colors.purple.shade800;
      dotColor = Colors.purple.shade700;
    } else {
      final minStr = _minute.toString().padLeft(2, '0');
      final secStr = _second.toString().padLeft(2, '0');
      final timeStr = "$minStr:$secStr";
      final extraTime = widget.timeAdded != null && widget.timeAdded! > 0
          ? " (+${widget.timeAdded}')"
          : "";
      labelText = "$timeStr$extraTime";
      badgeBgColor = AppColors.successSwatch.shade50.withValues(alpha: 0.8);
      badgeBorderColor = AppColors.successSwatch.shade600.withValues(alpha: 0.3);
      textColor = AppColors.successSwatch.shade700;
      dotColor = AppColors.successSwatch.shade600;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: badgeBgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: badgeBorderColor,
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isTicking)
            FadeTransition(
              opacity: _pulseController,
              child: Container(
                width: 5.r,
                height: 5.r,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
            )
          else
            Container(
              width: 5.r,
              height: 5.r,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
          3.w.horizontalSpace,
          AutoSizeTextWidget(
            text: labelText,
            fontSize: 9.sp,
            fontWeight: FontWeight.w700,
            colorText: textColor,
          ),
        ],
      ),
    );
  }
}
