import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:safirah/core/database/table/sync_queue_table.dart';
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
    Terms,
    LeagueTerms,
    MatchTerms,
    MatchTermPause,
    Warnings,
    Goals,
    Assists,
    PlayerMatchParticipation
  ],
)
class Safirah extends _$Safirah {
  Safirah._(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 6; // ارفع الرقم

  static Future<Safirah> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'safirah.sqlite'));
    return Safirah._(NativeDatabase.createInBackground(file));
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      // ✅ بعد إنشاء الجداول لأول مرة
      final termsSource = MatchTermsEventLocalDataSource(this);
      await termsSource.seedDefaultTerms();
    },
    onUpgrade: (m, from, to) async {
      // من نسخ قديمة لا تحتوي على league_id في team_player_categories
      if (from < 4) {
        // إسقاط الجدول القديم وإعادة إنشائه مع العمود والقيود الصحيحة
        await m.deleteTable('team_player_categories');
        await m.createTable(teamPlayerCategories);
      }
    },
  );
}

