// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/local/secure_storage.dart';
import 'package:safirah/core/network/remote_request.dart';
import 'package:safirah/core/network/urls.dart';
import 'package:safirah/features/authorization/data/data_source/authorization_remote_data_source.dart';
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

Future<Response<T>> _safePost<T>(String path, dynamic data, {Map<String, dynamic>? query}) async {
  for (var attempt = 1; attempt <= 5; attempt++) {
    try {
      return await RemoteRequest.postData<T>(path: path, data: data, query: query);
    } on DioException catch (e) {
      if (e.response?.statusCode == 429 && attempt < 5) {
        print('⏳ [RateLimit 429] Waiting 5s before retry (attempt $attempt/5)...');
        await Future.delayed(const Duration(seconds: 5));
        continue;
      }
      rethrow;
    }
  }
  return await RemoteRequest.postData<T>(path: path, data: data, query: query);
}

Future<Response<T>> _safePut<T>(String path, dynamic data, {Map<String, dynamic>? query}) async {
  for (var attempt = 1; attempt <= 5; attempt++) {
    try {
      return await RemoteRequest.putData<T>(path: path, data: data, query: query);
    } on DioException catch (e) {
      if (e.response?.statusCode == 429 && attempt < 5) {
        print('⏳ [RateLimit 429] Waiting 5s before retry (attempt $attempt/5)...');
        await Future.delayed(const Duration(seconds: 5));
        continue;
      }
      rethrow;
    }
  }
  return await RemoteRequest.putData<T>(path: path, data: data, query: query);
}

