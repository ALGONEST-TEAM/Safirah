import 'package:flutter_test/flutter_test.dart';

// We only test parsing behavior by duplicating the logic contract around URL shapes.
// Since DeepLinkService._parseLeagueId is private, this test asserts the exact URL
// formats the app promises to support.

String? parseLeagueId(Uri uri) {
  if (uri.scheme == 'https') {
    const allowedHosts = <String>{
      'saferah.dev-station.com',
      'safirah.app',
    };
    if (!allowedHosts.contains(uri.host)) return null;
  }

  final segments = uri.pathSegments;
  if (segments.length >= 2 && segments.first == 'league') {
    return segments[1];
  }

  if (uri.scheme == 'safirah' && uri.host == 'league') {
    if (segments.isNotEmpty) return segments.first;
  }

  final q = uri.queryParameters['leagueSyncId'] ??
      uri.queryParameters['id'] ??
      uri.queryParameters['leagueId'];
  if (q != null && q.isNotEmpty) return q;

  return null;
}

void main() {
  group('Deep link league id parsing', () {
    test('https saferah.dev-station.com /league/<id>', () {
      final id = parseLeagueId(
        Uri.parse('https://saferah.dev-station.com/league/ABC123'),
      );
      expect(id, 'ABC123');
    });

    test('legacy https safirah.app /league/<id>', () {
      final id = parseLeagueId(
        Uri.parse('https://safirah.app/league/LEGACY'),
      );
      expect(id, 'LEGACY');
    });

    test('reject unknown https host', () {
      final id = parseLeagueId(
        Uri.parse('https://evil.example.com/league/AAA'),
      );
      expect(id, isNull);
    });

    test('custom scheme safirah://league/<id>', () {
      final id = parseLeagueId(
        Uri.parse('safirah://league/XYZ'),
      );
      expect(id, 'XYZ');
    });

    test('query param safirah://league?leagueSyncId=<id>', () {
      final id = parseLeagueId(
        Uri.parse('safirah://league?leagueSyncId=QWE'),
      );
      expect(id, 'QWE');
    });
  });
}

