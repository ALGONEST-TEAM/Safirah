import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyBadgeWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const PrivacyPolicyBadgeWidget({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: Colors.white.withValues(alpha: .18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: Colors.white),
          6.w.horizontalSpace,
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10.2.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'IBMPlexSansArabic',
              ),
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return child;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999.r),
      child: child,
    );
  }
}

