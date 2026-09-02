import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../data/model/match_lineups_model.dart';

class MatchLineupsSubbedPlayerRowWidget extends StatelessWidget {
  final MatchLineupPlayerModel playerIn;
  final String outName;
  final int outNumber;
  final int minute;

  const MatchLineupsSubbedPlayerRowWidget({
    super.key,
    required this.playerIn,
    required this.outName,
    required this.outNumber,
    required this.minute,
  });

  Color _ratingColor(double r) {
    if (r >= 8.0) return const Color(0xff1877F2); // Blue for excellent
    if (r >= 7.0) return const Color(0xff4caf50); // Green for good
    if (r >= 6.0) return const Color(0xffe8a838); // Amber
    if (r > 0) return const Color(0xffff6b35); // Orange-red
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          // Avatar Image
          Container(
            width: 38.r,
            height: 38.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.greySwatch.shade100,
              border: Border.all(color: const Color(0xff5BB849), width: 1.5),
            ),
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            child: playerIn.image.isNotEmpty
                ? OnlineImagesWidget(
                    imageUrl: playerIn.image,
                    size: Size(38.r, 38.r),
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.person, size: 24.r, color: AppColors.fontColor3),
          ),
          16.w.horizontalSpace,

          // Players Info Column (Green for IN, Red for OUT)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Player IN (Green)
                Row(
                  children: [
                    if (playerIn.jerseyNumber > 0) ...[
                      AutoSizeTextWidget(
                        text: '${playerIn.jerseyNumber}',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        colorText: AppColors.mainColorFont,
                      ),
                      if (playerIn.captain) ...[
                        4.w.horizontalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: const Color(0xffe8c53a),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: AutoSizeTextWidget(
                            text: 'C',
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w900,
                            colorText: Colors.white,
                          ),
                        ),
                      ],
                      10.w.horizontalSpace,
                    ],
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: playerIn.commonName.isNotEmpty
                            ? playerIn.commonName
                            : playerIn.name,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        colorText: const Color(0xff5BB849), // Green
                        maxLines: 1,
                      ),
                    ),
                    if (playerIn.goalsCount > 0) ...[
                      4.w.horizontalSpace,
                      Icon(Icons.sports_soccer, size: 13.sp, color: Colors.black87),
                      if (playerIn.goalsCount > 1) ...[
                        2.w.horizontalSpace,
                        AutoSizeTextWidget(
                          text: '${playerIn.goalsCount}',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          colorText: Colors.black87,
                        ),
                      ],
                    ],
                    if (playerIn.assistsCount > 0) ...[
                      4.w.horizontalSpace,
                      SvgPicture.asset(
                        AppIcons.assist,
                        width: 12.r,
                        height: 12.r,
                      ),
                      if (playerIn.assistsCount > 1) ...[
                        2.w.horizontalSpace,
                        AutoSizeTextWidget(
                          text: '${playerIn.assistsCount}',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          colorText: Colors.black87,
                        ),
                      ],
                    ],
                    if (playerIn.yellowCardsCount > 0 || playerIn.redCardsCount > 0) ...[
                      4.w.horizontalSpace,
                      Container(
                        width: 8.r,
                        height: 11.r,
                        decoration: BoxDecoration(
                          color: playerIn.redCardsCount > 0 ? const Color(0xffef4444) : const Color(0xffeab308),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ],
                    if (playerIn.rating != null && playerIn.rating! > 0) ...[
                      6.w.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                        decoration: BoxDecoration(
                          color: _ratingColor(playerIn.rating!),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: AutoSizeTextWidget(
                          text: playerIn.rating == 100 ? '100' : playerIn.rating!.toStringAsFixed(1),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          colorText: Colors.white,
                        ),
                      ),
                    ],
                  ],
                ),
                if (outName.isNotEmpty) ...[
                  3.h.verticalSpace,
                  // Player OUT (Red)
                  Row(
                    children: [
                      if (outNumber > 0) ...[
                        AutoSizeTextWidget(
                          text: '$outNumber',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          colorText: AppColors.mainColorFont,
                        ),
                        10.w.horizontalSpace,
                      ],
                      Flexible(
                        child: AutoSizeTextWidget(
                          text: outName,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          colorText: const Color(0xffFF495C), // Red
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          12.w.horizontalSpace,

          // Minute + Substitution SVG Icon
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.substitutionInMatch,
                width: 20.r,
                height: 20.r,
              ),
              2.h.verticalSpace,
              AutoSizeTextWidget(
                text: "$minute'",
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w800,
                colorText: AppColors.mainColorFont,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
