// A small dedicated model file to keep start-term return consistent.

class StartTermResult {
  /// هل تم بدء الشوط بنجاح؟
  final bool termStarted;

  /// المعرّفات (للمزامنة/التحديث في الواجهة)
  final String matchSyncId;
  final String matchTermSyncId;

  /// وقت بدء الشوط (إن تم تسجيله)
  final DateTime? termStartTime;

  /// حالة المباراة بعد البدء (غالبًا live)
  final String? matchStatus;

  /// leagueTermSyncId الخاص بالشوط الحالي (FK)
  final String leagueTermSyncId;

  const StartTermResult({
    required this.termStarted,
    required this.matchSyncId,
    required this.matchTermSyncId,
    required this.leagueTermSyncId,
    this.termStartTime,
    this.matchStatus,
  });
}
