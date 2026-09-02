import 'package:flutter/material.dart';
import 'team_color_extractor.dart';

/// Professional helper class for managing team colors with subtle, high-end styling.
class TeamColorHelper {
  const TeamColorHelper._();

  /// Safely parses a hex color string or returns default fallback.
  static Color parseHex(String? hexColor, {required Color defaultColor}) {
    if (hexColor == null || hexColor.trim().isEmpty) return defaultColor;
    String hex = hexColor.replaceAll('#', '').replaceAll('0x', '').trim();
    if (hex.length == 6) hex = 'FF$hex';
    if (hex.length != 8) return defaultColor;
    final parsed = int.tryParse(hex, radix: 16);
    if (parsed == null || parsed == 0) return defaultColor;
    return Color(parsed);
  }

  /// Subtle, professional color touch that preserves 100% of the team's true color identity.
  static Color darkenForContrast(Color color) {
    final double luminance = color.computeLuminance();

    // Subtle touch (only 6%-10%) so colors retain their authentic hue
    if (luminance > 0.75) {
      return Color.lerp(color, const Color(0xFF0F172A), 0.08) ?? color;
    } else if (luminance > 0.45) {
      return Color.lerp(color, Colors.black, 0.06) ?? color;
    } else {
      return color;
    }
  }

  /// Calculates the ideal text color (dark charcoal or crisp white)
  /// ensuring 100% legibility on top of any solid background color.
  static Color getTextColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.60
        ? const Color(0xFF1F2937) // Dark charcoal for light team colors
        : Colors.white;            // Crisp white for dark team colors
  }

  /// Calculates a highly vibrant but readable text color to be used on white or light tint backgrounds.
  static Color getVibrantTextColor(Color teamColor) {
    // If the color is very bright (e.g., Yellow, Cyan), darken it so it's readable on white/light backgrounds.
    if (teamColor.computeLuminance() > 0.45) {
      return Color.lerp(teamColor, const Color(0xFF0F172A), 0.55) ?? teamColor;
    }
    return teamColor;
  }

  /// Returns a beautiful dark gradient from the base team color to a darker shade
  /// of the same color, providing a professional and premium aesthetic.
  static LinearGradient getDarkGradient(Color baseColor) {
    // Generate a darker shade of the base color by blending with black
    final Color darkerColor = Color.lerp(baseColor, Colors.black, 0.5) ?? Colors.black;
    return LinearGradient(
      colors: [baseColor, darkerColor],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    );
  }

  /// Resolves conflicts if home and away colors are too similar.
  /// Modifies the away color to ensure contrast.
  static Color resolveColorConflict(
    Color homeColor, 
    Color awayColor, 
    {
      String? awayLogo, 
      Color fallbackColor = const Color(0xFF6B7280) // Professional Grey
    }) {
    
    if (TeamColorExtractor.isClashing(homeColor, awayColor)) {
      // 1. Try to find a non-clashing alternative color from the away team's logo
      if (awayLogo != null) {
        final Color? alternativeColor = TeamColorExtractor.getAlternativeColor(awayLogo, homeColor);
        if (alternativeColor != null) {
          return alternativeColor;
        }
      }
      
      // 2. If no alternative color is found (or logo has only 1 color), use professional grey
      return fallbackColor;
    }

    return awayColor; // No conflict
  }

  /// Resolves the final team color:
  /// Uses API hex color if present, or extracted image color if missing,
  /// then applies subtle contrast touch.
  static Color resolveTeamColor({
    required String? apiHexColor,
    required Color? extractedColor,
    required Color defaultColor,
  }) {
    final bool hasApiColor = apiHexColor != null && apiHexColor.trim().isNotEmpty;
    final Color baseColor = hasApiColor
        ? parseHex(apiHexColor, defaultColor: defaultColor)
        : (extractedColor ?? defaultColor);

    return darkenForContrast(baseColor);
  }
}
