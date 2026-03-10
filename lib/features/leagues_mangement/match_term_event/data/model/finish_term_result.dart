// A small dedicated model file to avoid editing very large data source files.

class FinishTermResult {
  final bool termFinished; // هل تم إنهاء الشوط؟
  final bool matchFinished; // هل انتهت المباراة؟
  final bool pointsUpdatedLocally; // غير knockout
  final bool isKnockout;

  /// وقت إنهاء المباراة (إن انتهت)
  final DateTime? matchEndTime;

  /// وقت إنهاء الشوط الذي تم إنهاؤه (إن تم تسجيله)
  final DateTime? termEndTime;

  /// الدقائق الإضافية الخاصة بهذا الشوط (إن وجدت)
  final int? additionalMinutes;

  final int? homeScore;
  final int? awayScore;

  final String? leagueSyncId;
  final String? matchTermSyncId;
  final String leagueTermSyncId;
  final String matchSyncId;

  const FinishTermResult({
    required this.termFinished,
    required this.matchSyncId,
    required this.matchTermSyncId,
    required this.leagueTermSyncId,
    required this.matchFinished,
    required this.pointsUpdatedLocally,
    required this.isKnockout,
    this.matchEndTime,
    this.termEndTime,
    this.additionalMinutes,
    this.homeScore,
    this.awayScore,
    this.leagueSyncId,
  });
}

