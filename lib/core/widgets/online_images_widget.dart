import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_icons.dart';
import '../theme/app_colors.dart';

class OnlineImagesWidget extends StatelessWidget {
  final String imageUrl;
  final bool circularImage;
  final double? circularRadius;
  final bool hasShadow;
  final Size? size;
  final BoxFit? fit;
  final double? logoWidth;
  final double? borderRadius;

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
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, value) {
        return Container(
          height: size?.height,
          width: size?.width,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          ),
          child: SpinKitPulse(
            color: AppColors.primaryColor,
            size: 20.r,
          ),
        );
      },
      imageBuilder: (context, imageProvider) {
        var image = DecorationImage(
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
                    )
                  : Container(
                      decoration: BoxDecoration(
                        image: image,
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
      errorWidget: (context, url, error) => Container(
        height: size?.height,
        width: size?.width,
        decoration: BoxDecoration(
          color: AppColors.greySwatch.shade50,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        ),
        child: Center(
          child: SvgPicture.asset(
            AppIcons.logo,
            width: logoWidth ?? 50.w,
          ),
        ),
      ),
    );
  }
}
