import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Renders an image from a local file path.
///
/// Supports:
/// - Absolute paths like: /data/user/0/... (Android)
/// - file:// URIs
/// - Windows paths like: C:\\...
class OfflineImagesWidget extends StatelessWidget {
  final String path;
  final bool circularImage;
  final double? circularRadius;
  final Size? size;
  final BoxFit? fit;
  final double? borderRadius;
  final Color? backgroundColor;
  final Widget? fallback;

  const OfflineImagesWidget({
    super.key,
    required this.path,
    this.circularImage = false,
    this.circularRadius,
    this.size,
    this.fit,
    this.borderRadius,
    this.backgroundColor,
    this.fallback,
  });

  static bool isOfflinePath(String raw) {
    final u = raw.trim();
    if (u.isEmpty) return false;
    return u.startsWith('/') || u.startsWith('file://') ||
        RegExp(r'^[a-zA-Z]:\\').hasMatch(u);
  }

  File? _fileFromPath(String raw) {
    final u = raw.trim();
    if (u.isEmpty) return null;

    if (u.startsWith('file://')) {
      final uri = Uri.tryParse(u);
      final p = uri?.toFilePath();
      if (p == null || p.isEmpty) return null;
      return File(p);
    }

    return File(u);
  }

  @override
  Widget build(BuildContext context) {
    final file = _fileFromPath(path);
    if (file == null) return fallback ?? const SizedBox.shrink();

    final provider = FileImage(file);
    final decorationImage = DecorationImage(
      image: provider,
      fit: fit ?? BoxFit.cover,
    );

    return SizedBox(
      height: size?.height,
      width: size?.width,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          circularImage
              ? CircleAvatar(
                  backgroundImage: provider,
                  radius: circularRadius ?? 35.sp,
                  backgroundColor: Colors.transparent,
                )
              : Container(
                  decoration: BoxDecoration(
                    image: decorationImage,
                    color: backgroundColor ?? Colors.transparent,
                    borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                  ),
                  height: size?.height,
                  width: size?.width,
                ),
        ],
      ),
    );
  }
}

