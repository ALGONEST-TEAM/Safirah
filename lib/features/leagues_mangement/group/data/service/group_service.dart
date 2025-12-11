import 'dart:math';

import '../model/model.dart';

/// خدمة منطقية خاصة بالمجموعات: توزيع الفرق على المجموعات
/// وبناء نماذج GroupModel/QualifiedTeamModel بدون أوامر مباشرة على قاعدة البيانات.
class GroupService {
  const GroupService();

  bool isPowerOfTwo(int g) => g > 0 && (g & (g - 1)) == 0;

  /// يحسب توزيع الفرق على عدد محدد من المجموعات.
  /// يعيد:
  /// - أسماء المجموعات (A, B, ... أو Group 1, Group 2, ...)
  /// - buckets: لكل مجموعة قائمة teamIds.
  GroupDrawResult drawGroupsByCount({
    required List<int> teamIds,
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
    final ids = List<int>.from(teamIds);
    ids.shuffle(random);

    // حساب السعة لكل مجموعة
    final q = teamLength ~/ groupsCount;
    final r = teamLength % groupsCount;
    final caps = List<int>.generate(groupsCount, (i) => q + (i < r ? 1 : 0));
    final buckets = List.generate(groupsCount, (_) => <int>[]);

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
    required int leagueId,
    required int groupId,
    required List<int> teamIds,
    required Map<int, String> teamNameById,
  }) {
    return teamIds
        .map(
          (tid) => QualifiedTeamModel(
            leagueId: leagueId,
            groupId: groupId,
            teamId: tid,
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
    Map<int, num> headToHeadPoints,
  ) {
    if (teams.length <= 1) return teams;

    final list = List<QualifiedTeamModel>.from(teams);

    list.sort((a, b) {
      // 1) فارق الأهداف العام
      final aDiff = a.goalsFor - a.goalsAgainst;
      final bDiff = b.goalsFor - b.goalsAgainst;
      final diffCompare = bDiff.compareTo(aDiff);
      if (diffCompare != 0) return diffCompare;

      // 2) عدد الأهداف المسجلة
      final goalsCompare = b.goalsFor.compareTo(a.goalsFor);
      if (goalsCompare != 0) return goalsCompare;

      // 3) عدد الانتصارات
      final winsCompare = b.wins.compareTo(a.wins);
      if (winsCompare != 0) return winsCompare;

      // 4) عدد الخسائر (الأقل أفضل)
      final lossesCompare = a.losses.compareTo(b.losses);
      if (lossesCompare != 0) return lossesCompare;

      // 5) أخيراً: نقاط المواجهات المباشرة كآخر معيار
      final aH2H = headToHeadPoints[a.teamId] ?? 0;
      final bH2H = headToHeadPoints[b.teamId] ?? 0;
      final h2hCompare = bH2H.compareTo(aH2H);
      if (h2hCompare != 0) return h2hCompare;

      return 0;
    });

    return list;
  }
}

/// نتيجة عملية القرعة: أسماء المجموعات + توزيع الفريق على كل مجموعة.
class GroupDrawResult {
  final List<String> groupNames;
  final List<List<int>> buckets;

  const GroupDrawResult({
    required this.groupNames,
    required this.buckets,
  });
}
