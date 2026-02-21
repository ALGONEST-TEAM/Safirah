import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:safirah/core/database/table/sync_queue_table.dart';
import '../../features/authorization/data/data_source/table/users_has_role_table.dart';
import '../../features/leagues_mangement/match_term_event/data/data_source/table/knockout_prograss_lock_table.dart';
import '../../features/leagues_mangement/match_term_event/data/data_source/table/league_knockout_flags_table.dart';
import 'table/pagination_meta_table.dart';
import '../../features/leagues_mangement/group/data/data_source/table/group_table.dart';
import '../../features/leagues_mangement/group/data/data_source/table/group_team_table.dart';
import '../../features/leagues_mangement/group/data/data_source/table/qualified_team_table.dart';
import '../../features/leagues_mangement/leagues/data/data_source/table/league_status_table.dart';
import '../../features/leagues_mangement/leagues/data/data_source/table/leagues_table.dart';
import '../../features/leagues_mangement/leagues/data/data_source/table/rule_league_table.dart';
import '../../features/leagues_mangement/match/data/data_source/table/matches_table.dart';
import '../../features/leagues_mangement/match/data/data_source/table/round_table.dart';
import '../../features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_term_data_source.dart';
import '../../features/leagues_mangement/match_term_event/data/data_source/table/assist_table.dart';
import '../../features/leagues_mangement/match_term_event/data/data_source/table/goal_table.dart';
import '../../features/leagues_mangement/match_term_event/data/data_source/table/league_terms_table.dart';
import '../../features/leagues_mangement/match_term_event/data/data_source/table/match_term_pause_table.dart';
import '../../features/leagues_mangement/match_term_event/data/data_source/table/match_terms_table.dart';
import '../../features/leagues_mangement/match_term_event/data/data_source/table/player_match_participation_table.dart';
import '../../features/leagues_mangement/match_term_event/data/data_source/table/terms_table.dart';
import '../../features/leagues_mangement/match_term_event/data/data_source/table/warnings.dart';
import '../../features/leagues_mangement/team_and_player/data/data_source/table/league_players_table.dart';
import '../../features/leagues_mangement/team_and_player/data/data_source/table/players_table.dart';
import '../../features/leagues_mangement/team_and_player/data/data_source/table/save_cat_player.dart';
import '../../features/leagues_mangement/team_and_player/data/data_source/table/team_player_categories_table.dart';
import '../../features/leagues_mangement/team_and_player/data/data_source/table/teams_table.dart';
import '../../features/authorization/data/data_source/table/user_league_permissions_table.dart';

part 'safirah_database.g.dart';

