import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class TeamColorExtractor {
  static final Map<String, List<Color>> _colorCache = {};

  /// Preload team logo colors in background before opening match details
  static void preloadColors(String? homeLogo, String? awayLogo) {
    if (homeLogo != null && homeLogo.trim().isNotEmpty && !_colorCache.containsKey(homeLogo)) {
      extractColor(hexColor: null, logoUrl: homeLogo);
    }
    if (awayLogo != null && awayLogo.trim().isNotEmpty && !_colorCache.containsKey(awayLogo)) {
      extractColor(hexColor: null, logoUrl: awayLogo);
    }
  }

  /// Synchronous instant lookup from memory cache
  static Color? getCachedColor(String? logoUrl) {
    if (logoUrl == null || logoUrl.trim().isEmpty) return null;
    return _colorCache[logoUrl]?.first;
  }

  /// Check if two colors are too similar
  static bool isClashing(Color color1, Color color2) {
    final int rDiff = color1.red - color2.red;
    final int gDiff = color1.green - color2.green;
    final int bDiff = color1.blue - color2.blue;
    final double distance = (rDiff * rDiff + gDiff * gDiff + bDiff * bDiff).toDouble();
    if (distance < 2500) return true;
    
    final HSLColor hsl1 = HSLColor.fromColor(color1);
    final HSLColor hsl2 = HSLColor.fromColor(color2);
    final double hueDiff = (hsl1.hue - hsl2.hue).abs();
    final double minHueDiff = hueDiff > 180 ? 360 - hueDiff : hueDiff;
    if (minHueDiff < 25 && (hsl1.lightness - hsl2.lightness).abs() < 0.25) return true;
    
    return false;
  }

  /// Look for an alternative color in the cached logo palette that doesn't clash
  static Color? getAlternativeColor(String? logoUrl, Color clashingColor) {
    if (logoUrl == null || logoUrl.trim().isEmpty) return null;
    final colors = _colorCache[logoUrl];
    if (colors == null || colors.length <= 1) return null;

    for (int i = 1; i < colors.length; i++) {
      if (!isClashing(colors[i], clashingColor)) {
        return colors[i];
      }
    }
    return null;
  }

  /// Extract dominant vibrant color from team logo image if API hexColor is missing or empty.
  static Future<Color> extractColor({
    required String? hexColor,
    required String logoUrl,
    Color defaultColor = Colors.white,
  }) async {
    // 1. If API hexColor is present and valid, parse and return it immediately!
    if (hexColor != null && hexColor.trim().isNotEmpty) {
      String hex = hexColor.replaceAll('#', '').replaceAll('0x', '').trim();
      if (hex.length == 6) hex = 'FF$hex';
      if (hex.length == 8) {
        final parsed = int.tryParse(hex, radix: 16);
        if (parsed != null && parsed != 0xFFFFFFFF && parsed != 0x00000000) {
          return _beautifyColor(Color(parsed));
        }
      }
    }

    // 2. Check memory cache for this logoUrl
    if (logoUrl.trim().isEmpty) return defaultColor;
    if (_colorCache.containsKey(logoUrl)) {
      return _colorCache[logoUrl]!.first;
    }

    // 3. Dynamically extract dominant color from team logo image
    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(logoUrl),
        maximumColorCount: 16,
      );

      final Color extracted = paletteGenerator.dominantColor?.color ??
          paletteGenerator.mutedColor?.color ??
          paletteGenerator.darkVibrantColor?.color ??
          paletteGenerator.vibrantColor?.color ??
          defaultColor;

      final Color beautified = _beautifyColor(extracted);
      
      final List<Color> allColors = [beautified];
      for (final pc in paletteGenerator.colors) {
        final bc = _beautifyColor(pc);
        if (!allColors.contains(bc)) {
          allColors.add(bc);
        }
      }

      _colorCache[logoUrl] = allColors;
      return beautified;
    } catch (_) {
      return defaultColor;
    }
  }

  /// Transforms the color to be softer, calmer, and more aesthetically pleasing
  static Color _beautifyColor(Color color) {
    if (color == Colors.white || color == Colors.transparent || color == Colors.black) {
      return color;
    }
    
    HSLColor hsl = HSLColor.fromColor(color);
    
    // Reduce saturation if it's too harsh (cap at 65%)
    double s = hsl.saturation;
    if (s > 0.65) s = 0.65;
    
    // Ensure lightness is balanced (not too dark, not too bright)
    // Range between 35% and 65% for calm aesthetics
    double l = hsl.lightness;
    if (l < 0.35) l = 0.35;
    if (l > 0.65) l = 0.65;
    
    return hsl.withSaturation(s).withLightness(l).toColor();
  }

  /// Synchronous fallback color parser
  static Color parseHex(String? hexColor, {Color defaultColor = Colors.white}) {
    if (hexColor == null || hexColor.trim().isEmpty) return defaultColor;
    String hex = hexColor.replaceAll('#', '').replaceAll('0x', '').trim();
    if (hex.length == 6) hex = 'FF$hex';
    if (hex.length != 8) return defaultColor;
    final parsed = int.tryParse(hex, radix: 16);
    if (parsed == null) return defaultColor;
    return _beautifyColor(Color(parsed));
  }
}
