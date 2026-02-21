import 'package:flutter/material.dart';

import '../widgets/authorization_gate.dart';
import '../widgets/authorization_denied_widget.dart';

class AuthorizationGatePage extends StatelessWidget {
  final String leagueSyncId;
  final String permissionKey;
  final Widget child;

  const AuthorizationGatePage({
    super.key,
    required this.leagueSyncId,
    required this.permissionKey,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthorizationGate(
        leagueSyncId: leagueSyncId,
        permissionKey: permissionKey,
        child: child,
        denied: const AuthorizationDeniedWidget(),
      ),
    );
  }
}

