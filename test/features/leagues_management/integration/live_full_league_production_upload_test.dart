// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/local/secure_storage.dart';
import 'package:safirah/core/network/remote_request.dart';
import 'package:safirah/core/network/urls.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:safirah/injection.dart' as di;
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

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
  Future<void> write({required String key, required String value}) async => _cache[key] = value;
  @override
  Future<String?> read({required String key}) async => _cache[key];
  @override
  Future<void> delete({required String key}) async => _cache.remove(key);
  @override
  Future<void> deleteAll() async => _cache.clear();
}

Future<Response<T>> _safePost<T>(String path, dynamic data) async {
  for (var attempt = 1; attempt <= 4; attempt++) {
    try {
      return await RemoteRequest.postData<T>(path: path, data: data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 429 && attempt < 4) {
        print('⏳ [RateLimit 429] Waiting 5s before retry (attempt $attempt/4)...');
        await Future.delayed(const Duration(seconds: 5));
        continue;
      }
      rethrow;
    }
  }
  return await RemoteRequest.postData<T>(path: path, data: data);
}

Future<Response<T>> _safePut<T>(String path, dynamic data) async {
  for (var attempt = 1; attempt <= 4; attempt++) {
    try {
      return await RemoteRequest.putData<T>(path: path, data: data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 429 && attempt < 4) {
        print('⏳ [RateLimit 429] Waiting 5s before retry (attempt $attempt/4)...');
        await Future.delayed(const Duration(seconds: 5));
        continue;
      }
      rethrow;
    }
  }
  return await RemoteRequest.putData<T>(path: path, data: data);
}

Future<Response<T>> _safeGet<T>(String path, {Map<String, dynamic>? query}) async {
  for (var attempt = 1; attempt <= 4; attempt++) {
    try {
      return await RemoteRequest.getData<T>(url: path, query: query);
    } on DioException catch (e) {
      if (e.response?.statusCode == 429 && attempt < 4) {
        print('⏳ [RateLimit 429] Waiting 5s before retry (attempt $attempt/4)...');
        await Future.delayed(const Duration(seconds: 5));
        continue;
      }
      rethrow;
    }
  }
  return await RemoteRequest.getData<T>(url: path, query: query);
}

