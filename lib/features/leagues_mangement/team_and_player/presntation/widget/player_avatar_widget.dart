import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class PlayerAvatarWidget extends StatelessWidget {
  const PlayerAvatarWidget({
    super.key,
    this.avatarUrl,
    this.radius,
    this.iconSize,
  });

  final String? avatarUrl;
  final double? radius;
  final double? iconSize;

  Widget _buildFallback(double effectiveRadius) {
    return CircleAvatar(
      radius: effectiveRadius,
      backgroundColor: AppColors.secondaryColor.withValues(alpha: .10),
      child: Icon(
        Icons.person_rounded,
        color: AppColors.secondaryColor,
        size: iconSize ?? effectiveRadius,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = radius ?? 22.r;
    final url = (avatarUrl ?? '').trim();
    if (url.isEmpty) {
      return _buildFallback(effectiveRadius);
    }

    final dimension = effectiveRadius * 2;
    return ClipOval(
      child: Image.network(
        url,
        width: dimension,
        height: dimension,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildFallback(effectiveRadius),
      ),
    );
  }
}

