import 'package:drift/drift.dart';
import 'package:safirah/core/database/safirah_database.dart';

import '../model/user_has_role_model.dart';

class AuthorizationLocalDataSource {
  final Safirah db;
  const AuthorizationLocalDataSource(this.db);

  // ---------------- UserLeaguePermissions ----------------
  Future<void> replaceLeaguePermissions({
    required String leagueSyncId,
    required List<String> permissionKeys,
    required String Function() syncIdFactory,
  }) async {
    final cleaned = permissionKeys
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();

    await (db.delete(db.userLeaguePermissions)
          ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
        .go();

    if (cleaned.isEmpty) return;

    await db.batch((b) {
      b.insertAll(
        db.userLeaguePermissions,
        cleaned
            .map(
              (k) => UserLeaguePermissionsCompanion.insert(
                syncId: syncIdFactory(),
                leagueSyncId: leagueSyncId,
                permissionKey: k,
              ),
            )
            .toList(),
      );
    });

  }

  Stream<Set<String>> watchLeaguePermissionKeys({
    required String leagueSyncId,
  }) {
    return (db.select(db.userLeaguePermissions)
          ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
        .watch()
        .map((rows) => rows.map((e) => e.permissionKey).toSet());
  }

  Future<Set<String>> getLeaguePermissionKeys({
    required String leagueSyncId,
  }) async {
    final rows = await (db.select(db.userLeaguePermissions)
          ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
        .get();

    return rows.map((e) => e.permissionKey).toSet();
  }

  List<UserHasRoleModel> _sort(List<UserHasRoleModel> list) {
    list.sort((a, b) {
      final ao = a.roleOrder;
      final bo = b.roleOrder;

      if (ao == null && bo == null) {
        return a.name.compareTo(b.name);
      }
      if (ao == null) return 1;   // null آخر شيء
      if (bo == null) return -1;

      final c = ao.compareTo(bo);
      return c != 0 ? c : a.name.compareTo(b.name);
    });
    return list;
  }

  // ----------------------------
  // ✅ GET مرة واحدة
  // ----------------------------
  Future<List<UserHasRoleModel>> getUsersHasRoles({
    required String leagueSyncId,
  }) async {
    final rows = await (db.select(db.usersHasRole)
      ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
        .get();

    return _sort(rows.map(UserHasRoleModel.fromEntity).toList());
  }

  // ----------------------------
  // ✅ WATCH بدون RxDart
  // ----------------------------
  Stream<List<UserHasRoleModel>> watchUsersHasRoles({
    required String leagueSyncId,
  }) {
    return (db.select(db.usersHasRole)
      ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
        .watch()
        .map((rows) => _sort(rows.map(UserHasRoleModel.fromEntity).toList()));
  }

  // ----------------------------
  // ✅ WATCH حسب Role (بدون & لتجنب أي لبس)
  // ----------------------------
  Stream<List<UserHasRoleModel>> watchUsersHasRolesByRole({
    required String leagueSyncId,
    required String role,
  }) {
    final query = db.select(db.usersHasRole)
      ..where((t) => t.leagueSyncId.equals(leagueSyncId))
      ..where((t) => t.role.equals(role));

    return query.watch().map((rows) {
      final list = rows.map(UserHasRoleModel.fromEntity).toList();

      // ترتيب احترافي: roleOrder (null آخر شيء) ثم name
      list.sort((a, b) {
        final ao = a.roleOrder;
        final bo = b.roleOrder;

        if (ao == null && bo == null) return a.name.compareTo(b.name);
        if (ao == null) return 1;
        if (bo == null) return -1;

        final c = ao.compareTo(bo);
        return c != 0 ? c : a.name.compareTo(b.name);
      });

      return list;
    });
  }
  Future<void> upsertUsersHasRoles({
    required String leagueSyncId,
    required List<UserHasRoleModel> items,
    bool deleteMissing = false,
  }) async {
    if (items.isEmpty) return;

    // ✅ Dedup على syncId
    final byId = <String, UserHasRoleModel>{};
    for (final it in items) {
      final sid = it.syncId!.trim();
      if (sid.isEmpty) continue;
      byId[sid] = it.copyWith(leagueSyncId: leagueSyncId);
    }
    final list = byId.values.toList();

    await db.transaction(() async {
      // ✅ Upsert باستخدام target: syncId (لأن عندك UNIQUE(sync_id))
      for (final it in list) {
        await db.into(db.usersHasRole).insert(
          it.toCompanionInsert(),
          onConflict: DoUpdate(
                (old) => UsersHasRoleCompanion(
              leagueSyncId: Value(it.leagueSyncId),
              name: Value(it.name),
              role: Value(it.role),
              roleOrder: it.roleOrder != null
                  ? Value(it.roleOrder!)
                  : const Value.absent(),
            ),
            target: [db.usersHasRole.syncId],
          ),
        );
      }

      // ✅ حذف غير الموجودين (اختياري)

    });
  }
}



