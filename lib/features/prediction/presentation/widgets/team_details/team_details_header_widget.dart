import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/team_color_extractor.dart';
import '../../../data/model/team_matches_model.dart';
import '../match_details/match_header_button_widget.dart';
import 'team_header_triangle_glow_widget.dart';

class TeamDetailsHeaderWidget extends StatefulWidget {
  final TeamMatchTeamInfo teamInfo;
  final VoidCallback onBack;

  const TeamDetailsHeaderWidget({
    super.key,
    required this.teamInfo,
    required this.onBack,
  });

  @override
  State<TeamDetailsHeaderWidget> createState() => _TeamDetailsHeaderWidgetState();
}

class _TeamDetailsHeaderWidgetState extends State<TeamDetailsHeaderWidget> {
  Color? _extractedColor;

  @override
  void initState() {
    super.initState();
    _extractTeamColor();
  }

  @override
  void didUpdateWidget(covariant TeamDetailsHeaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.teamInfo.imagePath != widget.teamInfo.imagePath) {
      _extractTeamColor();
    }
  }

  void _extractTeamColor() async {
    final logoUrl = widget.teamInfo.imagePath;
    if (logoUrl.trim().isEmpty) return;

    final cached = TeamColorExtractor.getCachedColor(logoUrl);
    if (cached != null) {
      _extractedColor = cached;
      return;
    }

    final color = await TeamColorExtractor.extractColor(
      hexColor: null,
      logoUrl: logoUrl,
      defaultColor: AppColors.primaryColor,
    );

    if (mounted) {
      setState(() {
        _extractedColor = color;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final glowColor = _extractedColor ??
        TeamColorExtractor.getCachedColor(widget.teamInfo.imagePath) ??
        Colors.transparent;

    final mediaQuery = MediaQuery.of(context);
    final statusBarHeight = mediaQuery.padding.top;
    final screenWidth = mediaQuery.size.width;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    const double maxLogoSize = 68.0;
    const double minLogoSize = 28.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final double expandRatio = settings != null
            ? ((settings.currentExtent - settings.minExtent) /
                    (settings.maxExtent - settings.minExtent))
                .clamp(0.0, 1.0)
            : 1.0;

        final double collapseRatio = 1.0 - expandRatio;

        // 1. Back button position
        final double backBtnTop = statusBarHeight + 5.h;
        final double backBtnOffset = 12.w;

        // 2. Logo scaling & positioning
        final double logoScale = lerpDouble(1.0, minLogoSize / maxLogoSize, collapseRatio)!;

        // Name metrics (anchored 4.h from the bottom of the header in expanded state)
        final double nameBoxWidth = screenWidth - (backBtnOffset + 36.w + 8.w + minLogoSize.w + 24.w);
        const double nameBoxHeight = 22.0;

        final double expandedNameCenterX = screenWidth / 2;
        final double expandedNameCenterY = constraints.maxHeight - 4.h - (nameBoxHeight / 2);

        final double expandedLogoCenterX = screenWidth / 2;
        final double expandedLogoCenterY = expandedNameCenterY - (nameBoxHeight / 2) - 2.h - (maxLogoSize.h / 2);

        // Collapsed coordinates (beside back button in toolbar)
        final double collapsedLogoCenterX = isRtl
            ? screenWidth - (backBtnOffset + 36.w + 8.w + (minLogoSize.w / 2))
            : (backBtnOffset + 36.w + 8.w + (minLogoSize.w / 2));
        final double collapsedLogoCenterY = statusBarHeight + 5.h + (36.h / 2);

        final double currentLogoCenterX = lerpDouble(expandedLogoCenterX, collapsedLogoCenterX, collapseRatio)!;
        final double currentLogoCenterY = lerpDouble(expandedLogoCenterY, collapsedLogoCenterY, collapseRatio)!;

        final double collapsedNameCenterX = isRtl
            ? (collapsedLogoCenterX - (minLogoSize.w / 2) - 8.w - (nameBoxWidth / 2))
            : (collapsedLogoCenterX + (minLogoSize.w / 2) + 8.w + (nameBoxWidth / 2));
        final double collapsedNameCenterY = collapsedLogoCenterY;

        final double currentNameCenterX = lerpDouble(expandedNameCenterX, collapsedNameCenterX, collapseRatio)!;
        final double currentNameCenterY = lerpDouble(expandedNameCenterY, collapsedNameCenterY, collapseRatio)!;

        // Smoothly glide alignment from Center (0.0) to Right/Left (1.0 / -1.0)
        final double currentAlignX = lerpDouble(0.0, isRtl ? 1.0 : -1.0, collapseRatio)!;
        final double nameFontSize = lerpDouble(12.5.sp, 11.5.sp, collapseRatio)!;

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background Triangular Glow (scales down smoothly with expandRatio)
              TeamHeaderTriangleGlowWidget(
                glowColor: glowColor,
                expandRatio: expandRatio,
              ),

              // Back Button (Fixed in toolbar)
              Positioned(
                top: backBtnTop,
                left: isRtl ? null : backBtnOffset,
                right: isRtl ? backBtnOffset : null,
                child: MatchHeaderButtonWidget(
                  onTap: widget.onBack,
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 16.sp,
                    color: AppColors.mainColorFont,
                  ),
                ),
              ),

              // Team Logo (Smoothly slides and scales toward the back button)
              Positioned(
                left: currentLogoCenterX - (maxLogoSize.w / 2),
                top: currentLogoCenterY - (maxLogoSize.h / 2),
                width: maxLogoSize.w,
                height: maxLogoSize.h,
                child: Transform.scale(
                  scale: logoScale,
                  alignment: Alignment.center,
                  child: widget.teamInfo.imagePath.isEmpty
                      ? const SizedBox()
                      : CachedNetworkImage(
                          imageUrl: widget.teamInfo.imagePath,
                          fit: BoxFit.contain,
                        ),
                ),
              ),

              // Team Name (Smoothly slides and aligns beside the scaled logo)
              Positioned(
                left: currentNameCenterX - (nameBoxWidth / 2),
                top: currentNameCenterY - (nameBoxHeight / 2),
                width: nameBoxWidth,
                height: nameBoxHeight,
                child: Align(
                  alignment: Alignment(currentAlignX, 0.0),
                  child: AutoSizeTextWidget(
                    text: widget.teamInfo.name,
                    fontSize: nameFontSize,
                    fontWeight: FontWeight.w800,
                    colorText: AppColors.fontColor,
                    maxLines: 1,
                    minFontSize: 9,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
