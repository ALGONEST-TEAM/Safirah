import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../data/model/match_lineups_model.dart';

class MatchLineupsPlayerOnPitchWidget extends StatelessWidget {
  final MatchLineupPlayerModel player;
  final bool showHomeTeam;

  const MatchLineupsPlayerOnPitchWidget({
    super.key,
    required this.player,
    required this.showHomeTeam,
  });

  Color _ratingColor(double r) {
    if (r >= 8.0) return const Color(0xff1877F2); // Blue for excellent
    if (r >= 7.0) return const Color(0xff4caf50); // Green for good
    if (r >= 6.0) return const Color(0xffe8a838); // Amber
    if (r > 0) return const Color(0xffff6b35); // Orange-red
    return Colors.transparent;
  }

  String get _displayName {
    if (player.commonName.trim().isNotEmpty) {
      return player.commonName.trim();
    }
    return player.name.trim();
  }

  @override
  Widget build(BuildContext context) {
    final double ratingVal = player.rating ?? 0.0;
    final ratingColor = _ratingColor(ratingVal);
    final hasRating = ratingVal > 0;

    final bool hasGoal = player.goalsCount > 0;
    final bool hasAssist = player.assistsCount > 0;
    final bool hasYellowCard = player.yellowCardsCount > 0;
    final bool hasRedCard = player.redCardsCount > 0;
    final bool isSubbed = player.substitutionEvents.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Photo circle + event badges
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // 1. Original Circular Player Photo Avatar
            Container(
              width: 46.r,
              height: 46.r,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: ClipOval(
                child: player.image.isNotEmpty
                    ? OnlineImagesWidget(
                        imageUrl: player.image,
                        size: Size(46.r, 46.r),
                        fit: BoxFit.cover,
                      )
                    : _PlayerAvatar(player: player, showHomeTeam: showHomeTeam),
              ),
            ),

            // 1. Top-Left Pill: Compact Captain badge ('C') + Jersey Number
            Positioned(
              top: -8.r,
              left: -8.r,
              child: Container(
                constraints: BoxConstraints(
                  minWidth: player.captain ? 28.r : 18.r,
                  minHeight: 18.r,
                ),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color(0xFFBDBDBD), width: 1),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (player.captain) ...[
                      Container(
                        width: 12.r,
                        height: 12.r,
                        decoration: const BoxDecoration(
                          color: Color(0xffe8a838), // Golden circle
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: AutoSizeTextWidget(
                          text: 'C',
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w900,
                          colorText: Colors.black,
                        ),
                      ),
                      2.5.w.horizontalSpace,
                    ],
                    AutoSizeTextWidget(
                      text: '${player.jerseyNumber}',
                      fontSize: 9.5.sp,
                      fontWeight: FontWeight.w800,
                      colorText: Colors.black,
                    ),
                  ],
                ),
              ),
            ),

            // 2. Top-Right Pill: Goal Icon + Goals Count (if any)
            if (hasGoal)
              Positioned(
                top: -8.r,
                right: -10.r,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: const Color(0xFFBDBDBD), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.sports_soccer, size: 10.5.sp, color: Colors.black),
                      2.5.w.horizontalSpace,
                      AutoSizeTextWidget(
                        text: '${player.goalsCount}',
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w800,
                        colorText: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),

            // 3. Left Middle: Raised Subbed-Out Red Arrow Circle (if Subbed)
            if (isSubbed)
              Positioned(
                top: 12.r,
                left: -10.r,
                child: Container(
                  width: 15.r,
                  height: 15.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFBDBDBD), width: 1),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    size: 9.5.sp,
                    color: const Color(0xffef4444),
                  ),
                ),
              ),

            // 4. Right Middle: Assist Shoe Icon Circle (if Assist)
            if (hasAssist)
              Positioned(
                top: 12.r,
                right: -12.r,
                child: Container(
                  width: 18.r,
                  height: 18.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFBDBDBD), width: 1),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AppIcons.assist,
                    width: 11.r,
                    height: 11.r,
                  ),
                ),
              ),

            // Yellow / Red Card Badge (Positioned professionally under Assist, Red priority)
            if (hasRedCard || hasYellowCard)
              Positioned(
                top: hasAssist ? 32.r : 16.r,
                right: -8.r,
                child: Container(
                  width: 8.r,
                  height: 11.r,
                  decoration: BoxDecoration(
                    color: hasRedCard ? const Color(0xffef4444) : const Color(0xffeab308),
                    borderRadius: BorderRadius.circular(2.r),
                    border: Border.all(color: Colors.white, width: 1),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 1.5),
                    ],
                  ),
                ),
              ),

            // 5. Bottom-Left: Compact Rating Pill
            if (hasRating)
              Positioned(
                bottom: -1.r,
                left: -8.r,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
                  decoration: BoxDecoration(
                    color: ratingColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeTextWidget(
                    text: ratingVal == 100 ? '100' : ratingVal.toStringAsFixed(1),
                    fontSize: 7.5.sp,
                    fontWeight: FontWeight.w700,
                    colorText: Colors.white,
                  ),
                ),
              ),
          ],
        ),

        // ONLY the Player Name underneath
        SizedBox(height: 5.r),
        Text(
          _displayName,
          style: TextStyle(
            fontFamily: 'IBMPlexSansArabic',
            fontSize: 9.5.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            shadows: const [
              Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(0, 1)),
            ],
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}

class _PlayerAvatar extends StatelessWidget {
  final MatchLineupPlayerModel player;
  final bool showHomeTeam;

  const _PlayerAvatar({required this.player, required this.showHomeTeam});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: showHomeTeam ? AppColors.secondaryColor : const Color(0xff3B2671),
      alignment: Alignment.center,
      child: Text(
        '${player.jerseyNumber}',
        style: TextStyle(
          fontFamily: 'IBMPlexSansArabic',
          fontSize: 13.sp,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }
}
