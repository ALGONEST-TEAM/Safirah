import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../main.dart';
import '../../generated/l10n.dart';
import '../theme/app_colors.dart';
import '../widgets/auto_size_text_widget.dart';

/// مدير الإشعارات العلوية المباشرة (OverlayEntry)
/// يعمل كطبقة بصرية عائمة بدون حجز مكدس التنقل (Navigator)
/// مما يتيح إغلاق الصفحة والرجوع فوراً دون أي تعليق أو اعتراض لأزرار الرجوع.
class _AppNotificationOverlay {
  static OverlayEntry? _currentEntry;
  static _AppNotificationBannerState? _currentState;

  static void show({
    required BuildContext context,
    required Widget child,
    Duration displayDuration = const Duration(milliseconds: 2600),
  }) {
    // إغلاق أي إشعار سابق فوراً لتجنب التراكم
    _dismissCurrent();

    final overlayState = _resolveOverlay(context);
    if (overlayState == null) return;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) => _AppNotificationBanner(
        onDismissed: () {
          if (identical(_currentEntry, entry)) {
            _currentEntry = null;
            _currentState = null;
          }
          if (entry.mounted) {
            entry.remove();
          }
        },
        displayDuration: displayDuration,
        child: child,
      ),
    );

    _currentEntry = entry;
    overlayState.insert(entry);
  }

  static void _dismissCurrent() {
    if (_currentState != null && _currentState!.mounted) {
      _currentState!.dismiss();
    } else if (_currentEntry != null && _currentEntry!.mounted) {
      _currentEntry!.remove();
      _currentEntry = null;
      _currentState = null;
    }
  }

  static OverlayState? _resolveOverlay(BuildContext context) {
    // الاعتماد على Overlay الخاص بالـ Navigator الرئيسي ليظل الإشعار مستمراً حتى عند تبديل الصفحات
    final navState = appNavigatorKey.currentState;
    if (navState != null && navState.overlay != null) {
      return navState.overlay;
    }

    if (context.mounted) {
      return Overlay.maybeOf(context);
    }

    return null;
  }
}

class _AppNotificationBanner extends StatefulWidget {
  final Widget child;
  final Duration displayDuration;
  final VoidCallback onDismissed;

  const _AppNotificationBanner({
    required this.child,
    required this.displayDuration,
    required this.onDismissed,
  });

  @override
  State<_AppNotificationBanner> createState() => _AppNotificationBannerState();
}

class _AppNotificationBannerState extends State<_AppNotificationBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  Timer? _dismissTimer;
  bool _isDismissing = false;

  @override
  void initState() {
    super.initState();
    _AppNotificationOverlay._currentState = this;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
      reverseDuration: const Duration(milliseconds: 200),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    _controller.forward();

    _dismissTimer = Timer(widget.displayDuration, () {
      dismiss();
    });
  }

  void dismiss() {
    if (_isDismissing || !mounted) return;
    _isDismissing = true;
    _dismissTimer?.cancel();
    _dismissTimer = null;

    _controller.reverse().then((_) {
      if (mounted) {
        widget.onDismissed();
      }
    });
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onVerticalDragUpdate: (details) {
                  // سحب خفيف للأعلى لإغلاق الإشعار فوراً
                  if (details.primaryDelta != null && details.primaryDelta! < -4) {
                    dismiss();
                  }
                },
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildBannerCard({
  required Color backgroundColor,
  required Widget content,
  IconData? icon,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: Colors.white,
              size: 19.r,
            ),
            8.w.horizontalSpace,
          ],
          Flexible(
            child: content,
          ),
        ],
      ),
    ),
  );
}

/// Success
void showFlashBarSuccess({
  required BuildContext context,
  required String message,
}) {
  _AppNotificationOverlay.show(
    context: context,
    child: _buildBannerCard(
      backgroundColor: AppColors.successSwatch.shade800.withValues(alpha: .95),
      icon: Icons.check_circle_outline_rounded,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.6.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'IBMPlexSansArabic',
        ),
      ),
    ),
  );
}

/// Error
void showFlashBarError({
  required BuildContext context,
  required String title,
  required String text,
}) {
  _AppNotificationOverlay.show(
    context: context,
    child: _buildBannerCard(
      backgroundColor: const Color(0xFFBC2A23),
      icon: Icons.error_outline_rounded,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title.isNotEmpty) ...[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'IBMPlexSansArabic',
              ),
            ),
            3.h.verticalSpace,
          ],
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.4.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'IBMPlexSansArabic',
            ),
          ),
        ],
      ),
    ),
  );
}

/// Warning
void showFlashBarWarring({
  required BuildContext context,
  required String message,
}) {
  _AppNotificationOverlay.show(
    context: context,
    child: _buildBannerCard(
      backgroundColor: AppColors.dangerColor,
      icon: Icons.warning_amber_rounded,
      content: Text(
        message,
        textAlign: TextAlign.center,
        maxLines: 4,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11.8.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'IBMPlexSansArabic',
        ),
      ),
    ),
  );
}

/// Exit
void pressAgainToExit({
  required BuildContext context,
  String? text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: 160.w,
      duration: const Duration(seconds: 2),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.sp)),
        alignment: Alignment.center,
        child: AutoSizeTextWidget(
          text: text ?? S.of(context).clickAgainToExit,
          colorText: Colors.white,
          fontSize: 14.sp,
          minFontSize: 4,
          maxFontSize: 20,
          textAlign: TextAlign.center,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black54.withValues(alpha: .8),
    ),
  );
}
