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
    return Container(
      height: size?.height,
      width: size?.width,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        image: const DecorationImage(
          image: AssetImage('assets/images/logo.jpg'),
          fit: BoxFit.contain,
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

    return CachedNetworkImage(
      imageUrl: normalized,
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
        final image = DecorationImage(
          image: imageProvider,
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
                      backgroundImage: imageProvider,
                      radius: circularRadius ?? 35.sp,
                      backgroundColor: Colors.transparent,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        image: image,
                        color: backgroundColor ?? Colors.transparent,
                        borderRadius:
                            BorderRadius.circular(borderRadius ?? 8.r),
                      ),
                      height: size?.height,
                      width: size?.width,
                    ),
            ],
          ),
        );
      },
      errorWidget: (context, url, error) => _fallback(),
    );
  }
}
