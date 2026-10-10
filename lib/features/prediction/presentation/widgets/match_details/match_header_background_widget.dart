import 'package:flutter/material.dart';

class MatchHeaderBackgroundWidget extends StatelessWidget {
  final double expandRatio;
  final Color leftGlowColor;
  final Color rightGlowColor;

  const MatchHeaderBackgroundWidget({
    super.key,
    required this.expandRatio,
    required this.leftGlowColor,
    required this.rightGlowColor,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamic radius: 
    // When expanded (ratio=1), radius is 1.5 for a soft large glow.
    // When collapsed (ratio=0), height is small (42.h), so we increase radius to 6.0 
    // to make the colors spread horizontally and meet beautifully in the middle.
    final double dynamicRadius = 6.0 - (4.5 * expandRatio);
    
    // The user requested lighter colors (less intense depth) to match the previous soft aesthetic.
    // Expanded = 0.3 alpha. Collapsed = 0.2 alpha.
    final double glowAlpha = 0.2 + (0.1 * expandRatio);

    return Positioned.fill(
      child: RepaintBoundary(
        child: Stack(
          children: [
            // Left Radial Gradient (Away Team)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: dynamicRadius,
                    colors: [
                      leftGlowColor.withValues(alpha: glowAlpha),
                      Colors.white.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            // Right Radial Gradient (Home Team)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.bottomRight,
                    radius: dynamicRadius,
                    colors: [
                      rightGlowColor.withValues(alpha: glowAlpha),
                      Colors.white.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
