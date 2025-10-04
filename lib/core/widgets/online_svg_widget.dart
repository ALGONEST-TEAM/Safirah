import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_icons.dart';
import '../theme/app_colors.dart';

class OnlineSvgWidget extends StatelessWidget {
  final String imageUrl;
  final Size? size;
  final BoxFit? fit;
  final double? logoWidth;
  final double? borderRadius;
  final Color? color;

  const OnlineSvgWidget({
    super.key,
    required this.imageUrl,
    this.size,
    this.fit,
    this.logoWidth,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkSVGImage(
      imageUrl,
      width: size?.width,
      height: size?.height,
      fit: fit ?? BoxFit.cover,
      color: color,
      placeholder: SpinKitPulse(
        color: AppColors.primaryColor,
        size: 18.r,
      ),
      errorWidget: SvgPicture.asset(
        AppIcons.error,
        color: color,
        width: size?.width,
        height: size?.height,
        fit: fit ?? BoxFit.cover,
      ),
    );
  }
}
