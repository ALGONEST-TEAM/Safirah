import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/database/safirah_database.dart';
import '../model/team_model.dart';
import '../service/team_player_draft_service.dart';
import '../../../../../core/network/errors/local_app_exception.dart';
import 'package:rxdart/rxdart.dart';

class TeamAndPlayerLocalDataSource {
  final Safirah db;
  final TeamPlayerDraftService _draftService;
  bool _hasRepairedDateTimes = false;

  TeamAndPlayerLocalDataSource(this.db)
      : _draftService = const TeamPlayerDraftService();

  /// A one-time, best-effort repair for legacy rows where datetimes were stored as text.
  // Future<void> _repairDateTimeColumnsIfNeeded() async {
  //   if (_hasRepairedDateTimes) return;
  //
  //   try {
  //     // ISO strings look like: 2026-01-20T...
  //     // Using LIKE is more reliable than typeof() for this check.
  //     const isoLikePattern = "____-__-__T%";
  //
  //     Future<void> repair(String column) async {
  //       final badRows = await db.customSelect(
  //         'SELECT id, $column AS value FROM league_players WHERE $column LIKE ?',
  //         variables: [Variable.withString(isoLikePattern)],
  //       ).get();
  //
  //       for (final row in badRows) {
  //         final id = row.data['id'];
  //         final textValue = row.data['value'];
  //         if (id is! int || textValue is! String) continue;
  //
  //         final dt = DateTime.tryParse(textValue);
  //         if (dt == null) continue;
  //
  //         await db.customUpdate(
  //           'UPDATE league_players SET $column = ? WHERE id = ?',
  //           variables: [
  //             Variable.withInt(dt.millisecondsSinceEpoch),
  //             Variable.withInt(id),
  //           ],
  //         );
  //       }
  //     }
  //
  //     await repair('created_at');
  //     await repair('updated_at');
  //   } finally {
  //     // Ensure this runs only once per instance to avoid performance hits.
  //     _hasRepairedDateTimes = true;
  //   }
  // }

Future<TeamModel?> updateTeam(TeamModel team) async {
    await (db.update(db.teams)..where((t) => t.id.equals(team.id!)))
        .write(team.toCompanion());

    final updatedRow = await (db.select(db.teams)
      ..where((t) => t.id.equals(team.id!)))
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

    print('Upserting ${players[0].leagueSyncId} league players locally.');
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
  Future<void> upsertTeams(List<TeamModel> teams) async {
    if (teams.isEmpty) return;

    print('Upserting ${teams[0].syncId} league players locally.');
    await db.transaction(() async {
      for (final p in teams) {
        await db.into(db.teams).insertOnConflictUpdate(
          TeamsCompanion(
            teamName: Value((p.teamName ?? '').trim()),
            syncId: Value(p.syncId),
            leagueSyncId: Value(p.leagueSyncId!),
          ),
        );
        for (final p in p.player!) {
          await db.into(db.players).insertOnConflictUpdate(
            PlayersCompanion(
              fullName: Value((p.fullName ?? '').trim()),
              syncId: Value(p.syncId!),
              teamSyncId: Value(p.teamSyncId!),
              status: Value(p.status),
              //playerLeagueSyncId:  Value(p.playerLeagueSyncId!),
              id: Value(p.id!),
            ),
          );
        }

      }
    });
  }

  Future<void> upsertPlayersTeam(List<PlayerModel> player) async {
    if (player.isEmpty) return;

    print('Upserting ${player[0].syncId} league players locally.');
    await db.transaction(() async {
      for (final p in player) {
        await db.into(db.players).insertOnConflictUpdate(
          PlayersCompanion(
            fullName: Value((p.fullName ?? '').trim()),
            syncId: Value(p.syncId!),
            teamSyncId: Value(p.teamSyncId!),
            status: Value(p.status),
            playerLeagueSyncId:  Value(p.playerLeagueSyncId!),
            id: Value(p.id!),
          ),
        );
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
