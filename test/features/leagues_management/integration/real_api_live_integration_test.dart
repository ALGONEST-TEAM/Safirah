import 'package:dio/dio.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/core/local/secure_storage.dart';
import 'package:safirah/core/network/remote_request.dart';
import 'package:safirah/core/network/urls.dart';
import 'package:safirah/features/leagues_mangement/leagues/data/data_source/league_remote_data_source.dart';
import 'package:safirah/features/leagues_mangement/match/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/match/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:safirah/injection.dart' as di;

import '../helpers/test_db_helper.dart';

import 'dart:io';

class RealNetworkHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class FakeWingsSecureStorage extends WingsSecureStorage {
  final Map<String, String> _cache = {};
  FakeWingsSecureStorage() : super('12345678901234567890123456789012');

  @override
  Future<void> write({required String key, required String value}) async {
    _cache[key] = value;
  }

  @override
  Future<String?> read({required String key}) async {
    return _cache[key];
  }

  @override
  Future<void> delete({required String key}) async {
    _cache.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    _cache.clear();
  }
}

void main() {
  late Safirah db;
  late MatchesLocalDataSource matchLocal;

  setUpAll(() {
    HttpOverrides.global = RealNetworkHttpOverrides();

    if (di.sl.isRegistered<WingsSecureStorage>()) {
      di.sl.unregister<WingsSecureStorage>();
    }
    di.sl.registerSingleton<WingsSecureStorage>(FakeWingsSecureStorage());

    // Initialize real Dio client with AppURL.baseURL (https://safirah.store/api/app)
    RemoteRequest.initDio();
  });

  Future<T> retryOnThrottle<T>(Future<T> Function() action) async {
    for (var i = 1; i <= 4; i++) {
      try {
        return await action();
      } on DioException catch (e) {
        if (e.response?.statusCode == 429 && i < 4) {
          await Future.delayed(Duration(seconds: 4 + (i * 2)));
          continue;
        }
        rethrow;
      }
    }
    return await action();
  }

  setUp(() {
    db = TestDbHelper.createTestDatabase();
    matchLocal = MatchesLocalDataSource(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Real Live API Integration Tests (اتصال حقيقي بسيرفر Safirah)', () {
    test('1. Real API Health: GET /league-application/home/main responds 200 with live content', () async {
      final res = await retryOnThrottle(() => RemoteRequest.getData(
        url: '${AppURL.baseURL}/league-application/home/main',
      ));

      expect(res.statusCode, 200);
      expect(res.data, isNotNull);
      final data = res.data as Map<String, dynamic>;
      expect(data.containsKey('data'), isTrue);
    });

    test('2. Real Terms Endpoint: GET /league-application/terms returns the 5 production match terms', () async {
      final matchTermRemote = MatchTermRemoteDataSource();
      final terms = await retryOnThrottle(() => matchTermRemote.getTerms());

      // Real server must return at least 5 terms
      expect(terms.length, greaterThanOrEqualTo(5));

      final termNames = terms.map((t) => t.name).toList();
      expect(termNames, contains('الشوط الاول'));
      expect(termNames, contains('الشوط الثاني'));
      expect(termNames, contains('الشوط الإضافي الأول'));
      expect(termNames, contains('الشوط الإضافي الثاني'));
      expect(termNames, contains('ركلات الترجيح'));

      // Validate sync IDs match our app expectations
      final termRegular1 = terms.firstWhere((t) => t.name == 'الشوط الاول');
      expect(termRegular1.syncId, '967d9f64-cb79-464d-8a79-ff8379b0694c');
      expect(termRegular1.type, 'regular');
      expect(termRegular1.order, 1);

      final termRegular2 = terms.firstWhere((t) => t.name == 'الشوط الثاني');
      expect(termRegular2.syncId, 'a24c1724-86ec-49ef-8319-4c76724cba8a');
      expect(termRegular2.type, 'regular');
      expect(termRegular2.order, 2);
    });

    test('3. Real Leagues Endpoint: GET /league-application/leagues fetches active real leagues', () async {
      const leagueRemote = LeagueRemoteDataSource();
      final pagination = await retryOnThrottle(() => leagueRemote.fetchLeagues(page: 1, perPage: 5));

      expect(pagination.data, isNotEmpty);
      expect(pagination.total, greaterThan(0));

      final firstLeague = pagination.data.first;
      expect(firstLeague.syncId, isNotNull);
      expect(firstLeague.syncId.isNotEmpty, isTrue);
      expect(firstLeague.name, isNotNull);
      expect(firstLeague.name!.isNotEmpty, isTrue);
      expect(firstLeague.subscriptionPrice, isNotNull);
    });

    test('4. Real Rounds Endpoint: GET /league-application/rounds fetches rounds for a real league', () async {
      // First, get a real league sync_id from the live server
      const leagueRemote = LeagueRemoteDataSource();
      final pagination = await retryOnThrottle(() => leagueRemote.fetchLeagues(page: 1, perPage: 5));
      final realLeagueSyncId = pagination.data.first.syncId;

      // Second, fetch rounds for this real league from the server
      const matchRemote = MatchRemoteDataSource();
      final rounds = await retryOnThrottle(() => matchRemote.getLeagueRounds(realLeagueSyncId));

      // Successfully executed roundtrip and parsed RoundModel without schema error
      expect(rounds, isA<List>());
    });

    test('5. Real Server Pull & Local Database Ingestion: Upsert live API response into SQLite', () async {
      const leagueRemote = LeagueRemoteDataSource();
      final pagination = await retryOnThrottle(() => leagueRemote.fetchLeagues(page: 1, perPage: 5));
      final realLeague = pagination.data.first;
      final realLeagueSyncId = realLeague.syncId;

      // Insert league locally first
      await db.into(db.leagues).insert(
        LeaguesCompanion.insert(
          syncId: realLeagueSyncId,
          name: realLeague.name ?? 'دوري حقيقي',
          subscriptionPrice: realLeague.subscriptionPrice ?? '0',
          status: const Value('active'),
        ),
      );

      // Fetch live rounds from real server
      const matchRemote = MatchRemoteDataSource();
      final liveRounds = await retryOnThrottle(() => matchRemote.getLeagueRounds(realLeagueSyncId));

      // Ingest live API response into local SQLite database
      await matchLocal.upsertLeagueRoundsFromApiOneResponse(
        leagueSyncId: realLeagueSyncId,
        apiRounds: liveRounds,
      );

      // Verify data is stored in Drift tables cleanly
      final storedRounds = await (db.select(db.rounds)
            ..where((r) => r.leagueSyncId.equals(realLeagueSyncId)))
          .get();
      expect(storedRounds.length, liveRounds.length);
    });
  });
}