@DriftDatabase(
  tables: [
    Leagues,
    LeagueRules,
    Teams,
    Players,
    TeamPlayerCategories,
    LeaguePlayers,
    DraftProgress,
    SyncQueue,
    Group,
    GroupTeam,
    Matches,
    Rounds,
    QualifiedTeam,
    LeagueStatus,
    // Replace feature-specific pagination meta with a generic app-wide table.
    PaginationMeta,
    // LeaguesPaginationMeta, // deprecated (kept only for migration)
    Terms,
    LeagueTerms,
    MatchTerms,
    MatchTermPause,
    Warnings,
    Goals,
    Assists,
    PlayerMatchParticipation,
    UsersHasRole,
    LeagueKnockoutFlags,
    KnockoutProgressLocks,
    // Authorization (Roles & Permissions)

    UserLeaguePermissions,
  ],
)
class Safirah extends _$Safirah {
  Safirah._(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 18;

  static Future<Safirah> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'safirah.sqlite'));
    return Safirah._(NativeDatabase.createInBackground(file));
  }

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // ✅ بعد إنشاء الجداول لأول مرة
          final termsSource = MatchTermsEventLocalDataSource(this);
          await termsSource.seedDefaultTerms();

          // ملاحظة: roles/permissions سيتم تنزيلها من الـ API لاحقاً.
        },
        onUpgrade: (m, from, to) async {
          // من نسخ قديمة لا تحتوي على league_id في team_player_categories
          if (from < 4) {
            // إسقاط الجدول القديم وإعادة إنشائه مع العمود والقيود الصحيحة
            await m.deleteTable('team_player_categories');
            await m.createTable(teamPlayerCategories);
          }

          // إضافة أعمدة نظام المزامنة (schema v7)
          if (from < 7) {
            await m.addColumn(syncQueue, syncQueue.status);
            await m.addColumn(syncQueue, syncQueue.attemptCount);
            await m.addColumn(syncQueue, syncQueue.lastError);
            await m.addColumn(syncQueue, syncQueue.lastAttemptAt);

            // تعبئة status بناءً على synced للموجود سابقاً
            await customStatement(
              "UPDATE sync_queue SET status = CASE WHEN synced = 1 THEN 'synced' ELSE 'pending' END",
            );
          }

          if (from < 8) {
            await m.addColumn(leagues, leagues.syncId);

            // تعبئة قيمة افتراضية فريدة للسجلات القديمة.
            // SQLite لا يملك UUID() افتراضيًا، فنضع قيمة تعتمد على id + timestamp.
            // (يكفي كمؤقت لمنع التعارض محليًا، والأفضل لاحقًا توليد UUID حقيقي عبر كود Dart في migration مخصصة.)
            await customStatement(
              "UPDATE leagues SET sync_id = 'legacy-' || id || '-' || strftime('%s','now') WHERE sync_id IS NULL OR sync_id = ''",
            );
          }

          // إضافة sync_id للجداول الأخرى (schema v9)
          if (from < 9) {
            await m.addColumn(teams, teams.syncId);
            await m.addColumn(
                teamPlayerCategories, teamPlayerCategories.syncId);
            await m.addColumn(leagueRules, leagueRules.syncId);

            await customStatement(
              "UPDATE teams SET sync_id = 'legacy-' || id || '-' || strftime('%s','now') WHERE sync_id IS NULL OR sync_id = ''",
            );
            await customStatement(
              "UPDATE team_player_categories SET sync_id = 'legacy-' || id || '-' || strftime('%s','now') WHERE sync_id IS NULL OR sync_id = ''",
            );
            await customStatement(
              "UPDATE league_rules SET sync_id = 'legacy-' || id || '-' || strftime('%s','now') WHERE sync_id IS NULL OR sync_id = ''",
            );
          }

          // إضافة نظام الأدوار والصلاحيات (schema v10)
          // إضافة جدول صلاحيات المستخدم داخل الدوري (schema v11)
          if (from < 11) {
            await m.createTable(this.userLeaguePermissions);
          }

          // إضافة جدول مفاتيح أدوار المستخدم داخل الدوري (schema v12)

          // إضافة sync_id لجدول league_players (schema v13)
          if (from < 13) {
            // drift expects a GeneratedColumn from the tableInfo instance
            await m.addColumn(leaguePlayers, leaguePlayers.syncId);

            await customStatement(
              "UPDATE league_players SET sync_id = 'legacy-' || id || '-' || strftime('%s','now') WHERE sync_id IS NULL OR sync_id = ''",
            );
          }

          // إضافة league_sync_id لجدولي teams و team_player_categories (schema v14)
          if (from < 14) {
            // ملاحظة: نستخدم ALTER TABLE مباشرة لتجنب الا��تماد على drift codegen قبل تحديثه.
            await customStatement(
              "ALTER TABLE teams ADD COLUMN league_sync_id TEXT NULL REFERENCES leagues(sync_id) ON DELETE CASCADE",
            );
            await customStatement(
              "ALTER TABLE team_player_categories ADD COLUMN league_sync_id TEXT NULL REFERENCES leagues(sync_id) ON DELETE CASCADE",
            );

            // تعبئة league_sync_id من leagues.sync_id بناء على league_id
            await customStatement(
              "UPDATE teams SET league_sync_id = (SELECT sync_id FROM leagues WHERE leagues.id = teams.league_id) WHERE league_sync_id IS NULL OR league_sync_id = ''",
            );

            await customStatement(
              "UPDATE team_player_categories SET league_sync_id = (SELECT sync_id FROM leagues WHERE leagues.id = team_player_categories.league_id) WHERE league_sync_id IS NULL OR league_sync_id = ''",
            );

            await customStatement(
              "UPDATE league_players SET league_sync_id = (SELECT sync_id FROM leagues WHERE leagues.id = league_players.league_id) WHERE league_sync_id IS NULL OR league_sync_id = ''",
            );
          }

          // إضافة entity_sync_id لجدول sync_queue (schema v15)
          // تم إلغاؤها حالياً، لأن syncId يتم تمريره داخل payload.
          // if (from < 15) {
          //   await customStatement(
          //     "ALTER TABLE sync_queue ADD COLUMN entity_sync_id TEXT NULL",
          //   );
          // }

          if (from < 16) {
            //await m.createTable(leaguesPaginationMeta);
          }

          // v17: Introduce generic pagination_meta and migrate leagues metadata into it.
          if (from < 17) {
            await m.createTable(paginationMeta);

            // Migrate existing leagues pagination meta if present.
            // resource='leagues', scope='private'/'public'
            await customStatement('''
INSERT OR REPLACE INTO pagination_meta
  (resource, scope, key, parent_key, last_page, per_page, total, updated_at)
SELECT
  'leagues' AS resource,
  CASE WHEN is_private = 1 THEN 'private' ELSE 'public' END AS scope,
  NULL AS key,
  NULL AS parent_key,
  last_page,
  per_page,
  total,
  updated_at
FROM leagues_pagination_meta;
''');

            // Ensure no duplicate meta rows exist (keep newest per dimension)
            await customStatement('''
DELETE FROM pagination_meta
WHERE id NOT IN (
  SELECT MAX(id)
  FROM pagination_meta
  GROUP BY resource, scope, key, parent_key
);
''');

            // Drop old table to avoid future confusion.
            await m.deleteTable('leagues_pagination_meta');
          }

          // v18: Fix league_players uniqueness to be per-league (league_sync_id, sync_id).
          if (from < 18) {
            // Rebuild table so the UNIQUE constraint is applied.
            await customStatement('PRAGMA foreign_keys=OFF;');

            await customStatement('''
CREATE TABLE league_players_new (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  sync_id TEXT NOT NULL,
  name TEXT NULL,
  code TEXT NULL,
  league_sync_id TEXT NOT NULL REFERENCES leagues(sync_id) ON DELETE CASCADE,
  team_player_category_id INTEGER NULL REFERENCES team_player_categories(id) ON DELETE SET NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(league_sync_id, sync_id)
);
''');

            await customStatement('''
INSERT INTO league_players_new (id, sync_id, name, code, league_sync_id, team_player_category_id, created_at, updated_at)
SELECT id, sync_id, name, code, league_sync_id, team_player_category_id, created_at, updated_at
FROM league_players;
''');

            await customStatement('DROP TABLE league_players;');
            await customStatement(
                'ALTER TABLE league_players_new RENAME TO league_players;');

            await customStatement('PRAGMA foreign_keys=ON;');
          }
        },
      );
}
