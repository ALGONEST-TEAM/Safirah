import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/team_color_helper.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_details_model.dart';

class MatchEventsBestPlayerWidget extends StatelessWidget {
  final MatchBestPlayerModel? bestPlayer;
  final String? teamName;
  final String? teamLogo;
  final Color? teamColor;

  const MatchEventsBestPlayerWidget({
    super.key,
    this.bestPlayer,
    this.teamName,
    this.teamLogo,
    this.teamColor,
  });

  @override
  Widget build(BuildContext context) {
    if (bestPlayer == null) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header matching MatchEventsKeyStatsWidget exactly
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: AutoSizeTextWidget(
              text: 'أفضل لاعب',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              colorText: AppColors.fontColor,
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(height: 1, color: Color(0xfff5f3f9)),

          // Player info row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: _PlayerInfoRowWidget(
              bestPlayer: bestPlayer!,
              teamName: teamName,
              teamLogo: teamLogo,
              teamColor: teamColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Player info row ───────────────────────────────────────────────────────────
class _PlayerInfoRowWidget extends StatelessWidget {
  final MatchBestPlayerModel bestPlayer;
  final String? teamName;
  final String? teamLogo;
  final Color? teamColor;

  const _PlayerInfoRowWidget({
    required this.bestPlayer,
    this.teamName,
    this.teamLogo,
    this.teamColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42.r,
          height: 42.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.greySwatch.shade200,
            border: Border.all(color: AppColors.greySwatch.shade300, width: 1),
          ),
          child: ClipOval(
            child: bestPlayer.image.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: bestPlayer.image,
                    fit: BoxFit.cover,
                  )
                : Icon(
                    Icons.person,
                    size: 26.r,
                    color: AppColors.fontColor2,
                  ),
          ),
        ),

        12.w.horizontalSpace,

        // Player name + team (right-aligned in RTL)
        _PlayerNameTeamWidget(
          playerName: bestPlayer.name.isNotEmpty ? bestPlayer.name : 'غير متوفر',
          teamName: teamName ?? '',
          teamLogo: teamLogo,
        ),
        const Spacer(),
        // Rating Badge using team color matching stat pills
        _RatingBadgeWidget(
          rating: bestPlayer.rating,
          teamColor: teamColor,
        ),
      ],
    );
  }
}

// ── Rating badge ──────────────────────────────────────────────────────────────
class _RatingBadgeWidget extends StatelessWidget {
  final double rating;
  final Color? teamColor;

  const _RatingBadgeWidget({
    required this.rating,
    this.teamColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = teamColor ?? const Color(0xff14A0FF);
    final Color textColor = TeamColorHelper.getTextColor(bgColor);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
        border: bgColor.computeLuminance() > 0.75
            ? Border.all(color: AppColors.greySwatch.shade300, width: 1)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeTextWidget(
            text: rating.toStringAsFixed(1),
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
            colorText: textColor,
          ),
          4.w.horizontalSpace,
          Icon(Icons.star_rounded, color: textColor, size: 14.sp),
        ],
      ),
    );
  }
}

// ── Player name + team ────────────────────────────────────────────────────────
class _PlayerNameTeamWidget extends StatelessWidget {
  final String playerName;
  final String teamName;
  final String? teamLogo;

  const _PlayerNameTeamWidget({
    required this.playerName,
    required this.teamName,
    this.teamLogo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: playerName,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          colorText: AppColors.fontColor,
        ),
        2.h.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (teamLogo != null && teamLogo!.isNotEmpty)
              Container(
                width: 18.r,
                height: 18.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                alignment: Alignment.center,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: teamLogo!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                width: 18.r,
                height: 18.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff004d98),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.shield,
                    size: 10.sp, color: const Color(0xffa50044)),
              ),
            4.w.horizontalSpace,

            if (teamName.isNotEmpty)
              AutoSizeTextWidget(
                text: teamName,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                colorText: AppColors.fontColor,
              ),
          ],
        ),
      ],
    );
  }
}
