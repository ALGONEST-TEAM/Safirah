import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../network/urls.dart';
import '../theme/app_colors.dart';
import 'offline_images_widget.dart';

class OnlineImagesWidget extends StatelessWidget {
  final String imageUrl;
  final bool circularImage;
  final double? circularRadius;
  final bool hasShadow;
  final Size? size;
  final BoxFit? fit;
  final double? logoWidth;
  final double? borderRadius;
  final Color? backgroundColor;

  const OnlineImagesWidget({
    super.key,
    required this.imageUrl,
    this.circularImage = false,
    this.circularRadius,
    this.hasShadow = false,
    this.size,
    this.fit,
    this.logoWidth,
    this.borderRadius,
    this.backgroundColor,
  });

  String? _normalizeUrl(String raw) {
    final url = raw.trim();
    if (url.isEmpty) return null;

    // Already absolute
    if (url.startsWith('http://') || url.startsWith('https://')) return url;

    // Protocol-relative
    if (url.startsWith('//')) return 'https:$url';

    // Relative path -> attach to API base domain
    final base = AppURL.base.replaceAll(RegExp(r"/+$"), '');
    final path = url.replaceAll(RegExp(r"^/+"), '');
    return '$base/$path';
  }

  Widget _fallback() {
    return SizedBox(
      height: size?.height,
      width: size?.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        child: ColoredBox(
          color: backgroundColor ?? Colors.white,
          child: Image.asset(
            'assets/images/logo.jpg',
            fit: BoxFit.contain,
            width: size?.width,
            height: size?.height,
            errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Local file path
    if (OfflineImagesWidget.isOfflinePath(imageUrl)) {
      return OfflineImagesWidget(
        path: imageUrl,
        circularImage: circularImage,
        circularRadius: circularRadius,
        size: size,
        fit: fit,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        fallback: _fallback(),
      );
    }

    // Network URL (absolute or relative)
    final normalized = _normalizeUrl(imageUrl);
    if (normalized == null) return _fallback();

    final int? cacheWidth =
        (size != null && size!.width.isFinite && size!.width > 0)
            ? (size!.width * 2.5).round().clamp(60, 500)
            : null;
    final int? cacheHeight =
        (size != null && size!.height.isFinite && size!.height > 0)
            ? (size!.height * 2.5).round().clamp(60, 500)
            : null;

    return CachedNetworkImage(
      imageUrl: normalized,
      memCacheWidth: cacheWidth,
      memCacheHeight: cacheHeight,
      fadeInDuration: const Duration(milliseconds: 150),
      fadeOutDuration: Duration.zero,
      placeholder: (context, value) {
        return Container(
          height: size?.height,
          width: size?.width,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.greySwatch.shade100,
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          ),
          child: SpinKitPulse(
            color: AppColors.primaryColor,
            size: 20.r,
          ),
        );
      },
      imageBuilder: (context, imageProvider) {
        // Use Image widget instead of DecorationImage for lifecycle-safe rendering.
        // Image widget properly unsubscribes from the ImageStream when disposed,
        // preventing "Decoded image has been disposed" crashes during fast scrolling.
        final double circularDiameter = (circularRadius ?? 35.sp) * 2;
        final double? imgWidth =
            size?.width ?? (circularImage ? circularDiameter : null);
        final double? imgHeight =
            size?.height ?? (circularImage ? circularDiameter : null);

        return SizedBox(
          height: imgHeight,
          width: imgWidth,
          child: circularImage
              ? ClipOval(
                  child: ColoredBox(
                    color: backgroundColor ?? Colors.transparent,
                    child: Image(
                      image: imageProvider,
                      fit: fit ?? BoxFit.cover,
                      width: imgWidth,
                      height: imgHeight,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius:
                      BorderRadius.circular(borderRadius ?? 8.r),
                  child: ColoredBox(
                    color: backgroundColor ?? Colors.transparent,
                    child: Image(
                      image: imageProvider,
                      fit: fit ?? BoxFit.cover,
                      width: imgWidth,
                      height: imgHeight,
                    ),
                  ),
                ),
        );
      },
      errorWidget: (context, url, error) => _fallback(),
    );
  }
}
