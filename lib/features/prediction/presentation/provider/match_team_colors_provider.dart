import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/utils/team_color_extractor.dart';
import '../../../../../core/utils/team_color_helper.dart';
import '../riverpod/match_details_riverpod.dart';

class MatchTeamColorsState {
  final Color homeColor;
  final Color awayColor;
  final Color homeGlowColor;
  final Color awayGlowColor;

  const MatchTeamColorsState({
    required this.homeColor,
    required this.awayColor,
    required this.homeGlowColor,
    required this.awayGlowColor,
  });

  factory MatchTeamColorsState.defaults() {
    return const MatchTeamColorsState(
      homeColor: Color(0xFFC40010),
      awayColor: Color(0xFF79ADE2),
      homeGlowColor: Colors.white,
      awayGlowColor: Colors.white,
    );
  }

  MatchTeamColorsState copyWith({
    Color? homeColor,
    Color? awayColor,
    Color? homeGlowColor,
    Color? awayGlowColor,
  }) {
    return MatchTeamColorsState(
      homeColor: homeColor ?? this.homeColor,
      awayColor: awayColor ?? this.awayColor,
      homeGlowColor: homeGlowColor ?? this.homeGlowColor,
      awayGlowColor: awayGlowColor ?? this.awayGlowColor,
    );
  }
}

final matchTeamColorsProvider = StateNotifierProvider.family.autoDispose<
    MatchTeamColorsNotifier, MatchTeamColorsState, int>(
  (ref, int matchId) {
    final detailsState = ref.watch(matchDetailsProvider(matchId));
    final notifier = MatchTeamColorsNotifier();
    if (detailsState.data != null) {
      notifier.updateFromMatchDetails(
        homeHex: detailsState.data.teams?.home?.color,
        awayHex: detailsState.data.teams?.away?.color,
        homeLogo: detailsState.data.teams?.home?.logo,
        awayLogo: detailsState.data.teams?.away?.logo,
      );
    }
    return notifier;
  },
);

class MatchTeamColorsNotifier extends StateNotifier<MatchTeamColorsState> {
  MatchTeamColorsNotifier() : super(MatchTeamColorsState.defaults());

  String? _lastHomeHex;
  String? _lastAwayHex;
  String? _lastHomeLogo;
  String? _lastAwayLogo;

  void updateFromMatchDetails({
    String? homeHex,
    String? awayHex,
    String? homeLogo,
    String? awayLogo,
  }) {
    if (_lastHomeHex == homeHex &&
        _lastAwayHex == awayHex &&
        _lastHomeLogo == homeLogo &&
        _lastAwayLogo == awayLogo) {
      return;
    }

    _lastHomeHex = homeHex;
    _lastAwayHex = awayHex;
    _lastHomeLogo = homeLogo;
    _lastAwayLogo = awayLogo;

    // Instant synchronous color parsing
    final Color parsedHome = TeamColorExtractor.parseHex(homeHex, defaultColor: const Color(0xFFC40010));
    final Color parsedAwayTemp = TeamColorExtractor.parseHex(awayHex, defaultColor: const Color(0xFF79ADE2));

    final Color parsedAway = TeamColorHelper.resolveColorConflict(parsedHome, parsedAwayTemp, awayLogo: awayLogo);

    final Color parsedHomeGlow = TeamColorExtractor.parseHex(homeHex, defaultColor: Colors.white);
    final Color parsedAwayGlow = parsedAway;

    state = state.copyWith(
      homeColor: parsedHome,
      awayColor: parsedAway,
      homeGlowColor: parsedHomeGlow,
      awayGlowColor: parsedAwayGlow,
    );

    // Asynchronous dynamic logo extraction if needed
    _extractAsyncColors(homeHex, homeLogo, awayHex, awayLogo);
  }

  void _extractAsyncColors(
    String? homeHex,
    String? homeLogo,
    String? awayHex,
    String? awayLogo,
  ) async {
    final bool needsHomeExtract = homeLogo != null && homeLogo.trim().isNotEmpty;
    final bool needsAwayExtract = awayLogo != null && awayLogo.trim().isNotEmpty;

    Color newHomeColor = state.homeColor;
    Color newHomeGlowColor = state.homeGlowColor;
    Color newAwayColor = state.awayColor;
    Color newAwayGlowColor = state.awayGlowColor;

    if (needsHomeExtract && homeLogo != null && homeLogo.isNotEmpty) {
      final Color? cachedHome = TeamColorExtractor.getCachedColor(homeLogo);
      if (cachedHome != null) {
        newHomeColor = cachedHome;
        newHomeGlowColor = cachedHome;
      } else {
        newHomeColor = await TeamColorExtractor.extractColor(
          hexColor: null,
          logoUrl: homeLogo,
          defaultColor: const Color(0xFFC40010),
        );
        newHomeGlowColor = newHomeColor != Colors.white ? newHomeColor : newHomeGlowColor;
      }
    }

    if (needsAwayExtract && awayLogo != null && awayLogo.isNotEmpty) {
      final Color? cachedAway = TeamColorExtractor.getCachedColor(awayLogo);
      if (cachedAway != null) {
        newAwayColor = cachedAway;
        newAwayGlowColor = cachedAway;
      } else {
        newAwayColor = await TeamColorExtractor.extractColor(
          hexColor: null,
          logoUrl: awayLogo,
          defaultColor: const Color(0xFF79ADE2),
        );
        newAwayGlowColor = newAwayColor != Colors.white ? newAwayColor : newAwayGlowColor;
      }
    }

    // Ensure contrast: if both logos extract a very similar color, fallback to an alternative color or grey
    newAwayColor = TeamColorHelper.resolveColorConflict(newHomeColor, newAwayColor, awayLogo: awayLogo);
    newAwayGlowColor = newAwayColor;

    if (mounted) {
      state = state.copyWith(
        homeColor: newHomeColor,
        awayColor: newAwayColor,
        homeGlowColor: newHomeGlowColor,
        awayGlowColor: newAwayGlowColor,
      );
    }
  }
}
