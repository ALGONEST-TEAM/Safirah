import 'dart:math';

import '../model/model.dart';

/// خدمة منطقية خاصة بالمجموعات: توزيع الفرق على المجموعات
/// وبناء نماذج GroupModel/QualifiedTeamModel بدون أوامر مباشرة على قاعدة البيانات.
class GroupService {
  const GroupService();

  int goalDifference(QualifiedTeamModel team) =>
      team.goalsFor - team.goalsAgainst;

  int compareQualifiedTeams(
    QualifiedTeamModel a,
    QualifiedTeamModel b, {
    Map<String, num> headToHeadPoints = const {},
  }) {
    final pointsCompare = b.points.compareTo(a.points);
    if (pointsCompare != 0) return pointsCompare;

    final goalDiffCompare = goalDifference(b).compareTo(goalDifference(a));
    if (goalDiffCompare != 0) return goalDiffCompare;

    final aH2H = headToHeadPoints[a.teamSyncId] ?? 0;
    final bH2H = headToHeadPoints[b.teamSyncId] ?? 0;
    final h2hCompare = bH2H.compareTo(aH2H);
    if (h2hCompare != 0) return h2hCompare;

    final goalsForCompare = b.goalsFor.compareTo(a.goalsFor);
    if (goalsForCompare != 0) return goalsForCompare;

    final goalsAgainstCompare = a.goalsAgainst.compareTo(b.goalsAgainst);
    if (goalsAgainstCompare != 0) return goalsAgainstCompare;

    return a.teamSyncId.compareTo(b.teamSyncId);
  }

  List<QualifiedTeamModel> sortQualifiedTeams(
    List<QualifiedTeamModel> teams, {
    Map<String, num> headToHeadPoints = const {},
  }) {
    if (teams.length <= 1) return List<QualifiedTeamModel>.from(teams);

    final list = List<QualifiedTeamModel>.from(teams);
    list.sort(
      (a, b) => compareQualifiedTeams(
        a,
        b,
        headToHeadPoints: headToHeadPoints,
      ),
    );
    return list;
  }

  bool isPowerOfTwo(int g) => g > 0 && (g & (g - 1)) == 0;

  /// يحسب توزيع الفرق على عدد محدد من المجموعات.
  /// يعيد:
  /// - أسماء المجموعات (A, B, ... أو Group 1, Group 2, ...)
  /// - buckets: لكل مجموعة قائمة teamIds.
  GroupDrawResult drawGroupsByCount({
    required List<String> teamIds,
    required int groupsCount,
    required bool useLetters,
    required Random random,
  }) {
    if (!isPowerOfTwo(groupsCount)) {
      throw ArgumentError('groupsCount يجب أن يكون قوة للعدد 2');
    }

    final teamLength = teamIds.length;
    if (teamLength < groupsCount * 2) {
      throw StateError('لا يكفي: مطلوب على الأقل فريقان لكل مجموعة');
    }

    // نعمل نسخة ونخلطها
    final ids = List<String>.from(teamIds);
    ids.shuffle(random);

    // حساب السعة لكل مجموعة
    final q = teamLength ~/ groupsCount;
    final r = teamLength % groupsCount;
    final caps = List<int>.generate(groupsCount, (i) => q + (i < r ? 1 : 0));
    final buckets = List.generate(groupsCount, (_) => <String>[]);

    var g = 0;
    for (final tid in ids) {
      var hops = 0;
      while (hops < groupsCount && buckets[g].length >= caps[g]) {
        g = (g + 1) % groupsCount;
        hops++;
      }
      if (buckets[g].length >= caps[g]) {
        throw StateError('لم يتم العثور على حاوية صالحة للتوزيع');
      }
      buckets[g].add(tid);
      g = (g + 1) % groupsCount;
    }

    // أسماء المجموعات
    final groupNames = List<String>.generate(groupsCount, (i) {
      if (useLetters) {
        return String.fromCharCode(65 + i); // A, B, C, ...
      } else {
        return 'Group ${i + 1}';
      }
    });

    return GroupDrawResult(
      groupNames: groupNames,
      buckets: buckets,
    );
  }

  /// يبني قائمة المؤهلين (QualifiedTeamModel) من IDs وأسماء الفرق.
  List<QualifiedTeamModel> buildQualifiedTeams({
    required String leagueSyncId,
    required String groupSyncId,
    required List<String> teamSyncIds,
    required Map<String, String> teamNameById,
  }) {
    return teamSyncIds
        .map(
          (tid) => QualifiedTeamModel(
            leagueSyncId: leagueSyncId,
            groupSyncId: groupSyncId,
            teamSyncId: tid,
            teamName: teamNameById[tid],
          ),
        )
        .toList();
  }

  /// يرتب الفرق داخل مجموعة واحدة بناءً على إحصائيات المواجهات المباشرة
  /// (head-to-head) المحسوبة مسبقاً.
  ///
  /// [teams] القائمة الأصلية مرتبة بالنقاط العامة.
  /// [headToHeadPoints] خريطة teamId -> نقاط المواجهات المباشرة داخل مجموعة التعادل.
  List<QualifiedTeamModel> sortByHeadToHead(
    List<QualifiedTeamModel> teams,
    Map<String, num> headToHeadPoints,
  ) {
    return sortQualifiedTeams(
      teams,
      headToHeadPoints: headToHeadPoints,
    );
  }
}

/// نتيجة عملية القرعة: أسماء المجموعات + توزيع الفريق على كل مجموعة.
class GroupDrawResult {
  final List<String> groupNames;
  final List<List<String>> buckets;

  const GroupDrawResult({
    required this.groupNames,
    required this.buckets,
  });
}
