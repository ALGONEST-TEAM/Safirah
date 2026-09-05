import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../data/model/match_details_model.dart';
import 'match_header_button_widget.dart';
import 'match_header_background_widget.dart';
import 'match_header_title_widget.dart';
import 'match_header_score_widget.dart';
import '../../pages/team_matches_page.dart';

class MatchDetailsHeaderContentWidget extends StatefulWidget {
  final MatchDetailsModel matchDetails;
  final Color rightGlowColor;
  final Color leftGlowColor;

  const MatchDetailsHeaderContentWidget({
    super.key,
    required this.matchDetails,
    required this.rightGlowColor,
    required this.leftGlowColor,
  });

  @override
  State<MatchDetailsHeaderContentWidget> createState() =>
      _MatchDetailsHeaderContentWidgetState();
}

class _MatchDetailsHeaderContentWidgetState
    extends State<MatchDetailsHeaderContentWidget> {
  // ═══════════════════════════════════════════════════════════════════════════
  // CACHED CHILD WIDGETS
  //
  // These are the EXPENSIVE widgets that should NOT be rebuilt on every scroll
  // frame. By storing them as fields, Flutter's element reconciliation detects
  // the same widget identity (child.widget == newWidget → true) and COMPLETELY
  // SKIPS the entire subtree diff for each cached widget.
  //
  // They are only rebuilt when actual match data or team colors change
  // (via didUpdateWidget).
  // ═══════════════════════════════════════════════════════════════════════════
  late Widget _homeLogoImage;
  late Widget _awayLogoImage;
  late Widget _homeNameText;
  late Widget _awayNameText;
  late Widget _titleBar;
  late Widget _backButton;

  @override
  void initState() {
    super.initState();
    _rebuildCachedChildren();
  }

  @override
  void didUpdateWidget(covariant MatchDetailsHeaderContentWidget old) {
    super.didUpdateWidget(old);
    // Only rebuild expensive children when actual DATA changes,
    // NOT on every scroll frame.
    if (!identical(old.matchDetails, widget.matchDetails) ||
        old.rightGlowColor != widget.rightGlowColor ||
        old.leftGlowColor != widget.leftGlowColor) {
      _rebuildCachedChildren();
    }
  }

  void _rebuildCachedChildren() {
    final md = widget.matchDetails;

    // ── Logo images at FIXED max size (55.w) ────────────────────────────
    // During scroll, Transform.scale visually resizes them WITHOUT
    // triggering layout recalculation for the CachedNetworkImage subtree.
    // RepaintBoundary promotes them to separate GPU layers.
    _homeLogoImage = GestureDetector(
      onTap: () {
       // final teamId = md.teams?.home?.teamId ?? md.teams?.home?.id ?? 0;
         final teamId = md.teams?.home?.sportmonksId;
        if (teamId != 0) {
          navigateTo(
              context,
              TeamMatchesPage(
                teamId: teamId!,
              ));
        }
      },
      child: RepaintBoundary(
        child: OnlineImagesWidget(
          imageUrl: md.teams?.home?.logo ?? '',
          size: Size(55.w, 55.w),
          backgroundColor: Colors.transparent,
          fit: BoxFit.contain,
        ),
      ),
    );

    _awayLogoImage = GestureDetector(
      onTap: () {
        final teamId = md.teams?.away?.sportmonksId ;
        print(teamId);

        if (teamId != 0) {
          navigateTo(
            context,
            TeamMatchesPage(
              teamId: teamId!,
            ),
          );
        }
      },
      child: RepaintBoundary(
        child: OnlineImagesWidget(
          imageUrl: md.teams?.away?.logo ?? '',
          size: Size(55.w, 55.w),
          backgroundColor: Colors.transparent,
          fit: BoxFit.contain,
        ),
      ),
    );

    // ── Name texts ──────────────────────────────────────────────────────
    // Cached to avoid AutoSizeText binary-search layout per frame.
    _homeNameText = SizedBox(
      height: 28.h,
      child: AutoSizeTextWidget(
        text: md.teams?.home?.name ?? '',
        fontSize: 10.sp,
        minFontSize: 8,
        maxLines: 2,
        fontWeight: FontWeight.w700,
        colorText: AppColors.mainColorFont,
        textAlign: TextAlign.center,
      ),
    );

    _awayNameText = SizedBox(
      height: 28.h,
      child: AutoSizeTextWidget(
        text: md.teams?.away?.name ?? '',
        fontSize: 10.sp,
        minFontSize: 8,
        maxLines: 2,
        fontWeight: FontWeight.w700,
        colorText: AppColors.mainColorFont,
        textAlign: TextAlign.center,
      ),
    );

    // ── Title bar ───────────────────────────────────────────────────────
    _titleBar = MatchHeaderTitleWidget(
      matchDetails: md,
      leagueName: md.competition?.name ?? '',
      onBackTap: () => Navigator.of(context).pop(),
    );

    // ── Back button ─────────────────────────────────────────────────────
    _backButton = MatchHeaderButtonWidget(
      icon: Icon(
        Icons.arrow_back_ios_new,
        size: 16.sp,
        color: AppColors.mainColorFont,
      ),
      onTap: () => Navigator.of(context).pop(),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Helper: Builds a logo column using CACHED image + CACHED name text.
  // Only the lightweight wrappers (Transform.scale, Opacity) change per frame.
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildLogoColumn({
    required Widget logoImage,
    required Widget nameText,
    required double scaleRatio,
    required double nameOpacity,
    required double logoBoxWidth,
  }) {
    return SizedBox(
      width: logoBoxWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image: visually scaled via Transform (no layout recalculation).
          // Child is a cached widget → subtree SKIPPED by Flutter.
          Transform.scale(
            scale: scaleRatio,
            alignment: Alignment.topCenter,
            child: logoImage,
          ),
          // Name: conditionally shown + faded via Opacity.
          // Child is a cached widget → subtree SKIPPED by Flutter.
          if (nameOpacity > 0.01) ...[
            4.h.verticalSpace,
            Opacity(
              opacity: nameOpacity.clamp(0.0, 1.0),
              child: nameText,
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final statusBarHeight = mediaQuery.padding.top;
    final screenWidth = mediaQuery.size.width;

    final bool isNotStarted = widget.matchDetails.status == '1' ||
        widget.matchDetails.status == '13' ||
        widget.matchDetails.status == '26' ||
        widget.matchDetails.state?.code == 'NS';

    final double logoBoxWidth = 90.w;
    final double maxLogoSize = 55.w;
    final double minLogoSize = 24.w;

    return LayoutBuilder(
      builder: (context, constraints) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final double expandRatio = settings != null
            ? ((settings.currentExtent - settings.minExtent) /
                    (settings.maxExtent - settings.minExtent))
                .clamp(0.0, 1.0)
            : 1.0;

        // ── Animation values (cheap math, no widget creation) ─────────
        final double scaleRatio = lerpDouble(
          minLogoSize / maxLogoSize, // ≈ 0.436
          1.0,
          expandRatio,
        )!;
        // Visual logo size for position calculations (identical to original)
        final double visualLogoSize = maxLogoSize * scaleRatio;
        final double scoreFontSize = lerpDouble(16.sp, 20.sp, expandRatio)!;

        // ── Position calculations (identical to original) ─────────────
        final double expandedLeftCenter = 16.w + (screenWidth - 132.w) * 0.25;
        final double expandedRightCenter =
            screenWidth - (16.w + (screenWidth - 132.w) * 0.25);
        final double expandedLogoY = statusBarHeight + 61.h;

        final double collapsedLeftCenter = screenWidth * 0.5 - 55.w;
        final double collapsedRightCenter = screenWidth * 0.5 + 55.w;
        final double collapsedLogoY =
            statusBarHeight + (42.h - visualLogoSize) / 2;

        final double logoY =
            lerpDouble(collapsedLogoY, expandedLogoY, expandRatio)!;
        final double rightCenter =
            lerpDouble(collapsedRightCenter, expandedRightCenter, expandRatio)!;
        final double leftCenter =
            lerpDouble(collapsedLeftCenter, expandedLeftCenter, expandRatio)!;

        final double scoreY = lerpDouble(
          statusBarHeight + (42.h - scoreFontSize * 1.5) / 2,
          expandedLogoY + 10.h,
          expandRatio,
        )!;

        final double textOpacity = expandRatio;

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ── LAYER 0: BACKGROUND GLOW ────────────────────────────
              // Not cached — needs expandRatio for dynamic gradient.
              // Relatively cheap (2 gradient containers).
              MatchHeaderBackgroundWidget(
                expandRatio: expandRatio,
                leftGlowColor: widget.leftGlowColor,
                rightGlowColor: widget.rightGlowColor,
              ),

              // ── LAYER 1: TITLE & HEADER TOP BAR ─────────────────────
              // _titleBar is CACHED → subtree completely skipped.
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: expandRatio,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        16.w, statusBarHeight + 10.h, 16.w, 0),
                    child: _titleBar,
                  ),
                ),
              ),

              // ── LAYER 2: COLLAPSED BACK BUTTON ──────────────────────
              // _backButton is CACHED → subtree completely skipped.
              if (expandRatio < 1.0)
                Positioned(
                  right: 16.w,
                  top: statusBarHeight + (42.h - 36.r) / 2,
                  child: Opacity(
                    opacity: 1 - expandRatio,
                    child: _backButton,
                  ),
                ),

              // ── LAYER 3: HOME LOGO (right side in RTL) ──────────────
              // _homeLogoImage & _homeNameText are CACHED.
              // Only Transform.scale & Opacity wrappers change per frame.
              Positioned(
                left: rightCenter - (logoBoxWidth / 2),
                top: logoY,
                width: logoBoxWidth,
                child: _buildLogoColumn(
                  logoImage: _homeLogoImage,
                  nameText: _homeNameText,
                  scaleRatio: scaleRatio,
                  nameOpacity: textOpacity,
                  logoBoxWidth: logoBoxWidth,
                ),
              ),

              // ── LAYER 4: AWAY LOGO (left side in RTL) ───────────────
              // _awayLogoImage & _awayNameText are CACHED.
              Positioned(
                left: leftCenter - (logoBoxWidth / 2),
                top: logoY,
                width: logoBoxWidth,
                child: _buildLogoColumn(
                  logoImage: _awayLogoImage,
                  nameText: _awayNameText,
                  scaleRatio: scaleRatio,
                  nameOpacity: textOpacity,
                  logoBoxWidth: logoBoxWidth,
                ),
              ),

              // ── LAYER 5: SCORE / COUNTDOWN ──────────────────────────
              // Not cached — needs expandRatio for internal animation
              // (live timer fade, spacing). Still rebuilt every frame but
              // is a relatively small widget tree.
              Positioned(
                top: scoreY,
                left: screenWidth / 2 - 50.w,
                right: screenWidth / 2 - 50.w,
                child: MatchHeaderScoreWidget(
                  homeScore: widget.matchDetails.score?.home ?? 0,
                  awayScore: widget.matchDetails.score?.away ?? 0,
                  isNotStarted: isNotStarted,
                  scoreFontSize: scoreFontSize,
                  expandRatio: expandRatio,
                  matchTimeState: widget.matchDetails.state?.name ?? '',
                  matchDate: widget.matchDetails.date,
                  matchTime: widget.matchDetails.time,
                  status: widget.matchDetails.state?.id ??
                      num.tryParse(widget.matchDetails.status ?? ''),
                  minute: widget.matchDetails.minute,
                  second: widget.matchDetails.second,
                  ticking: widget.matchDetails.ticking,
                  timeAdded: widget.matchDetails.timeAdded,
                  lastGoalSide: widget.matchDetails.lastGoalSide,
                  lastGoalTime: widget.matchDetails.lastGoalTime,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
