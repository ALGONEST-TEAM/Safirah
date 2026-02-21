
import 'dart:io' show Directory, File;

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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


class ImageCacheService {
  ImageCacheService(this._dio, {required this.baseUrl});

  final Dio _dio;
  final String baseUrl; // لو الروابط عندك نسبية

  String _hash(String input) => sha1.convert(input.codeUnits).toString();

  String _normalizeUrl(String url) {
    final u = url.trim();
    if (u.isEmpty) return u;
    if (u.startsWith('http://') || u.startsWith('https://')) return u;
    return '${baseUrl.replaceAll(RegExp(r"/+$"), "")}/${u.replaceAll(RegExp(r"^/+"), "")}';
  }

  Future<Directory> _dir(String namespace) async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(base.path, 'images', namespace));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  Future<bool> exists(String? path) async {
    if (path == null || path.trim().isEmpty) return false;
    return File(path).exists();
  }

  Future<String> downloadToLocal({
    required String remoteUrl,
    required String namespace,
    required String key,
  }) async {
    final url = _normalizeUrl(remoteUrl);
    final dir = await _dir(namespace);

    final uri = Uri.tryParse(url);
    final ext = (uri != null) ? p.extension(uri.path) : '';
    final fileName = '${_hash(key)}${ext.isNotEmpty ? ext : ".jpg"}';
    final target = File(p.join(dir.path, fileName));

    if (await target.exists() && await target.length() > 0) {
      return target.path;
    }

    await _dio.download(url, target.path);
    return target.path;
  }
}