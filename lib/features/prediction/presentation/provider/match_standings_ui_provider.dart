import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/match_fixture_standings_model.dart';


class MatchStandingsUIHelper {
  static Color parseColor(String? hexColor, Color defaultColor) {
    if (hexColor == null || hexColor.isEmpty) return defaultColor;
    String hex = hexColor.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.tryParse(hex, radix: 16) ?? defaultColor.value);
  }

  static Color getQualificationColor(MatchTeamStandingItemModel item) {
    if (item.rule?.color != null && item.rule!.color.isNotEmpty) {
      return parseColor(item.rule!.color, Colors.transparent);
    }
    return Colors.transparent;
  }

  static Color getHighlightColor(
    MatchTeamStandingItemModel item, {
    String? homeColorHex,
    String? awayColorHex,
  }) {
    final homeColor = parseColor(homeColorHex, const Color(0xFFC40010));
    final awayColor = parseColor(awayColorHex, const Color(0xFF79ADE2));

    if (item.matchTeamSide == 'home') return homeColor;
    if (item.matchTeamSide == 'away') return awayColor;

    if (item.isMatchTeam) {
      return const Color(0xffc59c47);
    }
    return Colors.transparent;
  }

  static List<MatchTeamStandingItemModel> flattenStandingItems(
    List<MatchStandingsTableContainerModel> tables,
  ) {
    final List<MatchTeamStandingItemModel> items = [];
    for (final table in tables) {
      items.addAll(table.standings);
    }
    return items;
  }

  static double calculateDynamicGap(double screenWidth) {
    final double availableScrollWidth = screenWidth - 32.w - 48.w - 16.w;
    final double teamNameWidth = 105.w;
    final double threeStatsWidth = 32.w + 48.w + 36.w; // لعب + +/- + نقاط
    return (availableScrollWidth - teamNameWidth - threeStatsWidth).clamp(24.w, 180.w);
  }

  static List<MatchStandingsGroupModel> getDefaultFilterTabs(String selectedGroupKey) {
    return [
      MatchStandingsGroupModel(
        key: 'all',
        labelAr: 'الكل',
        labelEn: 'All',
        selected: selectedGroupKey == 'all',
      ),
      MatchStandingsGroupModel(
        key: 'home',
        labelAr: 'داخل الأرض',
        labelEn: 'Home',
        selected: selectedGroupKey == 'home',
      ),
      MatchStandingsGroupModel(
        key: 'away',
        labelAr: 'خارج الأرض',
        labelEn: 'Away',
        selected: selectedGroupKey == 'away',
      ),
    ];
  }
}