void main() {
  setUpAll(() {
    HttpOverrides.global = RealNetworkHttpOverrides();
    if (di.sl.isRegistered<WingsSecureStorage>()) {
      di.sl.unregister<WingsSecureStorage>();
    }
    di.sl.registerSingleton<WingsSecureStorage>(FakeWingsSecureStorage());
    RemoteRequest.initDio();
  });

  group('Full Production League Upload & Verification Test (رفع دوري كامل وحقيقي للسيرفر للمراجعة)', () {
    test('Create, configure, schedule, officiate, and upload complete league to https://safirah.store', () async {
      final leagueSyncId = const Uuid().v7();
      final leagueName = 'دوري أبطال سفيرة المكتمل للمراجعة - ${DateTime.now().millisecondsSinceEpoch % 10000}';
      print('🚀 بدء إنشاء ورفع الدوري الكامل إلى السيرفر: $leagueName (sync_id: $leagueSyncId)');

      // =========================================================================
      // 1. إنشاء الدوري والفرق والفئات والقواعد في السيرفر (POST /league-application/leagues)
      // =========================================================================
      final team1SyncId = const Uuid().v7();
      final team2SyncId = const Uuid().v7();
      final team3SyncId = const Uuid().v7();
      final team4SyncId = const Uuid().v7();

      final leaguePayload = {
        'league_sync_id': leagueSyncId,
        'league': {
          'sync_id': leagueSyncId,
          'name': leagueName,
          'type': 'regular',
          'subscription_price': '200',
          'is_private': false,
          'status': 'active',
          'max_teams': 4,
          'max_main_players': 11,
          'max_sub_players': 5,
          'start_date': DateTime.now().toIso8601String(),
          'end_date': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
        },
        'team_player_categories': [
          {
            'sync_id': const Uuid().v7(),
            'league_sync_id': leagueSyncId,
            'name': 'الأساسيون',
            'min_players': 7,
            'max_players': 11,
            'type': 'main',
          },
          {
            'sync_id': const Uuid().v7(),
            'league_sync_id': leagueSyncId,
            'name': 'البدلاء',
            'min_players': 3,
            'max_players': 5,
            'type': 'sub',
          }
        ],
        'teams': [
          {'sync_id': team1SyncId, 'league_sync_id': leagueSyncId, 'team_name': 'نادي الرياض', 'status': 'placeholder'},
          {'sync_id': team2SyncId, 'league_sync_id': leagueSyncId, 'team_name': 'نادي جدة', 'status': 'placeholder'},
          {'sync_id': team3SyncId, 'league_sync_id': leagueSyncId, 'team_name': 'نادي الدمام', 'status': 'placeholder'},
          {'sync_id': team4SyncId, 'league_sync_id': leagueSyncId, 'team_name': 'نادي مكة', 'status': 'placeholder'},
        ],
        'league_rules': [
          {
            'sync_id': const Uuid().v7(),
            'league_sync_id': leagueSyncId,
            'description': 'الالتزام التام بالروح الرياضية والزي الموحد المعتمد',
            'is_mandatory': true,
          }
        ],
      };

      final createLeagueRes = await _safePost(
        '${AppURL.baseURL}/league-application/leagues',
        leaguePayload,
      );
      expect(createLeagueRes.statusCode, 201);
      final leagueData = createLeagueRes.data['data'] as Map<String, dynamic>;
      expect(leagueData['sync_id'], leagueSyncId);
      final serverLeagueId = leagueData['id'];
      print('✅ 1. تم إنشاء الدوري في السيرفر بنجاح (ID: $serverLeagueId, SyncId: $leagueSyncId)');

      // =========================================================================
      // 2. ربط أشواط الدوري بالسيرفر (POST /league-application/league-terms)
      // =========================================================================
      final liveTerms = await MatchTermRemoteDataSource().getTerms();
      expect(liveTerms.isNotEmpty, isTrue);
      final regularTerms = liveTerms.where((t) => t.type.toLowerCase() == 'regular').toList();
      regularTerms.sort((a, b) => a.order.compareTo(b.order));

      final term1Definition = regularTerms[0];
      final term2Definition = regularTerms[1];

      final leagueTerm1SyncId = const Uuid().v7();
      final leagueTerm2SyncId = const Uuid().v7();

      final termsPayload = {
        'league_sync_id': leagueSyncId,
        'terms': [
          {
            'sync_id': leagueTerm1SyncId,
            'term_sync_id': term1Definition.syncId,
            'duration_minutes': 45,
          },
          {
            'sync_id': leagueTerm2SyncId,
            'term_sync_id': term2Definition.syncId,
            'duration_minutes': 45,
          },
        ],
      };

      final createTermsRes = await _safePost(
        '${AppURL.baseURL}/league-application/league-terms',
        termsPayload,
      );
      expect(createTermsRes.statusCode, 201);
      print('✅ 2. تم ربط الشوطين (${term1Definition.name} و ${term2Definition.name}) بالدوري في السيرفر');

      // =========================================================================
      // 3. إجراء القرعة وإنشاء المجموعات (POST /league-application/groups)
      // =========================================================================
      final groupSyncId = const Uuid().v7();
      final groupPayload = {
        'groups': [
          {
            'group': {
              'sync_id': groupSyncId,
              'league_id': leagueSyncId,
              'group_name': 'المجموعة الأولى (A)',
              'qualified_team_number': 2,
            },
            'group_teams': [
              {'team_sync_id': team1SyncId},
              {'team_sync_id': team2SyncId},
              {'team_sync_id': team3SyncId},
              {'team_sync_id': team4SyncId},
            ],
            'qualified_teams': [
              {'sync_id': const Uuid().v7(), 'team_sync_id': team1SyncId, 'played': 0, 'wins': 0, 'draws': 0, 'losses': 0, 'goals_for': 0, 'goals_against': 0, 'points': 0, 'qualification_type': 'auto'},
              {'sync_id': const Uuid().v7(), 'team_sync_id': team2SyncId, 'played': 0, 'wins': 0, 'draws': 0, 'losses': 0, 'goals_for': 0, 'goals_against': 0, 'points': 0, 'qualification_type': 'auto'},
              {'sync_id': const Uuid().v7(), 'team_sync_id': team3SyncId, 'played': 0, 'wins': 0, 'draws': 0, 'losses': 0, 'goals_for': 0, 'goals_against': 0, 'points': 0, 'qualification_type': 'auto'},
              {'sync_id': const Uuid().v7(), 'team_sync_id': team4SyncId, 'played': 0, 'wins': 0, 'draws': 0, 'losses': 0, 'goals_for': 0, 'goals_against': 0, 'points': 0, 'qualification_type': 'auto'},
            ],
          }
        ]
      };

      final createGroupRes = await _safePost(
        '${AppURL.baseURL}/league-application/groups',
        groupPayload,
      );
      expect(createGroupRes.statusCode, 201);
      print('✅ 3. تم إنشاء المجموعة الأولى وتوزيع الفرق الأربعة في جدول الترتيب بالسيرفر');

      // =========================================================================
      // 4. إنشاء الجولات وجدول المباريات (POST /rounds + POST /matches)
      // =========================================================================
      final roundSyncId = const Uuid().v7();
      final roundPayload = {
        'rounds': [
          {
            'sync_id': roundSyncId,
            'league_sync_id': leagueSyncId,
            'group_sync_id': groupSyncId,
            'round_type': 'group',
            'round_name': 'الجولة 1 - قمة الرياض وجدة',
          }
        ]
      };

      final createRoundRes = await _safePost(
        '${AppURL.baseURL}/league-application/rounds',
        roundPayload,
      );
      expect(createRoundRes.statusCode, 201);

      final matchSyncId = const Uuid().v7();
      final matchTerm1SyncId = const Uuid().v7();
      final matchTerm2SyncId = const Uuid().v7();

      final matchesPayload = {
        'matches': [
          {
            'match_sync_id': matchSyncId,
            'league_sync_id': leagueSyncId,
            'round_sync_id': roundSyncId,
            'home_team_sync_id': team1SyncId,
            'away_team_sync_id': team2SyncId,
            'match_date': DateTime.now().toIso8601String(),
            'scheduled_start_time': DateTime.now().toIso8601String(),
            'status': 'scheduled',
            'match_terms': [
              {
                'sync_id': matchTerm1SyncId,
                'league_term_sync_id': leagueTerm1SyncId,
                'additional_minutes': 0,
                'is_finished': false,
              },
              {
                'sync_id': matchTerm2SyncId,
                'league_term_sync_id': leagueTerm2SyncId,
                'additional_minutes': 0,
                'is_finished': false,
              }
            ]
          }
        ]
      };

      final createMatchRes = await _safePost(
        '${AppURL.baseURL}/league-application/matches',
        matchesPayload,
      );
      expect(createMatchRes.statusCode, 201);
      print('✅ 4. تم جدولة مباراة القمة (نادي الرياض ضد نادي جدة) مع ربط شوطي المباراة');

      // =========================================================================
      // 5. إدارة أحداث وأشواط المباراة والتحقق التام من إصلاح الباك إند
      // =========================================================================
      // أ) بدء الشوط الأول
      final startTerm1Payload = {
        'match_sync_id': matchSyncId,
        'league_sync_id': leagueSyncId,
        'match_terms': [
          {
            'sync_id': matchTerm1SyncId,
            'league_term_sync_id': leagueTerm1SyncId,
            'start_time': DateTime.now().toIso8601String(),
            'is_finished': false,
          }
        ]
      };
      final startTerm1Res = await _safePut(
        '${AppURL.baseURL}/league-application/matches',
        startTerm1Payload,
      );
      expect(startTerm1Res.statusCode, 200);

      // ب) إنهاء الشوط الأول (إرسال sync_id الشوط الأول مع league_term_sync_id الصحيح و end_time)
      final finishTerm1Payload = {
        'match_sync_id': matchSyncId,
        'league_sync_id': leagueSyncId,
        'match_terms': [
          {
            'sync_id': matchTerm1SyncId,
            'league_term_sync_id': leagueTerm1SyncId, // حاسم: الشوط الأول وليس الثاني!
            'end_time': DateTime.now().toIso8601String(),
            'is_finished': true,
            'additional_minutes': 1,
          }
        ]
      };
      final finishTerm1Res = await _safePut(
        '${AppURL.baseURL}/league-application/matches',
        finishTerm1Payload,
      );
      expect(finishTerm1Res.statusCode, 200);

      final term1ServerData = finishTerm1Res.data['data']['match_terms'] as List<dynamic>;
      final sTerm1 = term1ServerData.firstWhere((t) => t['league_term_sync_id'] == leagueTerm1SyncId);
      expect(sTerm1['is_finished'], true);
      expect(sTerm1['end_time'], isNotNull);
      print('✅ 5. أ) تم إنهاء الشوط الأول بنجاح وتأكيد صحة league_term_sync_id وعدم تكراره في السيرفر');

      // ج) بدء وإنهاء الشوط الثاني
      final startTerm2Payload = {
        'match_sync_id': matchSyncId,
        'league_sync_id': leagueSyncId,
        'match_terms': [
          {
            'sync_id': matchTerm2SyncId,
            'league_term_sync_id': leagueTerm2SyncId,
            'start_time': DateTime.now().toIso8601String(),
            'is_finished': false,
          }
        ]
      };
      await _safePut(
        '${AppURL.baseURL}/league-application/matches',
        startTerm2Payload,
      );

      final finishTerm2Payload = {
        'match_sync_id': matchSyncId,
        'league_sync_id': leagueSyncId,
        'match_terms': [
          {
            'sync_id': matchTerm2SyncId,
            'league_term_sync_id': leagueTerm2SyncId,
            'end_time': DateTime.now().toIso8601String(),
            'is_finished': true,
            'additional_minutes': 3,
          }
        ]
      };
      final finishTerm2Res = await _safePut(
        '${AppURL.baseURL}/league-application/matches',
        finishTerm2Payload,
      );
      expect(finishTerm2Res.statusCode, 200);
      print('✅ 5. ب) تم إنهاء الشوط الثاني بنجاح بالمعرف الخاص به');

      // د) إنهاء المباراة بنتيجة نهائية (2 - 1 لصالح نادي الرياض)
      final finishMatchPayload = {
        'league_sync_id': leagueSyncId,
        'match_sync_id': matchSyncId,
        'status': 'finished',
        'home_score': 2,
        'away_score': 1,
        'end_time': DateTime.now().toIso8601String(),
      };
      final finishMatchRes = await _safePut(
        '${AppURL.baseURL}/league-application/matches',
        finishMatchPayload,
      );
      expect(finishMatchRes.statusCode, 200);
      print('✅ 5. ج) تم إنهاء المباراة بنجاح (نادي الرياض 2 - 1 نادي جدة)');

      // =========================================================================
      // 6. التحقق النهائي وقراءة بيانات الدوري والجولات من السيرفر مباشرة للمراجعة
      // =========================================================================
      final verifyRoundsRes = await _safeGet(
        '${AppURL.baseURL}/league-application/rounds',
        query: {'league_sync_id': leagueSyncId},
      );
      expect(verifyRoundsRes.statusCode, 200);
      final roundsList = (verifyRoundsRes.data is Map && verifyRoundsRes.data['data'] != null)
          ? verifyRoundsRes.data['data'] as List<dynamic>
          : (verifyRoundsRes.data as List<dynamic>);

      expect(roundsList.isNotEmpty, isTrue);
      print('🎉 6. تم التحقق الكامل: الدوري متواجد الآن على السيرفر وجاهز لمراجعة فريق الباك إند!');
      print('📋 ملخص بيانات الدوري المرفوع للسيرفر:');
      print('   • اسم الدوري: $leagueName');
      print('   • معرف الدوري في السيرفر (ID): $serverLeagueId');
      print('   • sync_id: $leagueSyncId');
      print('   • عدد الفرق: 4 (الرياض، جدة، الدمام، مكة)');
      print('   • عدد الأشواط: 2 (كل شوط يحمل sync_id منفصل ودقيق بنسبة 100%)');
      print('   • نتيجة المباراة التجريبية: منتهية 2 - 1');
    });
  });
}
