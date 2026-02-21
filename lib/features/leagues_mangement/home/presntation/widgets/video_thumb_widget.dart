import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';

class VideoThumbWidget extends StatelessWidget {
  final String videoUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  const VideoThumbWidget({
    super.key,
    required this.videoUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  Widget _loading(BuildContext context) => Center(
    child: SpinKitPulse(
      color: AppColors.primaryColor,
      size: 60.r,
    ),
  );

  Widget _error() => Center(
    child: SvgPicture.asset(AppIcons.logoText),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File?>(
      future: VideoThumbCache.get(videoUrl), // ✅ كاش
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return _loading(context);
        }
        if (snap.hasError) return _error();

        final file = snap.data;
        if (file == null) return _error();

        return Image.file(
          file,
          fit: fit,
          errorBuilder: (_, __, ___) => _error(),
        );
      },
    );
  }
}


class VideoThumbCache {
  VideoThumbCache._();

  static final Map<String, Future<File?>> _cache = {};

  static Future<File?> get(String videoUrl) {
    // ✅ لو موجودة قبل، رجّع نفس الـ Future (بدون إعادة توليد)
    return _cache.putIfAbsent(videoUrl, () => _generate(videoUrl));
  }

  static Future<File?> _generate(String videoUrl) async {
    try {
      final dir = await getTemporaryDirectory();
      final path = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: dir.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
        maxHeight: 300,
      );
      if (path == null) return null;
      return File(path);
    } catch (_) {
      return null;
    }
  }

  // اختياري: تفريغ الكاش
  static void clear() => _cache.clear();
}
