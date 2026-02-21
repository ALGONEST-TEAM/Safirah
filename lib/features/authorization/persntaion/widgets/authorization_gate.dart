import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/riverpod.dart';
import 'authorization_denied_widget.dart';

class AuthorizationGate extends ConsumerWidget {
  final String leagueSyncId;
  final String permissionKey;
  final Widget child;

  /// Widget بديل عند الرفض.
  final Widget? denied;

  /// أثناء التحميل (قبل وصول الصلاحيات من DB/watch)
  final Widget? loading;

  const AuthorizationGate({
    super.key,
    required this.leagueSyncId,
    required this.permissionKey,
    required this.child,
    this.denied,
    this.loading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permsAsync = ref.watch(leaguePermissionsProvider(leagueSyncId));

    return permsAsync.when(
      data: (set) {
        final ok = set.contains(permissionKey);
        if (ok) return child;
        return denied ?? const AuthorizationDeniedWidget();
      },
      loading: () => loading ?? const SizedBox.shrink(),
      error: (e, st) => denied ?? AuthorizationDeniedWidget(subtitle: e.toString()),
    );
  }
}

