import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../data/model/league_model.dart';

class LeagueCardImageWidget extends StatelessWidget {
  final LeagueModel leagueModel;
  final String fallbackImageUrl;

  const LeagueCardImageWidget({
    super.key,
    required this.leagueModel,
    required this.fallbackImageUrl,
  });

  bool get _hasLogoPath =>
      leagueModel.logoPath != null && leagueModel.logoPath!.isNotEmpty;

  bool get _isNetworkLogo =>
      _hasLogoPath &&
      (leagueModel.logoPath!.startsWith('http://') ||
          leagueModel.logoPath!.startsWith('https://'));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 6,
          child: _buildImage(),
        ),
        PositionedDirectional(
          top: 8.h,
          end: 8.w,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 3.h,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffDDE5FF),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: AutoSizeTextWidget(
              text: 'خاصة',
              fontSize: 7.sp,
              colorText: AppColors.fontColor,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (_isNetworkLogo) {
      return OnlineImagesWidget(
        imageUrl: leagueModel.logoPath!,
        fit: BoxFit.fill,
        size: Size(double.infinity, 114.h),
        borderRadius: 8.r,
      );
    }
    if (_hasLogoPath) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.file(
          File(leagueModel.logoPath!),
          fit: BoxFit.cover,
          width: double.infinity,
          height: 114.h,
        ),
      );
    }
    return OnlineImagesWidget(
      imageUrl: fallbackImageUrl,
      fit: BoxFit.cover,
      size: Size(double.infinity, 114.h),
      borderRadius: 8.r,
    );
  }
}
