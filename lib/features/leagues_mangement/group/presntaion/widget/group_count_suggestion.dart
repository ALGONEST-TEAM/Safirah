import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/safirah_database.dart';
import '../../../../../injection.dart' as di;

/// 🔹 تمثيل اقتراح بعدد المجموعات فقط (قوى 2)
class GroupCountSuggestion {
  final int groups; // 2, 4, 8, 16...
  const GroupCountSuggestion(this.groups);

  String labelArabic() => _arabicGroupsLabel(groups);
}

/// 🔹 تمثيل اقتراح بعدد المتأهلين من كل مجموعة
class QualifiedSuggestion {
  final int count;
  const QualifiedSuggestion(this.count);

  String labelArabic() {
    if (count == 1) return 'فريق واحد من كل مجموعة';
    if (count == 2) return 'فريقان من كل مجموعة';
    if (count == 4) return 'أربعة فرق من كل مجموعة';
    return '$count فرق من كل مجموعة';
  }
}

/// 🔹 اقتراح عدد المجموعات (قوى 2)
List<GroupCountSuggestion> suggestPowerOfTwoGroupCounts(
    int teams, {
      bool requireExactDivision = false,
    }) {
  if (teams < 4) return const []; // أقل شيء مجموعتان وكل مجموعة >= 2
  final out = <GroupCountSuggestion>[];

  for (int g = 2; g <= teams; g *= 2) {
    final per = teams ~/ g;
    if (per < 2) break; // لا نسمح بأقل من فريقين للمجموعة الواحدة
    final rem = teams % g;
    if (requireExactDivision && rem != 0) continue;
    out.add(GroupCountSuggestion(g));
  }
  return out;
}

/// 🔹 اقتراح عدد الفرق المتأهلة من كل مجموعة
List<QualifiedSuggestion> suggestQualifiedPerGroup(int totalTeams, int groups) {
  if (groups <= 0) return const [];

  final teamsPerGroup = totalTeams ~/ groups;
  final suggestions = <QualifiedSuggestion>[];

  for (int q = 1; q < teamsPerGroup; q *= 2) {
    suggestions.add(QualifiedSuggestion(q));
  }

  return suggestions;
}

/// 🔹 مزود اقتراح عدد المجموعات (Power of Two)
final powerOfTwoGroupSuggestionsProvider =
FutureProvider.family<List<GroupCountSuggestion>, int>((ref, leagueId) async {
  final db = di.sl<Safirah>();
  final totalTeams = await (db.selectOnly(db.teams)
    ..addColumns([db.teams.id.count()])
    ..where(db.teams.leagueId.equals(leagueId)))
      .map((r) => r.read<int>(db.teams.id.count())!)
      .getSingle();
  return suggestPowerOfTwoGroupCounts(totalTeams, requireExactDivision: false);
});

/// 🔹 مزود اقتراح عدد المتأهلين بعد اختيار عدد المجموعات
final qualifiedSuggestionsProvider = FutureProvider.family
<List<QualifiedSuggestion>, ({int leagueId, int groups})>((ref, params) async {
  final db = di.sl<Safirah>();
  final totalTeams = await (db.selectOnly(db.teams)
    ..addColumns([db.teams.id.count()])
    ..where(db.teams.leagueId.equals(params.leagueId)))
      .map((r) => r.read<int>(db.teams.id.count())!)
      .getSingle();

  return suggestQualifiedPerGroup(totalTeams, params.groups);
});

/// ====== صيغ عربية مبسطة لعدد "مجموعات" لقوى 2 ======
String _arabicGroupsLabel(int n) {
  switch (n) {
    case 2:
      return 'مجموعتان';
    case 4:
      return 'أربع مجموعات';
    case 8:
      return 'ثماني مجموعات';
    case 16:
      return 'ست عشرة مجموعة';
    case 32:
      return 'اثنتان وثلاثون مجموعة';
    case 64:
      return 'أربع وستون مجموعة';
    default:
      return '$n مجموعة';
  }
}
