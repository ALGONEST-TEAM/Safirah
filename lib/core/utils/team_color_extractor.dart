import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import '../network/urls.dart';

class TeamColorExtractor {
  static final Map<String, List<Color>> _colorCache = {};
  static final Map<String, Future<Color>> _pendingExtractions = {};

  /// Normalizes relative or malformed URLs (e.g. uploaded from dashboard)
  static String? normalizeUrl(String? raw) {
    if (raw == null) return null;
    final url = raw.trim();
    if (url.isEmpty) return null;

    // Already absolute
    if (url.startsWith('http://') || url.startsWith('https://')) return url;

    // Protocol-relative
    if (url.startsWith('//')) return 'https:$url';

    // Relative path -> attach to API base domain
    final base = AppURL.base.replaceAll(RegExp(r"/+$"), '');
    final path = url.replaceAll(RegExp(r"^/+"), '');
    return '$base/$path';
  }

  /// Preload team logo colors in background before opening match details
  static void preloadColors(String? homeLogo, String? awayLogo) {
    if (homeLogo != null && homeLogo.trim().isNotEmpty && !_colorCache.containsKey(homeLogo.trim())) {
      extractColor(hexColor: null, logoUrl: homeLogo);
    }
    if (awayLogo != null && awayLogo.trim().isNotEmpty && !_colorCache.containsKey(awayLogo.trim())) {
      extractColor(hexColor: null, logoUrl: awayLogo);
    }
  }

  /// Synchronous instant lookup from memory cache
  static Color? getCachedColor(String? logoUrl) {
    if (logoUrl == null || logoUrl.trim().isEmpty) return null;
    return _colorCache[logoUrl.trim()]?.first;
  }

  /// Check if two colors are too similar
  static bool isClashing(Color color1, Color color2) {
    final int rDiff = (color1.r * 255.0).round() - (color2.r * 255.0).round();
    final int gDiff = (color1.g * 255.0).round() - (color2.g * 255.0).round();
    final int bDiff = (color1.b * 255.0).round() - (color2.b * 255.0).round();
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
    final colors = _colorCache[logoUrl.trim()];
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
      final parsed = parseHex(hexColor, defaultColor: Colors.transparent);
      if (parsed != Colors.transparent) {
        return parsed;
      }
    }

    final trimmedKey = logoUrl.trim();
    if (trimmedKey.isEmpty) return defaultColor;

    // 2. Check memory cache for this logoUrl
    if (_colorCache.containsKey(trimmedKey)) {
      return _colorCache[trimmedKey]!.first;
    }

    // 3. Deduplicate in-flight extractions (prevents duplicate parallel tasks)
    if (_pendingExtractions.containsKey(trimmedKey)) {
      return _pendingExtractions[trimmedKey]!;
    }

    // 4. Normalize URL (handles relative dashboard paths like /storage/teams/...)
    final normalized = normalizeUrl(trimmedKey);
    if (normalized == null) return defaultColor;

    // 5. Check for SVG - PaletteGenerator is for raster images only
    final lower = normalized.toLowerCase();
    if (lower.endsWith('.svg') || lower.contains('.svg?')) {
      return defaultColor;
    }

    final future = _performExtraction(normalized, trimmedKey, defaultColor);
    _pendingExtractions[trimmedKey] = future;
    return future;
  }

  static Future<Color> _performExtraction(
    String normalizedUrl,
    String cacheKey,
    Color defaultColor,
  ) async {
    try {
      // Super-fast downscaled extraction:
      // ResizeImage resizes down to 48x48 on decode, turning a 3000x3000px 36MB bitmap into a 9KB thumbnail!
      final ImageProvider resizedProvider = ResizeImage(
        CachedNetworkImageProvider(normalizedUrl),
        width: 48,
        height: 48,
      );

      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        resizedProvider,
        size: const Size(48, 48),
        maximumColorCount: 8,
        timeout: const Duration(seconds: 3),
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

      _colorCache[cacheKey] = allColors;
      return beautified;
    } catch (_) {
      return defaultColor;
    } finally {
      _pendingExtractions.remove(cacheKey);
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
    if (parsed == null || parsed == 0xFFFFFFFF || parsed == 0x00000000) return defaultColor;
    return _beautifyColor(Color(parsed));
  }
}
