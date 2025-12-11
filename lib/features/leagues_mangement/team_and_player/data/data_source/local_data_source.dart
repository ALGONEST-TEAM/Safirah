import 'package:drift/drift.dart';
import '../../../../../core/database/safirah_database.dart';
import '../model/team_model.dart';
import '../service/team_player_draft_service.dart';

class TeamAndPlayerLocalDataSource {
  final Safirah db;
  final TeamPlayerDraftService _draftService;

  TeamAndPlayerLocalDataSource(this.db)
      : _draftService = const TeamPlayerDraftService();

  Future<void> updateTeam(TeamModel team) async {
    await (db.update(db.teams)..where((t) => t.id.equals(team.id!)))
        .write(team.toCompanion());
  }

  Future<List<TeamModel>> getTeamsByLeague(int leagueId) async {
    final rows = await (db.select(db.teams)
      ..where((t) => t.leagueId.equals(leagueId)))
        .get();

    return rows.map((e) => TeamModel.fromEntity(e)).toList();
  }

  Future<List<LeaguePlayerModel>> getLeagueUsers(int leagueId) async {
    final rows = await (db.select(db.leaguePlayers)
      ..where((t) => t.leagueId.equals(leagueId))
      ..orderBy([
            (t) => OrderingTerm.asc(t.createdAt),
            (t) => OrderingTerm.asc(t.id),
      ]))
        .get();

    return rows.map(LeaguePlayerModel.fromEntity).toList();
  }

  Future<List<TeamPlayerCategoryModel>> getCategoriesByLeague(
      int leagueId) async {
    final rows = await (db.select(db.teamPlayerCategories)
      ..where((t) => t.leagueId.equals(leagueId))
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
    required int leagueId,
    required int categoryId,
  }) async {
    final rows = await (db.select(db.leaguePlayers)
      ..where((t) =>
      t.leagueId.equals(leagueId) &
      t.teamPlayerCategoryId.equals(categoryId)))
        .get();
    return rows.map((e) => LeaguePlayerModel.fromEntity(e)).toList();
  }

  Future<List<PlayerModel>> getPlayerTeam({
    required int teamId,
  }) async {
    final rows = await (db.select(db.players)
      ..where((t) => t.teamId.equals(teamId)))
        .get();
    return rows.map((e) => PlayerModel.fromEntity(e)).toList();
  }


  Future<List<PlayerModel>> runDraft({
    required int leagueId,
    int? seed,
  }) async {
    return db.transaction<List<PlayerModel>>(() async {
      // 1) فرق الدوري
      final teamRows = await (db.select(db.teams)
            ..where((t) => t.leagueId.equals(leagueId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();
      if (teamRows.isEmpty) return <PlayerModel>[];

      final teams = teamRows.map(TeamModel.fromEntity).toList();

      // 2) إعدادات الدوري (maxMainPlayers, maxSubPlayers)
      final leagueRow = await (db.select(db.leagues)
            ..where((l) => l.id.equals(leagueId)))
          .getSingleOrNull();
      final maxMainPlayers = leagueRow?.maxMainPlayers ?? 0;
      final maxSubPlayers = leagueRow?.maxSubPlayers ?? 0;

      // 3) الفئات
      final catRows = await (db.select(db.teamPlayerCategories)
            ..where((c) => c.leagueId.equals(leagueId))
            ..orderBy([(c) => OrderingTerm.asc(c.id)]))
          .get();
      final categories =
          catRows.map(TeamPlayerCategoryModel.fromEntity).toList();

      // 4) لاعبو الدوري مصنفون حسب الفئة
      Future<List<LeaguePlayer>> fetchRaw(int? catId) async {
        final q = db.select(db.leaguePlayers)
          ..where((lp) => lp.leagueId.equals(leagueId));
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
        leagueId: leagueId,
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
        final newId = await db.into(db.players).insert(
              PlayersCompanion.insert(
                playerLeagueId: p.playerLeagueId,
                teamId: Value(p.teamId!),
                fullName: p.fullName,
                status: Value(p.status ?? 'main'),
              ),
            );

        inserted.add(p.copyWith(id: newId));
      }

      return inserted;
    });
  }

  Future<List<PlayerModel>> assignPlayersToTeam({
    required int teamId,
    required List<int> leaguePlayerIds,
  }) async {
    if (leaguePlayerIds.isEmpty) return <PlayerModel>[];

    return db.transaction<List<PlayerModel>>(() async {
      // الفريق لمعرفة leagueId
      final teamRow = await (db.select(db.teams)
            ..where((t) => t.id.equals(teamId)))
          .getSingle();

      final leagueId = teamRow.leagueId;

      // إعدادات الدوري
      final leagueRow = await (db.select(db.leagues)
            ..where((l) => l.id.equals(leagueId)))
          .getSingleOrNull();
      final maxMainPlayers = leagueRow?.maxMainPlayers ?? 0;
      final maxSubPlayers = leagueRow?.maxSubPlayers ?? 0;

      // عدّاد حالي من DB
      final existingPlayers = await (db.select(db.players)
            ..where((p) => p.teamId.equals(teamId)))
          .get();

      final currentMain =
          existingPlayers.where((p) => p.status == 'main').length;
      final currentSub = existingPlayers.where((p) => p.status == 'sub').length;

      // LeaguePlayers المطلوبين
      final lpRows = await (db.select(db.leaguePlayers)
            ..where((lp) => lp.id.isIn(leaguePlayerIds)))
          .get();
      final leaguePlayers =
          lpRows.map(LeaguePlayerModel.fromEntity).toList();

      // استبعاد من لديهم سجل مسبق في players
      final existing = await (db.selectOnly(db.players)
            ..addColumns([db.players.playerLeagueId])
            ..where(db.players.playerLeagueId.isIn(leaguePlayerIds)))
          .get();
      final taken = existing
          .map((r) => r.read<int>(db.players.playerLeagueId)!)
          .toSet();

      // استخدام الخدمة لبناء اللاعبين منطقياً
      final logicalPlayers = _draftService.buildAssignPlayersToTeam(
        teamId: teamId,
        leagueId: leagueId,
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
        if (taken.contains(p.playerLeagueId)) continue;

        final newId = await db.into(db.players).insert(
              PlayersCompanion.insert(
                playerLeagueId: p.playerLeagueId,
                teamId: Value(teamId),
                fullName: p.fullName,
                status: Value(p.status ?? 'main'),
              ),
            );

        inserted.add(p.copyWith(id: newId));
      }

      return inserted;
    });
  }

  Future<List<LeaguePlayerModel>> leaguePlayersWithoutCategory(
      int leagueId) async {
    final rows = await (db.select(db.leaguePlayers)
      ..where((lp) => lp.leagueId.equals(leagueId) &
          lp.teamPlayerCategoryId.isNull())
      ..orderBy([
            (lp) => OrderingTerm.asc(lp.createdAt),
            (lp) => OrderingTerm.asc(lp.id)
      ]))
        .get();
    return rows.map(LeaguePlayerModel.fromEntity).toList();
  }

  // --- لاعبو الدوري بدون فريق ---
  Future<List<LeaguePlayerModel>> leaguePlayersWithoutTeam(int leagueId) async {
    final q = db.select(db.leaguePlayers).join([
      leftOuterJoin(
          db.players, db.players.playerLeagueId.equalsExp(db.leaguePlayers.id)),
    ])
      ..where(db.leaguePlayers.leagueId.equals(leagueId) &
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
}

