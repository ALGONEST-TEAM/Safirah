import '../../data/model/match_model.dart';

class MatchScorePresentation {
  final String primaryText;
  final String? secondaryText;

  const MatchScorePresentation({
    required this.primaryText,
    this.secondaryText,
  });

  bool get hasSecondaryText =>
      secondaryText != null && secondaryText!.trim().isNotEmpty;
}

String formatMatchRegularScore(
  MatchModel match, {
  bool reverseOrder = false,
}) {
  final left = reverseOrder ? match.awayScore : match.homeScore;
  final right = reverseOrder ? match.homeScore : match.awayScore;
  return '$left : $right';
}

String? formatMatchPenaltyScore(
  MatchModel match, {
  bool reverseOrder = false,
  bool onlyWhenFinished = true,
}) {
  final hasPenaltyScore =
      match.homePenaltyScore != null || match.awayPenaltyScore != null;
  if (!hasPenaltyScore) return null;

  if (onlyWhenFinished && match.status.toLowerCase().trim() != 'finished') {
    return null;
  }

  final left = reverseOrder
      ? (match.awayPenaltyScore ?? 0)
      : (match.homePenaltyScore ?? 0);
  final right = reverseOrder
      ? (match.homePenaltyScore ?? 0)
      : (match.awayPenaltyScore ?? 0);

  return 'ترجيح $left : $right';
}

String? formatMatchPenaltyDisplayText(
  MatchModel match, {
  bool reverseOrder = false,
  bool onlyWhenFinished = true,
}) {
  final hasPenaltyScore =
      match.homePenaltyScore != null || match.awayPenaltyScore != null;
  if (!hasPenaltyScore) return null;

  if (onlyWhenFinished && match.status.toLowerCase().trim() != 'finished') {
    return null;
  }

  final left = reverseOrder
      ? (match.awayPenaltyScore ?? 0)
      : (match.homePenaltyScore ?? 0);
  final right = reverseOrder
      ? (match.homePenaltyScore ?? 0)
      : (match.awayPenaltyScore ?? 0);

  return 'ترجيح \u2066$left : $right\u2069';
}

MatchScorePresentation buildMatchScorePresentation(
  MatchModel? match, {
  bool reverseOrder = false,
  String emptyText = '-- : --',
  String? nonScorePrimaryText,
  bool showPenaltyOnlyWhenFinished = true,
}) {
  if (match == null || (match.syncId ?? '').trim().isEmpty) {
    return MatchScorePresentation(primaryText: emptyText);
  }

  final status = match.status.toLowerCase().trim();
  if (status == 'unscheduled') {
    return MatchScorePresentation(primaryText: nonScorePrimaryText ?? '-:-');
  }

  final primary = nonScorePrimaryText ??
      formatMatchRegularScore(match, reverseOrder: reverseOrder);

  return MatchScorePresentation(
    primaryText: primary,
    secondaryText: formatMatchPenaltyScore(
      match,
      reverseOrder: reverseOrder,
      onlyWhenFinished: showPenaltyOnlyWhenFinished,
    ),
  );
}


