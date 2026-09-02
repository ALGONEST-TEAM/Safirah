import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';

class MatchTeamLogoWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double logoSize;
  final double fontSize;
  final double nameOpacity;
  final double? width;

  const MatchTeamLogoWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.logoSize,
    required this.fontSize,
    this.nameOpacity = 1.0,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OnlineImagesWidget(
            imageUrl: imageUrl,
            size: Size(logoSize, logoSize),
            backgroundColor: Colors.transparent,
            fit: BoxFit.contain,
          ),
          if (nameOpacity > 0.01) ...[
            4.h.verticalSpace,
            Opacity(
              opacity: nameOpacity.clamp(0.0, 1.0),
              child: SizedBox(
                height: 28.h,
                child: AutoSizeTextWidget(
                  text: name,
                  fontSize: fontSize,
                  minFontSize: 8,
                  maxLines: 2,
                  fontWeight: FontWeight.w700,
                  colorText: AppColors.mainColorFont,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
