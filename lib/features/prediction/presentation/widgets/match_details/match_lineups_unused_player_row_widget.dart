import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../data/model/match_lineups_model.dart';

class MatchLineupsUnusedPlayerRowWidget extends StatelessWidget {
  final MatchLineupPlayerModel player;

  const MatchLineupsUnusedPlayerRowWidget({
    super.key,
    required this.player,
  });

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
              border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            child: player.image.isNotEmpty
                ? OnlineImagesWidget(
                    imageUrl: player.image,
                    size: Size(38.r, 38.r),
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.person, size: 24.r, color: AppColors.fontColor3),
          ),
          16.w.horizontalSpace,

          // Player Name & Position
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (player.jerseyNumber > 0) ...[
                    AutoSizeTextWidget(
                      text: '${player.jerseyNumber}',
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w700,
                      colorText: AppColors.mainColorFont,
                    ),
                    if (player.captain) ...[
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
                    12.w.horizontalSpace,
                  ],
                  AutoSizeTextWidget(
                    text: player.commonName.isNotEmpty
                        ? player.commonName
                        : player.name,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    colorText: AppColors.mainColorFont,
                  ),
                  if (player.goalsCount > 0) ...[
                    4.w.horizontalSpace,
                    Icon(Icons.sports_soccer, size: 13.sp, color: Colors.black87),
                    if (player.goalsCount > 1) ...[
                      2.w.horizontalSpace,
                      AutoSizeTextWidget(
                        text: '${player.goalsCount}',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        colorText: Colors.black87,
                      ),
                    ],
                  ],
                  if (player.assistsCount > 0) ...[
                    4.w.horizontalSpace,
                    SvgPicture.asset(
                      AppIcons.assist,
                      width: 12.r,
                      height: 12.r,
                    ),
                    if (player.assistsCount > 1) ...[
                      2.w.horizontalSpace,
                      AutoSizeTextWidget(
                        text: '${player.assistsCount}',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        colorText: Colors.black87,
                      ),
                    ],
                  ],
                  if (player.yellowCardsCount > 0 || player.redCardsCount > 0) ...[
                    4.w.horizontalSpace,
                    Container(
                      width: 8.r,
                      height: 11.r,
                      decoration: BoxDecoration(
                        color: player.redCardsCount > 0 ? const Color(0xffef4444) : const Color(0xffeab308),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ],
                ],
              ),
              2.h.verticalSpace,
              AutoSizeTextWidget(
                text: player.positionLabel.isNotEmpty
                    ? player.positionLabel
                    : player.shortPositionCategory,
                fontSize: 10.5.sp,
                colorText: AppColors.fontColor2,
              ),
            ],
          ),

          const Spacer(),

          // Rating Badge if exists
          if (player.rating != null && player.rating! > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: _ratingColor(player.rating!),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: AutoSizeTextWidget(
                text: player.rating!.toStringAsFixed(1),
                fontSize: 9.5.sp,
                fontWeight: FontWeight.w700,
                colorText: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  Color _ratingColor(double r) {
    if (r >= 8.0) return const Color(0xff1877F2);
    if (r >= 7.0) return const Color(0xff4caf50);
    if (r >= 6.0) return const Color(0xffe8a838);
    return const Color(0xffff6b35);
  }
}
