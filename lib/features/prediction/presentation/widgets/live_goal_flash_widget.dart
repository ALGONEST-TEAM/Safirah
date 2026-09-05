import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class LiveGoalFlashWidget extends StatefulWidget {
  final Widget liveTimerWidget;
  final Widget scoreWidget;
  final String? lastGoalSide; // 'home' or 'away'
  final DateTime? lastGoalTime;
  final double expandRatio;

  const LiveGoalFlashWidget({
    Key? key,
    required this.liveTimerWidget,
    required this.scoreWidget,
    this.lastGoalSide,
    this.lastGoalTime,
    this.expandRatio = 1.0,
  }) : super(key: key);

  @override
  State<LiveGoalFlashWidget> createState() => _LiveGoalFlashWidgetState();
}

class _LiveGoalFlashWidgetState extends State<LiveGoalFlashWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _flashController;
  Timer? _goalTimer;
  bool _isGoalActive = false;

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000), 
    );
    _checkGoalStatus();
  }

  @override
  void didUpdateWidget(covariant LiveGoalFlashWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.lastGoalTime != oldWidget.lastGoalTime) {
      _checkGoalStatus();
    }
  }

  static const int _goalFlashDurationSeconds = 20;

  void _checkGoalStatus() {
    if (widget.lastGoalTime == null || widget.lastGoalSide == null) {
      _endGoalAnimation();
      return;
    }

    final now = DateTime.now();
    final difference = now.difference(widget.lastGoalTime!);

    if (difference.inSeconds < _goalFlashDurationSeconds) {
      // Start or continue goal animation
      if (!_isGoalActive) {
        setState(() {
          _isGoalActive = true;
        });
        _flashController.repeat(reverse: true);
      }

      // Schedule stop
      _goalTimer?.cancel();
      _goalTimer = Timer(
        Duration(seconds: _goalFlashDurationSeconds - difference.inSeconds),
        () {
          if (mounted) {
            _endGoalAnimation();
          }
        },
      );
    } else {
      _endGoalAnimation();
    }
  }

  void _endGoalAnimation() {
    if (_isGoalActive) {
      setState(() {
        _isGoalActive = false;
      });
      _flashController.stop();
      _flashController.reset();
    }
  }

  @override
  void dispose() {
    _flashController.dispose();
    _goalTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 1. Timer / Flashing Goal Text
        ClipRect(
          child: Align(
            alignment: Alignment.center,
            heightFactor: widget.expandRatio,
            child: Opacity(
              opacity: widget.expandRatio,
              child: _isGoalActive
                  ? AnimatedBuilder(
                      animation: _flashController,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            // Render the live timer always (to maintain strict layout height),
                            // but make it invisible when we show "هدف".
                            Opacity(
                              opacity: _flashController.value <= 0.5 ? 1.0 : 0.0,
                              child: widget.liveTimerWidget,
                            ),
                            // Show "هدف" exactly in the center when opacity toggles.
                            if (_flashController.value > 0.5)
                              AutoSizeTextWidget(
                                text: 'هدف',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w800,
                                colorText: AppColors.mainColorFont,
                              ),
                          ],
                        );
                      },
                    )
                  : widget.liveTimerWidget,
            ),
          ),
        ),

        SizedBox(height: 6.h * widget.expandRatio),

        // 2. The Score Row
        widget.scoreWidget,

        // 3. The Soccer Ball Indicator under the score (No flashing)
        if (_isGoalActive)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.lastGoalSide == 'home') ...[
                  // Away side (Left in RTL layout means Home is Right, Away is Left)
                  Icon(Icons.arrow_back, color: AppColors.mainColorFont, size: 10.r),
                  3.w.horizontalSpace,
                  Icon(Icons.sports_soccer, color: AppColors.mainColorFont, size: 13.r),
                ] else if (widget.lastGoalSide == 'away') ...[
                  // Home side (Right in RTL layout)
                  Icon(Icons.sports_soccer, color: AppColors.mainColorFont, size: 13.r),
                  3.w.horizontalSpace,
                  Icon(Icons.arrow_forward, color: AppColors.mainColorFont, size: 10.r),
                ]
              ],
            ),
          )
        else
          SizedBox(height: 18.h), // Placeholder to maintain height
      ],
    );
  }
}
