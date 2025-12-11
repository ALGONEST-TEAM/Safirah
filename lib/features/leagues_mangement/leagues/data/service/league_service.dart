
class LeagueService {
  const LeagueService();

  /// يحسب عدد التصنيفات (الفئات) المطلوب إنشاؤها بناءً على
  /// عدد اللاعبين الأساسيين والاحتياطيين المسموح به.
  int calculateCategoriesCount({
    required int maxMainPlayers,
    required int maxSubPlayers,
  }) {
    final main = maxMainPlayers <= 0 ? 0 : maxMainPlayers;
    final sub = maxSubPlayers <= 0 ? 0 : maxSubPlayers;
    return main + sub;
  }

  /// يبني أسماء فئات اللاعبين (A, B, C, ... AA, AB, ...)
  /// بعدد [n].
  List<String> alphaLabels(int n) {
    const A = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final out = <String>[];
    for (var i = 0; i < n; i++) {
      var x = i;
      var s = '';
      do {
        s = A[x % 26] + s;
        x = (x ~/ 26) - 1;
      } while (x >= 0);
      out.add(s);
    }
    return out;
  }

  /// يُرجع عدد اللاعبين الافتراضي المراد تهيئتهم في الدوري
  /// إن لم يُحدد عدد صريح من الخارج.
  int defaultSeedPlayersCount(int total) {
    return total <= 0 ? 60 : total;
  }
}

