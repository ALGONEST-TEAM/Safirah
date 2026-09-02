import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../data/model/match_lineups_model.dart';

class MatchLineupsPlayersListWidget extends StatelessWidget {
  final String title;
  final List<MatchLineupPlayerModel> players;
  final bool showHomeTeam;

  const MatchLineupsPlayersListWidget({
    super.key,
    required this.title,
    required this.players,
    required this.showHomeTeam,
  });

  Color _ratingColor(double r) {
    if (r >= 8.0) return const Color(0xff1877F2);
    if (r >= 7.0) return const Color(0xff4caf50);
    if (r >= 6.0) return const Color(0xffe8a838);
    return const Color(0xffff6b35);
  }

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: AutoSizeTextWidget(
              text: title,
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              colorText: AppColors.mainColorFont,
            ),
          ),
          const Divider(height: 1, color: Color(0xfff0eef6)),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: players.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Color(0xfff5f3f9)),
            itemBuilder: (context, index) {
              final player = players[index];
              final double ratingVal = player.rating ?? 0.0;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Player photo or jersey number
                        Container(
                          width: 32.r,
                          height: 32.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greySwatch.shade100,
                            border: Border.all(
                                color: AppColors.greySwatch.shade200, width: 1),
                          ),
                          clipBehavior: Clip.antiAlias,
                          alignment: Alignment.center,
                          child: player.image.isNotEmpty
                              ? OnlineImagesWidget(
                                  imageUrl: player.image,
                                  size: Size(32.r, 32.r),
                                  fit: BoxFit.cover,
                                )
                              : AutoSizeTextWidget(
                                  text: '${player.jerseyNumber}',
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w800,
                                  colorText: AppColors.mainColorFont,
                                ),
                        ),
                        10.w.horizontalSpace,

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AutoSizeTextWidget(
                                  text: player.commonName.isNotEmpty
                                      ? player.commonName
                                      : player.name,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  colorText: AppColors.mainColorFont,
                                ),
                                if (player.captain) ...[
                                  4.w.horizontalSpace,
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 1.h),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffe8c53a),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: AutoSizeTextWidget(
                                      text: 'C',
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w900,
                                      colorText: Colors.white,
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
                              fontSize: 9.5.sp,
                              fontWeight: FontWeight.w500,
                              colorText: AppColors.fontColor3,
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (ratingVal > 0.0)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: _ratingColor(ratingVal),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: AutoSizeTextWidget(
                          text: ratingVal.toStringAsFixed(1),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                          colorText: Colors.white,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
