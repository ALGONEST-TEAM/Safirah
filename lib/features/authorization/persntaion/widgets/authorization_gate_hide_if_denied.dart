import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/riverpod.dart';
class AuthorizationGateHideIfDenied extends ConsumerWidget {
  final String leagueSyncId;
  final String permissionKey;
  final Widget child;

  /// أثناء التحميل.
  final Widget? loading;

  /// عند الخطأ (افتراضي: يخفي الويدجت).
  final Widget? onError;

  const AuthorizationGateHideIfDenied({
    super.key,
    required this.leagueSyncId,
    required this.permissionKey,
    required this.child,
    this.loading,
    this.onError,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permsAsync = ref.watch(leaguePermissionsProvider(leagueSyncId));

    return permsAsync.when(
      data: (set) {
        final ok = set.contains(permissionKey);
        if (!ok) return const SizedBox.shrink();
        return child;
      },
      loading: () => loading ?? const SizedBox.shrink(),
      error: (e, st) => onError ?? const SizedBox.shrink(),
    );
  }
}