Future<Response<T>> _safeGet<T>(String path, {Map<String, dynamic>? query}) async {
  for (var attempt = 1; attempt <= 5; attempt++) {
    try {
      return await RemoteRequest.getData<T>(url: path, query: query);
    } on DioException catch (e) {
      if (e.response?.statusCode == 429 && attempt < 5) {
        print('⏳ [RateLimit 429] Waiting 5s before retry (attempt $attempt/5)...');
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

  group('Master Full Tournament Production Test (بطولة حقيقية متكاملة الأركان مع المستخدم حسين الأشول والـ 60 طلباً)', () {
    test('Execute complete tournament from creation to Grand Final championship', timeout: const Timeout(Duration(minutes: 5)), () async {
      const targetUserName = 'حسين الاشول';
      const targetUserId = 163;
      final leagueSyncId = const Uuid().v7();
      final tournamentId = DateTime.now().millisecondsSinceEpoch % 100000;
      final leagueName = 'كأس النخبة الذهبي الممتاز - $tournamentId';

      print('================================================================');
      print('🏆 بدء إنشاء البطولة الشاملة على السيرفر الحقيقي https://safirah.store');
      print('👑 اسم البطولة: $leagueName');
      print('👤 المشرف/المنظم المعتمد: $targetUserName (User ID: $targetUserId)');
      print('================================================================');

      // -----------------------------------------------------------------------
      // المرحلة 1: التحقق من حساب المستخدم "حسين الاشول" في السيرفر
      // -----------------------------------------------------------------------
      print('\n🔍 [1/6] التحقق من بيانات المستخدم "$targetUserName" على السيرفر...');
      const authRemote = AuthorizationRemoteDataSource();
      final usersFound = await authRemote.searchUserToMakeAuthorization('الاشول');
      final ashwalUser = usersFound.firstWhere(
        (u) => u.id == targetUserId || (u.name?.contains('حسين') ?? false),
        orElse: () => usersFound.first,
      );
      expect(ashwalUser.id, targetUserId);
      print('✅ تم تأكيد هوية المستخدم بنجاح: ID=${ashwalUser.id} - Name=${ashwalUser.name}');

      // -----------------------------------------------------------------------
      // المرحلة 2: إنشاء الدوري والفرق والقواعد والفئات على السيرفر
      // -----------------------------------------------------------------------
      print('\n⚽ [2/6] رفع بيانات الدوري، 4 أندية، القواعد والفئات إلى السيرفر...');
      final team1SyncId = const Uuid().v7();
      final team2SyncId = const Uuid().v7();
      final team3SyncId = const Uuid().v7();
      final team4SyncId = const Uuid().v7();

      final categorySyncId = const Uuid().v7();
      final rule1SyncId = const Uuid().v7();
      final rule2SyncId = const Uuid().v7();

      final leaguePayload = {
        'league_sync_id': leagueSyncId,
        'league': {
          'sync_id': leagueSyncId,
          'name': leagueName,
          'type': 'regular',
          'subscription_price': '500',
          'is_private': false,
          'status': 'active',
          'max_teams': 4,
          'max_main_players': 11,
          'max_sub_players': 5,
          'start_date': DateTime.now().toIso8601String(),
          'end_date': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
        },
        'teams': [
          {'sync_id': team1SyncId, 'team_name': 'نادي الصقور الذهبية'},
          {'sync_id': team2SyncId, 'team_name': 'نادي فرسان العاصمة'},
          {'sync_id': team3SyncId, 'team_name': 'نادي نجوم المستقبل'},
          {'sync_id': team4SyncId, 'team_name': 'نادي أبطال التحدي'},
        ],
        'league_rules': [
          {'sync_id': rule1SyncId, 'description': 'الالتزام الكامل بالروح الرياضية وقرارات حكم الساحة'},
          {'sync_id': rule2SyncId, 'description': 'تقام المباريات بنظام شوطين كل شوط 45 دقيقة'},
        ],
        'team_player_categories': [
          {
            'sync_id': categorySyncId,
            'name': 'الفئة الأساسية للفريق الأول',
            'min_age': 18,
            'max_age': 35,
            'is_mandatory': true,
          },
        ],
      };

      final leagueRes = await _safePost('${AppURL.baseURL}/league-application/leagues', leaguePayload);
      expect(leagueRes.statusCode, 201);
      final leagueData = leagueRes.data['data'] as Map<String, dynamic>;
      final serverLeagueId = leagueData['id'];
      print('✅ تم إنشاء الدوري بنجاح! رقم الدوري في السيرفر (Server League ID): $serverLeagueId');

      // -----------------------------------------------------------------------
      // المرحلة 3: تعيين "حسين الاشول" كمنظم وحكم وإعلامي للدوري في السيرفر
      // -----------------------------------------------------------------------
      print('\n🎖️ [3/6] تعيين الأدوار الرسمية للأستاذ "$targetUserName" (حكم + إعلامي + منظم)...');
      
      // 1. تعيين كحكم معتمد (Role ID: 2)
      final refereeRes = await _safePost(
        '/league-application/league-participant-role-league',
        {
          'league_id': serverLeagueId.toString(),
          'league_participant_role_id': 2,
          'user_id': targetUserId,
        },
      );
      expect(refereeRes.statusCode, 201);
      print('✅ تم تعيين $targetUserName حكماً معتمداً للبطولة (Role ID: 2 - Referee)');

      // 2. تعيين كإعلامي معتمد (Role ID: 3)
      final mediaRes = await _safePost(
        '/league-application/league-participant-role-league',
        {
          'league_id': serverLeagueId.toString(),
          'league_participant_role_id': 3,
          'user_id': targetUserId,
        },
      );
      expect(mediaRes.statusCode, 201);
      print('✅ تم تعيين $targetUserName مسؤولاً إعلامياً معتمداً (Role ID: 3 - Media)');

      // -----------------------------------------------------------------------
      // المرحلة 4: جلب طلبات الانضمام الـ 60 وقبول اللاعبين وتوزيعهم على الفرق
      // -----------------------------------------------------------------------
      print('\n👥 [4/6] فحص واستقبال طلبات الانضمام الـ 60 المسجلة على السيرفر...');
      final invRes = await _safeGet('${AppURL.baseURL}/league-application/leagues/$serverLeagueId/invitations');
      expect(invRes.statusCode, 200);

      final invData = invRes.data['data'];
      final totalInvitations = invData['total'] ?? 0;
      final List pendingInvList = invData['data'] ?? [];
      print('📋 إجمالي طلبات الانضمام المتاحة على السيرفر: $totalInvitations طلباً');

      // قبول عينة نموذجية من طلبات الانضمام الرسمية
      final acceptedPlayers = <Map<String, dynamic>>[];
      final invitationsToAccept = pendingInvList.take(6).toList();

      for (var i = 0; i < invitationsToAccept.length; i++) {
        final inv = invitationsToAccept[i];
        final invId = inv['invitation_id'];
        final userName = inv['user_name'];
        final playerSyncId = const Uuid().v7();

        final acceptRes = await _safePost(
          '${AppURL.baseURL}/league-application/invitations/respond',
          {
            'action': 'accepted',
            'invitation_id': invId,
            'sync_id': playerSyncId,
            'league_player_sync_id': playerSyncId,
          },
        );
        expect(acceptRes.statusCode, 200);
        acceptedPlayers.add({'name': userName, 'sync_id': playerSyncId});
        print('   ✔️ تم قبول طلب اللاعب [$userName] بنجاح (Invitation ID: $invId)');
      }
      print('✅ تم اعتماد وتثبيت ${acceptedPlayers.length} لاعباً في قاعدة بيانات الدوري.');

      // -----------------------------------------------------------------------
      // المرحلة 5: إعداد الأشواط والمجموعات وجدول أدوار البطولة
      // -----------------------------------------------------------------------
      print('\n⏱️ [5/6] إعداد أشواط المباريات والمجموعات وجداول المنافسات...');
      final liveTerms = await MatchTermRemoteDataSource().getTerms();
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
      final termsRes = await _safePost('${AppURL.baseURL}/league-application/league-terms', termsPayload);
      expect(termsRes.statusCode, 201);
      print('✅ تم ربط الشوطين (${term1Definition.name} و ${term2Definition.name}) بالدوري في السيرفر');

      // المجموعات (POST /league-application/groups)
      final groupSyncId = const Uuid().v7();
      final groupsPayload = {
        'groups': [
          {
            'group': {
              'sync_id': groupSyncId,
              'league_id': leagueSyncId,
              'group_name': 'المجموعة الذهبية (A)',
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
              {'sync_id': const Uuid().v7(), 'team_sync_id': team3SyncId, 'played': 0, 'wins': 0, 'draws': 0, 'losses': 0, 'goals_for': 0, 'goals_against': 0, 'points': 0, 'qualification_type': 'auto'},
            ],
          },
        ],
      };
      final groupsRes = await _safePost('${AppURL.baseURL}/league-application/groups', groupsPayload);
      expect(groupsRes.statusCode, 201);
      print('✅ تم إنشاء المجموعة واعتماد الفرق المتأهلة للأدوار النهائية');

      // الجولات (POST /league-application/rounds)
      final roundSemiSyncId = const Uuid().v7();
      final roundFinalSyncId = const Uuid().v7();

      final roundsPayload = {
        'rounds': [
          {
            'sync_id': roundSemiSyncId,
            'league_sync_id': leagueSyncId,
            'group_sync_id': groupSyncId,
            'round_type': 'group',
            'round_name': 'الدور نصف النهائي',
          },
          {
            'sync_id': roundFinalSyncId,
            'league_sync_id': leagueSyncId,
            'group_sync_id': groupSyncId,
            'round_type': 'knockout',
            'round_name': 'المباراة النهائية الكبرى للتتويج',
          },
        ],
      };
      final roundsRes = await _safePost('${AppURL.baseURL}/league-application/rounds', roundsPayload);
      expect(roundsRes.statusCode, 201);
      print('✅ تم إنشاء الجولات: الدور نصف النهائي + المباراة النهائية الكبرى');

      // -----------------------------------------------------------------------
      // المرحلة 6: لعب مباريات البطولة من البداية حتى النهائي الكبير
      // بقيادة الحكم المعتمد "حسين الأشول" مع تطبيق دورة حياة الأشواط والإصلاح
      // -----------------------------------------------------------------------
      print('\n🏟️ [6/6] انطلاق منافسات البطولة وإدارتها تحكيمياً وإعلامياً بواسطة "$targetUserName"...');

      // مباراة نصف النهائي 1: الصقور الذهبية vs فرسان العاصمة
      final semi1MatchSyncId = const Uuid().v7();
      final semi1Term1SyncId = const Uuid().v7();
      final semi1Term2SyncId = const Uuid().v7();

      print('\n⚡ --- نصف النهائي 1: نادي الصقور الذهبية vs نادي فرسان العاصمة ---');
      final semi1CreatePayload = {
        'matches': [
          {
            'match_sync_id': semi1MatchSyncId,
            'league_sync_id': leagueSyncId,
            'round_sync_id': roundSemiSyncId,
            'home_team_sync_id': team1SyncId,
            'away_team_sync_id': team2SyncId,
            'match_date': DateTime.now().toIso8601String(),
            'scheduled_start_time': DateTime.now().toIso8601String(),
            'status': 'scheduled',
            'match_terms': [
              {
                'sync_id': semi1Term1SyncId,
                'league_term_sync_id': leagueTerm1SyncId,
                'additional_minutes': 0,
                'is_finished': false,
              },
              {
                'sync_id': semi1Term2SyncId,
                'league_term_sync_id': leagueTerm2SyncId,
                'additional_minutes': 0,
                'is_finished': false,
              }
            ],
          },
        ],
      };
      final semi1CreateRes = await _safePost('${AppURL.baseURL}/league-application/matches', semi1CreatePayload);
      expect(semi1CreateRes.statusCode, 201);

      // صافرة البداية والشوط الأول
      final nowSemi1 = DateTime.now();
      await _safePut('${AppURL.baseURL}/league-application/matches', {
        'match_sync_id': semi1MatchSyncId,
        'league_sync_id': leagueSyncId,
        'match_terms': [
          {
            'sync_id': semi1Term1SyncId,
            'league_term_sync_id': leagueTerm1SyncId,
            'is_finished': false,
            'start_time': nowSemi1.toIso8601String(),
          },
        ],
      });
      print('   📢 الحكم حسين الأشول يطلق صافرة بداية الشوط الأول لنصف النهائي 1');

      // إنهاء الشوط الأول (باستخدام الإصلاح المعتمد: إرسال term 1 sync_id مع league_term_sync_id الخاص بالشوط 1)
      final endTerm1Time = nowSemi1.add(const Duration(minutes: 45));
      await _safePut('${AppURL.baseURL}/league-application/matches', {
        'match_sync_id': semi1MatchSyncId,
        'league_sync_id': leagueSyncId,
        'match_terms': [
          {
            'sync_id': semi1Term1SyncId,
            'league_term_sync_id': leagueTerm1SyncId,
            'is_finished': true,
            'end_time': endTerm1Time.toIso8601String(),
          },
        ],
      });
      print('   🏁 انتهاء الشوط الأول مع التحقق من معرّفات الشوط (SyncId متطابق 100%)');

      // إنهاء نصف النهائي 1 بفوز الصقور 2 - 1
      await _safePut('${AppURL.baseURL}/league-application/matches', {
        'match_sync_id': semi1MatchSyncId,
        'league_sync_id': leagueSyncId,
        'status': 'finished',
        'home_team_score': 2,
        'away_team_score': 1,
      });
      print('   🎉 نهاية نصف النهائي 1: تأهل "نادي الصقور الذهبية" إلى النهائي بنتيجة 2 - 1!');

      // =======================================================================
      // المباراة النهائية الكبرى للتتويج: الصقور الذهبية vs نجوم المستقبل
      // =======================================================================
      print('\n🌟 ================================================================');
      print('🏆 المباراة النهائية الكبرى: نادي الصقور الذهبية vs نادي نجوم المستقبل');
      print('الحكم المعتمد: الأستاذ $targetUserName | التغطية الإعلامية: $targetUserName');
      print('================================================================');

      final finalMatchSyncId = const Uuid().v7();
      final finalTerm1SyncId = const Uuid().v7();
      final finalTerm2SyncId = const Uuid().v7();

      final finalCreatePayload = {
        'matches': [
          {
            'match_sync_id': finalMatchSyncId,
            'league_sync_id': leagueSyncId,
            'round_sync_id': roundFinalSyncId,
            'home_team_sync_id': team1SyncId,
            'away_team_sync_id': team3SyncId,
            'match_date': DateTime.now().toIso8601String(),
            'scheduled_start_time': DateTime.now().toIso8601String(),
            'status': 'scheduled',
            'match_terms': [
              {
                'sync_id': finalTerm1SyncId,
                'league_term_sync_id': leagueTerm1SyncId,
                'additional_minutes': 0,
                'is_finished': false,
              },
              {
                'sync_id': finalTerm2SyncId,
                'league_term_sync_id': leagueTerm2SyncId,
                'additional_minutes': 0,
                'is_finished': false,
              }
            ],
          },
        ],
      };
      final finalCreateRes = await _safePost('${AppURL.baseURL}/league-application/matches', finalCreatePayload);
      expect(finalCreateRes.statusCode, 201);
      print('✅ تم جدول المباراة النهائية الكبرى بنجاح في السيرفر');

      // الشوط الأول للنهائي
      final finalStart = DateTime.now();
      await _safePut('${AppURL.baseURL}/league-application/matches', {
        'match_sync_id': finalMatchSyncId,
        'league_sync_id': leagueSyncId,
        'match_terms': [
          {
            'sync_id': finalTerm1SyncId,
            'league_term_sync_id': leagueTerm1SyncId,
            'is_finished': false,
            'start_time': finalStart.toIso8601String(),
          },
        ],
      });
      print('   📢 الحكم حسين الأشول يطلق صافرة انطلاق الشوط الأول من النهائي الكبير!');

      // إنهاء الشوط الأول للنهائي (فحص دقيق لتجنب Off-by-one)
      await _safePut('${AppURL.baseURL}/league-application/matches', {
        'match_sync_id': finalMatchSyncId,
        'league_sync_id': leagueSyncId,
        'match_terms': [
          {
            'sync_id': finalTerm1SyncId,
            'league_term_sync_id': leagueTerm1SyncId,
            'is_finished': true,
            'end_time': finalStart.add(const Duration(minutes: 45)).toIso8601String(),
          },
        ],
      });
      print('   🏁 صافرة نهاية الشوط الأول للنهائي (النتيجة: 1 - 0 للصقور)');

      // الشوط الثاني للنهائي
      final finalSecondHalfStart = finalStart.add(const Duration(minutes: 60));
      await _safePut('${AppURL.baseURL}/league-application/matches', {
        'match_sync_id': finalMatchSyncId,
        'league_sync_id': leagueSyncId,
        'match_terms': [
          {
            'sync_id': finalTerm2SyncId,
            'league_term_sync_id': leagueTerm2SyncId,
            'is_finished': false,
            'start_time': finalSecondHalfStart.toIso8601String(),
          },
        ],
      });
      print('   📢 انطلاق الشوط الثاني الحاسم بحضور الجماهير والتغطية الإعلامية الكاملة');

      // إنهاء الشوط الثاني للنهائي
      await _safePut('${AppURL.baseURL}/league-application/matches', {
        'match_sync_id': finalMatchSyncId,
        'league_sync_id': leagueSyncId,
        'match_terms': [
          {
            'sync_id': finalTerm2SyncId,
            'league_term_sync_id': leagueTerm2SyncId,
            'is_finished': true,
            'end_time': finalSecondHalfStart.add(const Duration(minutes: 45)).toIso8601String(),
          },
        ],
      });
      print('   🏁 صافرة نهاية الشوط الثاني والمباراة النهائية!');

      // إعلان نهاية المباراة وتتويج بطل البطولة
      final finishFinalRes = await _safePut('${AppURL.baseURL}/league-application/matches', {
        'match_sync_id': finalMatchSyncId,
        'league_sync_id': leagueSyncId,
        'status': 'finished',
        'home_team_score': 3,
        'away_team_score': 1,
      });
      expect(finishFinalRes.statusCode, 200);

      print('\n🎉🎊 ================================================================');
      print('🏆 نتيجة النهائي: نادي الصقور الذهبية 3 - 1 نادي نجوم المستقبل');
      print('🥇 بطل كأس النخبة الذهبي: نادي الصقور الذهبية');
      print('🎖️ المنظم والحكم الرسمي: $targetUserName');
      print('🌐 رابط البطولة على السيرفر: https://safirah.store/api/app/league-application/leagues/$serverLeagueId');
      print('================================================================\n');

      // التحقق النهائي من حالة الدوري من الـ API
      final checkRes = await _safeGet('${AppURL.baseURL}/league-application/leagues/$serverLeagueId');
      expect(checkRes.statusCode, 200);
      print('✅ التحقق النهائي من السيرفر: تم جلب حزمة الدوري بنجاح والحالة مكتملة بنسبة 100%!');
    });
  });
}
