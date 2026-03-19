import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/database/safirah_database.dart';
import '../model/team_model.dart';
import '../service/team_player_draft_service.dart';
import '../../../../../core/network/errors/local_app_exception.dart';
import 'package:rxdart/rxdart.dart';

class TeamAndPlayerLocalDataSource {
  final Safirah db;
  final TeamPlayerDraftService _draftService;

  TeamAndPlayerLocalDataSource(this.db)
      : _draftService = const TeamPlayerDraftService();


Future<TeamModel?> updateTeam(TeamModel team) async {
    await (db.update(db.teams)..where((t) => t.syncId.equals(team.syncId)))
        .write(team.toCompanion());

    final updatedRow = await (db.select(db.teams)
      ..where((t) => t.syncId.equals(team.syncId)))
        .getSingleOrNull();

    return updatedRow != null ? TeamModel.fromEntity(updatedRow) : null;
  }

  Future<List<TeamModel>> getTeamsByLeague(String leagueSyncId) async {
    final rows = await (db.select(db.teams)
          ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
        .get();

    return rows.map((e) => TeamModel.fromEntity(e)).toList();
  }

  Future<List<LeaguePlayerModel>> getLeagueUsers(String leagueSyncId) async {
    //  await _repairDateTimeColumnsIfNeeded();
    final rows = await (db.select(db.leaguePlayers)
          ..where((t) => t.leagueSyncId.equals(leagueSyncId))
          ..orderBy([
            (t) => OrderingTerm.asc(t.createdAt),
            (t) => OrderingTerm.asc(t.id),
          ]))
        .get();

    return rows.map(LeaguePlayerModel.fromEntity).toList();
  }

  /// جلب لاعبي الدوري من الـ local لكن باستخدام leagueSyncId (بدل leagueId).
  Future<List<LeaguePlayerModel>> getLeagueUsersByLeague(
      String leagueSyncId) async {
    // First, run the one-time repair to fix any legacy string-based datetimes.
    //  await _repairDateTimeColumnsIfNeeded();

    // الخطوة 1: بشكل احترافي، نتحقق أولاً من وجود الدوري المطلوب.
    // هذا يمنع عمل join غير ضروري إذا كان الدوري غير موجود أصلاً.
    final league = await (db.select(db.leagues)
          ..where((l) => l.syncId.equals(leagueSyncId))
          ..limit(1))
        .getSingleOrNull();

    // الخطوة 2: إذا لم يتم العثور على الدوري، نرجع قائمة فارغة فورًا.
    if (league == null) {
      return [];
    }

    // الخطوة 3: الآن بعد التأكد من وجود الدوري، نقوم بجلب اللاعبين.
    final query = db.select(db.leaguePlayers)
      ..where((p) => p.leagueSyncId.equals(leagueSyncId))
      ..orderBy([
        (p) => OrderingTerm.asc(p.id),
      ]);

    final players = await query.get();

    return players.map(LeaguePlayerModel.fromEntity).toList();
  }

  Future<List<TeamPlayerCategoryModel>> getCategoriesByLeague(
      String leagueSyncId) async {
    final rows = await (db.select(db.teamPlayerCategories)
          ..where((t) => t.leagueSyncId.equals(leagueSyncId))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
    return rows.map(TeamPlayerCategoryModel.fromEntity).toList();
  }

  Future<int> setLeaguePlayerCategory({
    required int leaguePlayerId,
    required int categoryId,
  }) async {
    return (await (db.update(db.leaguePlayers)
          ..where((t) => t.id.equals(leaguePlayerId)))
        .write(LeaguePlayersCompanion(
      teamPlayerCategoryId: Value(categoryId),
      updatedAt: Value(DateTime.now()),
    )));
  }

  Future<int> deleteLeaguePlayerCategory({
    required int leaguePlayerId,
    required int categoryId,
  }) async {
    return (await (db.update(db.leaguePlayers)
          ..where((t) => t.id.equals(leaguePlayerId)))
        .write(LeaguePlayersCompanion(
      teamPlayerCategoryId: const Value(null),
      updatedAt: Value(DateTime.now()),
    )));
  }

  Future<List<LeaguePlayerModel>> getLeaguePlayersByCategory({
    required String leagueSyncId,
    required int categoryId,
  }) async {
    final rows = await (db.select(db.leaguePlayers)
          ..where((t) =>
              t.leagueSyncId.equals(leagueSyncId) &
              t.teamPlayerCategoryId.equals(categoryId)))
        .get();
    return rows.map((e) => LeaguePlayerModel.fromEntity(e)).toList();
  }

  Future<List<PlayerModel>> getPlayerTeam({
    required String teamSyncId,
  }) async {
    final rows = await (db.select(db.players)
          ..where((t) => t.teamSyncId.equals(teamSyncId)))
        .get();
    return rows.map((e) => PlayerModel.fromEntity(e)).toList();
  }

  Future<List<PlayerModel>> runDraft({
    required String leagueSyncId,
    int? seed,
  }) async {
    return db.transaction<List<PlayerModel>>(() async {
      // 1) فرق الدوري
      final teamRows = await (db.select(db.teams)
            ..where((t) => t.leagueSyncId.equals(leagueSyncId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();

      if (teamRows.isEmpty) return <PlayerModel>[];

      final teams = teamRows.map(TeamModel.fromEntity).toList();

      // 2) إعدادات الدوري (maxMainPlayers, maxSubPlayers)
      final leagueRow = await (db.select(db.leagues)
            ..where((l) => l.syncId.equals(leagueSyncId)))
          .getSingleOrNull();
      final maxMainPlayers = leagueRow?.maxMainPlayers ?? 0;
      final maxSubPlayers = leagueRow?.maxSubPlayers ?? 0;

      // 3) الفئات
      final catRows = await (db.select(db.teamPlayerCategories)
            ..where((c) => c.leagueSyncId.equals(leagueSyncId))
            ..orderBy([(c) => OrderingTerm.asc(c.id)]))
          .get();
      final categories =
          catRows.map(TeamPlayerCategoryModel.fromEntity).toList();

      // 4) لاعبو الدوري مصنفون حسب الفئة
      Future<List<LeaguePlayer>> fetchRaw(int? catId) async {
        final q = db.select(db.leaguePlayers)
          ..where((lp) => lp.leagueSyncId.equals(leagueSyncId));

        if (catId == null) {
          q.where((lp) => lp.teamPlayerCategoryId.isNull());
        } else {
          q.where((lp) => lp.teamPlayerCategoryId.equals(catId));
        }
        return q.get();
      }

      final Map<int?, List<LeaguePlayerModel>> leaguePlayersByCategory = {};

      final List<int?> catIds =
          catRows.isEmpty ? <int?>[null] : catRows.map((e) => e.id).toList();

      for (final catId in catIds) {
        final raw = await fetchRaw(catId);
        leaguePlayersByCategory[catId] =
            raw.map(LeaguePlayerModel.fromEntity).toList();
      }

      // 5) استدعاء منطق التوزيع في الخدمة (بدون أوامر DB)
      final logicalPlayers = _draftService.buildDraftPlayers(
        leagueSyncId: leagueSyncId,
        teams: teams,
        categories: categories,
        leaguePlayersByCategory: leaguePlayersByCategory,
        seed: seed,
        maxMainPlayers: maxMainPlayers,
        maxSubPlayers: maxSubPlayers,
      );
      if (logicalPlayers.isEmpty) return <PlayerModel>[];

      // 6) تخزين اللاعبين الناتجين في جدول players
      final inserted = <PlayerModel>[];
      for (final p in logicalPlayers) {
        // Defensive validation to avoid `!` null crashes.
        final teamSyncId = p.teamSyncId;
        if (teamSyncId == null || teamSyncId.isEmpty) {
          throw LocalAppException(
            message: 'runDraft: generated player without teamSyncId',
            title: '',
          );
        }
        final leaguePlayerSyncId = p.playerLeagueSyncId;
        if (leaguePlayerSyncId!.isEmpty) {
          throw LocalAppException(
            message: 'runDraft: generated player without playerLeagueSyncId',
            title: '',
          );
        }

        final generatedSyncId = p.syncId ?? const Uuid().v4();

        final newId = await db.into(db.players).insert(
              PlayersCompanion.insert(
                teamSyncId: teamSyncId,
                playerLeagueSyncId: leaguePlayerSyncId!,
                fullName: p.fullName ?? "",
                status: Value(p.status),
                syncId: generatedSyncId,
              ),
            );

        inserted.add(p.copyWith(id: newId, syncId: generatedSyncId));
      }

      return inserted;
    });
  }

  Future<List<PlayerModel>> assignPlayersToTeam({
    required String teamSyncId,
    required List<String> leaguePlayerSyncIds,
  }) async {
    if (leaguePlayerSyncIds.isEmpty) return <PlayerModel>[];

    return db.transaction<List<PlayerModel>>(() async {
      // الفريق لمعرفة leagueId
      final teamRow = await (db.select(db.teams)
            ..where((t) => t.syncId.equals(teamSyncId)))
          .getSingle();

      final leagueSyncId = teamRow.leagueSyncId;

      // إعدادات الدوري
      final leagueRow = await (db.select(db.leagues)
            ..where((l) => l.syncId.equals(leagueSyncId)))
          .getSingleOrNull();
      final maxMainPlayers = leagueRow?.maxMainPlayers ?? 0;
      final maxSubPlayers = leagueRow?.maxSubPlayers ?? 0;

      // عدّاد حالي من DB
      final existingPlayers = await (db.select(db.players)
            ..where((p) => p.teamSyncId.equals(teamSyncId)))
          .get();

      final currentMain =
          existingPlayers.where((p) => p.status == 'main').length;
      final currentSub = existingPlayers.where((p) => p.status == 'sub').length;

      // LeaguePlayers المطلوبين
      final lpRows = await (db.select(db.leaguePlayers)
            ..where((lp) => lp.syncId.isIn(leaguePlayerSyncIds)))
          .get();
      final leaguePlayers = lpRows.map(LeaguePlayerModel.fromEntity).toList();

      // استبعاد من لديهم سجل مسبق في players
      final existing = await (db.selectOnly(db.players)
            ..addColumns([db.players.playerLeagueSyncId])
            ..where(db.players.playerLeagueSyncId.isIn(leaguePlayerSyncIds)))
          .get();
      final taken = existing
          .map((r) => r.read<String>(db.players.playerLeagueSyncId)!)
          .toSet();

      // استخدام الخدمة لبناء اللاعبين منطقياً
      final logicalPlayers = _draftService.buildAssignPlayersToTeam(
        teamSyncId: teamSyncId,
        leagueSyncId: leagueSyncId,
        leaguePlayers: leaguePlayers,
        takenLeaguePlayerIds: taken,
        currentMain: currentMain,
        currentSub: currentSub,
        maxMainPlayers: maxMainPlayers,
        maxSubPlayers: maxSubPlayers,
      );

      if (logicalPlayers.isEmpty) return <PlayerModel>[];

      final inserted = <PlayerModel>[];
      for (final p in logicalPlayers) {
        if (taken.contains(p.playerLeagueSyncId)) continue;

        final newId = await db.into(db.players).insert(
              PlayersCompanion.insert(
                  playerLeagueSyncId: p.playerLeagueSyncId!,
                  teamSyncId: teamSyncId,
                  fullName: p.fullName ?? '',
                  status: Value(p.status),
                  syncId: const Uuid().v4()),
            );

        inserted.add(p.copyWith(id: newId));
      }

      return inserted;
    });
  }

  Future<void> upsertLeaguePlayers(List<LeaguePlayerModel> players) async {
    if (players.isEmpty) return;


    await db.transaction(() async {
      for (final p in players) {
        await db.into(db.leaguePlayers).insertOnConflictUpdate(
              LeaguePlayersCompanion(
                name: Value((p.name ?? '').trim()),
                syncId: Value(p.syncId),
                leagueSyncId: Value(p.leagueSyncId!),
                teamPlayerCategoryId: Value(p.teamPlayerCategoryId),
              ),
            );
      }
    });
  }
  // Future<void> upsertTeams(List<TeamModel> teams) async {
  //   if (teams.isEmpty) return;
  //
  //   await db.transaction(() async {
  //     for (final p in teams) {
  //       await db.into(db.teams).insertOnConflictUpdate(
  //         TeamsCompanion(
  //           teamName: Value((p.teamName ?? '').trim()),
  //           syncId: Value(p.syncId),
  //           leagueSyncId: Value(p.leagueSyncId!),
  //         ),
  //       );
  //       for (final p in p.player??[]) {
  //         await db.into(db.players).insertOnConflictUpdate(
  //           PlayersCompanion(
  //             fullName: Value((p.fullName ?? '').trim()),
  //             syncId: Value(p.syncId??''),
  //             teamSyncId: Value(p.teamSyncId??''),
  //             status: Value(p.status),
  //
  //             playerLeagueSyncId:  Value(p.playerLeagueSyncId??''),
  //           //  id: Value(p.id??0),
  //           ),
  //
  //         );
  //         print(p.fullName);
  //       }
  //
  //     }
  //   });
  // }


  Future<void> upsertTeams(List<TeamModel> teams) async {
    debugPrint('upsertTeams called: teams=${teams.length}');
    if (teams.isEmpty) return;

    try {
      await db.transaction(() async {
        debugPrint('transaction started');

        for (final team in teams) {
          debugPrint('team syncId=${team.syncId}');
          debugPrint(
              'team syncId=${team.syncId} players=${team.player?.length ?? 0}');

          // 1) Upsert team first
          try {
            await db.into(db.teams).insert(
              TeamsCompanion(
                syncId: Value(team.syncId),
                leagueSyncId: Value(team.leagueSyncId!),
                teamName: Value((team.teamName).trim()),
              ),
              onConflict: DoUpdate(
                (old) => TeamsCompanion(
                  leagueSyncId: Value(team.leagueSyncId!),
                  teamName: Value((team.teamName).trim()),
                  updatedAt: Value(DateTime.now()),
                ),
                target: [db.teams.syncId],
              ),
            );
          } catch (e, s) {
            debugPrint('TEAM UPSERT FAILED syncId=${team.syncId} err=$e');
            debugPrint('$s');
            rethrow;
          }

          // 2) Load league limits
          final leagueRow = await (db.select(db.leagues)
                ..where((l) =>
                    l.syncId.equals(team.leagueSyncId!) )
                ..limit(1))
              .getSingleOrNull();
          final maxMainPlayers = leagueRow?.maxMainPlayers ?? 0;
          final maxSubPlayers = leagueRow?.maxSubPlayers ?? 0;

          // 3) Load current counts from DB (to keep previously stored status)
          final existingPlayers = await (db.select(db.players)
                ..where((p) => p.teamSyncId.equals(team.syncId)))
              .get();
          var currentMain =
              existingPlayers.where((p) => p.status == 'main').length;
          var currentSub = existingPlayers.where((p) => p.status == 'sub').length;

          // 4) Upsert players with computed status
          for (final player in (team.player ?? [])) {
            final sid = (player.syncId ?? '').trim();
            if (sid.isEmpty) {
              debugPrint('PLAYER SKIPPED empty syncId name=${player.fullName}');
              continue;
            }

            // If player already exists, keep its current status.
            final existing = existingPlayers
                .where((p) => p.syncId == sid)
                .cast<dynamic>()
                .toList();

            String computedStatus;
            if (existing.isNotEmpty) {
              // keep existing status if it's main/sub, otherwise normalize below
              final s = (existingPlayers.firstWhere((p) => p.syncId == sid).status)
                  .trim()
                  .toLowerCase();
              computedStatus = (s == 'sub') ? 'sub' : 'main';
            } else {
              if (maxMainPlayers <= 0 && maxSubPlayers <= 0) {
                computedStatus = 'main';
              } else if (maxMainPlayers > 0 && currentMain < maxMainPlayers) {
                computedStatus = 'main';
                currentMain++;
              } else if (maxSubPlayers > 0 && currentSub < maxSubPlayers) {
                computedStatus = 'sub';
                currentSub++;
              } else {
                // out of capacity -> default to sub if configured, otherwise main
                computedStatus = maxSubPlayers > 0 ? 'sub' : 'main';
              }
            }

            try {
              await db.into(db.players).insert(
                PlayersCompanion(
                  syncId: Value(sid),
                  teamSyncId: Value((player.teamSyncId ?? '').trim()),
                  playerLeagueSyncId:
                      Value((player.playerLeagueSyncId ?? '').trim()),
                  fullName: Value((player.fullName ?? '').trim()),
                  status: Value(computedStatus),
                  updatedAt: Value(DateTime.now()),
                ),
                onConflict: DoUpdate(
                  (old) => PlayersCompanion(
                    teamSyncId: Value((player.teamSyncId ?? '').trim()),
                    playerLeagueSyncId:
                        Value((player.playerLeagueSyncId ?? '').trim()),
                    fullName: Value((player.fullName ?? '').trim()),
                    status: Value(computedStatus),
                    updatedAt: Value(DateTime.now()),
                  ),
                  target: [db.players.syncId],
                ),
              );

              final stored = await (db.select(db.players)
                    ..where((t) => t.syncId.equals(sid)))
                  .getSingleOrNull();

              debugPrint(stored == null
                  ? 'VERIFY FAILED: ${player.fullName} ($sid)'
                  : 'VERIFY OK: ${player.fullName} ($sid) status=$computedStatus');
            } catch (e, s) {
              debugPrint(
                  'PLAYER UPSERT FAILED sid=$sid name=${player.fullName} err=$e');
              debugPrint('$s');
            }
          }
        }

        debugPrint('transaction finished');
      });
    } catch (e, s) {
      debugPrint('upsertTeams FAILED err=$e');
      debugPrint('$s');
      rethrow;
    }

    debugPrint('upsertTeams done');
  }
  Future<bool> upsertPlayerAndVerify(PlayersCompanion companion, String syncId) async {
    try {
      await db.into(db.players).insert(
        companion,
        onConflict: DoUpdate(
              (old) => companion,
          target: [db.players.syncId], // عدّلها إذا عندك unique مركب
        ),
      );

      final stored = await (db.select(db.players)
        ..where((t) => t.syncId.equals(syncId)))
          .getSingleOrNull();

      return stored != null;
    } catch (_) {
      return false;
    }
  }
  Future<void> upsertPlayersTeam(List<PlayerModel> player) async {
    if (player.isEmpty) return;

   // print('Upserting ${player[0].syncId} league players locally.');
    await db.transaction(() async {
      // Group incoming players by team
      final byTeam = <String, List<PlayerModel>>{};
      for (final p in player) {
        final teamId = (p.teamSyncId ?? '').trim();
        if (teamId.isEmpty) continue;
        byTeam.putIfAbsent(teamId, () => <PlayerModel>[]).add(p);
      }

      for (final entry in byTeam.entries) {
        final teamSyncId = entry.key;
        final list = entry.value;

        // Read team to get leagueSyncId
        final teamRow = await (db.select(db.teams)
              ..where((t) => t.syncId.equals(teamSyncId))
              ..limit(1))
            .getSingleOrNull();
        final leagueSyncId = teamRow?.leagueSyncId;

        final leagueRow = leagueSyncId == null
            ? null
            : await (db.select(db.leagues)
                  ..where((l) => l.syncId.equals(leagueSyncId))
                  ..limit(1))
                .getSingleOrNull();
        final maxMainPlayers = leagueRow?.maxMainPlayers ?? 0;
        final maxSubPlayers = leagueRow?.maxSubPlayers ?? 0;

        // Existing players for this team
        final existingPlayers = await (db.select(db.players)
              ..where((p) => p.teamSyncId.equals(teamSyncId)))
            .get();

        var currentMain =
            existingPlayers.where((p) => p.status == 'main').length;
        var currentSub = existingPlayers.where((p) => p.status == 'sub').length;

        for (final p in list) {
          final sid = (p.syncId ?? '').trim();
          if (sid.isEmpty) continue;

          final already = existingPlayers.any((e) => e.syncId == sid);

          String computedStatus;
          if (already) {
            final s = existingPlayers
                .firstWhere((e) => e.syncId == sid)
                .status
                .trim()
                .toLowerCase();
            computedStatus = (s == 'sub') ? 'sub' : 'main';
          } else {
            if (maxMainPlayers <= 0 && maxSubPlayers <= 0) {
              computedStatus = 'main';
            } else if (maxMainPlayers > 0 && currentMain < maxMainPlayers) {
              computedStatus = 'main';
              currentMain++;
            } else if (maxSubPlayers > 0 && currentSub < maxSubPlayers) {
              computedStatus = 'sub';
              currentSub++;
            } else {
              computedStatus = maxSubPlayers > 0 ? 'sub' : 'main';
            }
          }

          await db.into(db.players).insertOnConflictUpdate(
                PlayersCompanion(
                  fullName: Value((p.fullName ?? '').trim()),
                  syncId: Value(sid),
                  teamSyncId: Value(teamSyncId),
                  status: Value(computedStatus),
                  playerLeagueSyncId: Value((p.playerLeagueSyncId ?? '').trim()),
                  id: p.id == null ? const Value.absent() : Value(p.id!),
                  updatedAt: Value(DateTime.now()),
                ),
              );
        }
      }
    });
  }
  Future<List<LeaguePlayerModel>> leaguePlayersWithoutCategory(
      String leagueSyncId) async {
    // await _repairDateTimeColumnsIfNeeded();
    final rows = await (db.select(db.leaguePlayers)
          ..where((lp) =>
              lp.leagueSyncId.equals(leagueSyncId) &
              lp.teamPlayerCategoryId.isNull())
          ..orderBy([
            (lp) => OrderingTerm.asc(lp.createdAt),
            (lp) => OrderingTerm.asc(lp.id)
          ]))
        .get();
    return rows.map(LeaguePlayerModel.fromEntity).toList();
  }

  Future<List<LeaguePlayerModel>> leaguePlayersWithoutTeam(
      String leagueSyncId) async {
    final q = db.select(db.leaguePlayers).join([
      leftOuterJoin(db.players,
          db.players.playerLeagueSyncId.equalsExp(db.leaguePlayers.syncId)),
    ])
      ..where(db.leaguePlayers.leagueSyncId.equals(leagueSyncId) &
          db.players.id.isNull())
      ..orderBy([
        OrderingTerm.asc(db.leaguePlayers.createdAt),
        OrderingTerm.asc(db.leaguePlayers.id),
      ]);

    final result = await q.get();
    return result
        .map((row) => row.readTable(db.leaguePlayers))
        .map(LeaguePlayerModel.fromEntity)
        .toList();
  }

  Future<void> addLeaguePlayer(LeaguePlayerModel player) async {
    final leagueSyncId = player.leagueSyncId;
    if (leagueSyncId == null || leagueSyncId.trim().isEmpty) return;
    if (player.syncId.trim().isEmpty) return;
    final leagueRow = await (db.select(db.leagues)
          ..where((l) => l.syncId.equals(leagueSyncId))
          ..limit(1))
        .getSingleOrNull();
    if (leagueRow == null) return;
    final maxTeams = leagueRow.maxTeams ?? 0;
    final maxMainPlayers = leagueRow.maxMainPlayers ?? 0;
    final maxSubPlayers = leagueRow.maxSubPlayers ?? 0;

    final maxPlayersPerTeam = (maxMainPlayers + maxSubPlayers);
    final capacity = maxTeams * maxPlayersPerTeam;

    if (capacity > 0) {
      // 2) عدّ اللاعبين الحاليين في الدوري (league_players)
      final countExp = db.leaguePlayers.syncId.count();
      final countQuery = db.selectOnly(db.leaguePlayers)
        ..addColumns([countExp])
        ..where(db.leaguePlayers.leagueSyncId.equals(leagueSyncId));

      final row = await countQuery.getSingle();
      final currentCount = row.read(countExp) ?? 0;

      // 3) إذا وصلنا للسعة، نرفض الإضافة برسالة واضحة
      if (currentCount >= capacity) {
        throw LocalAppException.userMessage(
            'عدد اللاعبين المسموح للدوري اكتمل');
      }
    }

    // 4) إدخال / تحديث اللاعب
    await db.into(db.leaguePlayers).insertOnConflictUpdate(
          LeaguePlayersCompanion(
            syncId: Value(player.syncId),
            leagueSyncId: Value(leagueSyncId),
            name: Value(player.name),
            teamPlayerCategoryId: Value(player.teamPlayerCategoryId),
          ),
        );
  }

  Future<int> deleteLeaguePlayerBySyncId(String playerSyncId) async {
    if (playerSyncId.trim().isEmpty) return 0;
    return (db.delete(db.leaguePlayers)
          ..where((t) => t.syncId.equals(playerSyncId)))
        .go();
  }


  Stream<List<LeaguePlayerModel>> watchLeaguesPlayer({
  required  String leagueSyncId
  }) {
    final leaguePlayerTrigger = (db.select(db.leaguePlayers)
      ..where((r) => r.leagueSyncId.equals(leagueSyncId)))
        .watch()
        .map((_) => null);
    // ✅ debounced rebuild لتجنب كثرة إعادة البناء أثناء التحديثات
    return MergeStream([leaguePlayerTrigger]).startWith(null)
        .debounceTime(const Duration(milliseconds: 120))
        .asyncMap((_) => getLeagueUsersByLeague(
   leagueSyncId
    ));
  }
  Stream<List<TeamModel>> watchTeams({
    required  String leagueSyncId
  }) {
    final teamsTrigger = (db.select(db.teams)
      ..where((r) => r.leagueSyncId.equals(leagueSyncId)))
        .watch()
        .map((_) => null);
    // ✅ debounced rebuild لتجنب كثرة إعادة البناء أثناء التحديثات
    return MergeStream([teamsTrigger]).startWith(null)
        .debounceTime(const Duration(milliseconds: 120))
        .asyncMap((_) => getTeamsByLeague(
        leagueSyncId
    ));
  }
}
