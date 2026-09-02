import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import 'match_date_countdown_fading_label_widget.dart';

class MatchDateCountdownWidget extends StatefulWidget {
  final String dateStr;
  final String timeStr;
  final double expandRatio;

  const MatchDateCountdownWidget({
    super.key,
    required this.dateStr,
    required this.timeStr,
    this.expandRatio = 1.0,
  });

  @override
  State<MatchDateCountdownWidget> createState() => _MatchDateCountdownWidgetState();
}

class _MatchDateCountdownWidgetState extends State<MatchDateCountdownWidget> {
  Timer? _timer;
  Duration _remainingDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initCountdown();
  }

  @override
  void didUpdateWidget(covariant MatchDateCountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dateStr != widget.dateStr || oldWidget.timeStr != widget.timeStr) {
      _initCountdown();
    }
  }

  void _initCountdown() {
    _timer?.cancel();
    final matchDateTime = _parseDateTime(widget.dateStr, widget.timeStr);
    if (matchDateTime == null) return;

    final now = DateTime.now();
    _remainingDuration = matchDateTime.difference(now);

    // If remaining time is less than 24 hours, start periodic 1-second countdown
    if (_remainingDuration.isNegative == false && _remainingDuration.inHours < 24) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) return;
        final currentNow = DateTime.now();
        final diff = matchDateTime.difference(currentNow);
        if (diff.isNegative) {
          timer.cancel();
          setState(() {
            _remainingDuration = Duration.zero;
          });
        } else {
          setState(() {
            _remainingDuration = diff;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  DateTime? _parseDateTime(String dateStr, String timeStr) {
    if (dateStr.isEmpty) return null;
    try {
      final cleanTime = timeStr.isNotEmpty ? timeStr : '00:00:00';
      return DateTime.parse('${dateStr.trim()}T${cleanTime.trim()}');
    } catch (_) {
      return null;
    }
  }

  String _formatTime12Hour(DateTime dt) {
    final int hour12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final String period = dt.hour >= 12 ? 'م' : 'ص';
    return '$hour12:${dt.minute.toString().padLeft(2, '0')} $period';
  }

  String _formatCountdown(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final matchDateTime = _parseDateTime(widget.dateStr, widget.timeStr);
    if (matchDateTime == null) {
      return AutoSizeTextWidget(
        text: 'لم تبدأ بعد',
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        colorText: AppColors.mainColorFont,
      );
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final matchDateOnly = DateTime(matchDateTime.year, matchDateTime.month, matchDateTime.day);
    final int dayDifference = matchDateOnly.difference(today).inDays;

    final String dateShort = '${matchDateTime.day}/${matchDateTime.month}';
    final String timeFormatted = _formatTime12Hour(matchDateTime);
    final double centerFontSize = (13.sp + (6.sp * widget.expandRatio));
    final double spacing = 6.5.h * widget.expandRatio;

    // ── Case 1: Today / Less than 24 hours (Countdown timer hh:mm:ss) ─────────
    if (dayDifference <= 0 || _remainingDuration.inHours < 24) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeTextWidget(
            text: _formatCountdown(_remainingDuration),
            fontSize: centerFontSize,
            fontWeight: FontWeight.w800,
            colorText: AppColors.mainColorFont,
          ),
          SizedBox(height: spacing),
          MatchDateCountdownFadingLabelWidget(
            text: timeFormatted,
            expandRatio: widget.expandRatio,
          ),
        ],
      );
    }

    // ── Case 2: Tomorrow (1 day remaining) ───────────────────────────────────
    if (dayDifference == 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeTextWidget(
            text: 'غداً',
            fontSize: centerFontSize,
            fontWeight: FontWeight.w800,
            colorText: AppColors.mainColorFont,
          ),
          SizedBox(height: spacing),
          MatchDateCountdownFadingLabelWidget(
            text: timeFormatted,
            expandRatio: widget.expandRatio,
          ),
        ],
      );
    }

    // ── Case 3: 2 to 10 Days remaining ──────────────────────────────────────
    if (dayDifference >= 2 && dayDifference <= 10) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MatchDateCountdownFadingLabelWidget(
            text: dateShort,
            expandRatio: widget.expandRatio,
          ),
          SizedBox(height: spacing),
          AutoSizeTextWidget(
            text: '$dayDifference أيام',
            fontSize: centerFontSize,
            fontWeight: FontWeight.w800,
            colorText: AppColors.mainColorFont,
          ),
          SizedBox(height: spacing),
          MatchDateCountdownFadingLabelWidget(
            text: timeFormatted,
            expandRatio: widget.expandRatio,
          ),
        ],
      );
    }

    // ── Case 4: More than 10 Days remaining ──────────────────────────────────
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeTextWidget(
          text: dateShort,
          fontSize: centerFontSize,
          fontWeight: FontWeight.w800,
          colorText: AppColors.mainColorFont,
        ),
        SizedBox(height: spacing),
        MatchDateCountdownFadingLabelWidget(
          text: timeFormatted,
          expandRatio: widget.expandRatio,
        ),
      ],
    );
  }
}
