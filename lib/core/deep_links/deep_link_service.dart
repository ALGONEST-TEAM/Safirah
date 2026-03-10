import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:safirah/core/widgets/bottomNavbar/bottom_navigation_bar_of_mange_league_widget.dart';
import 'package:safirah/features/leagues_mangement/leagues/persntaion/page/details_league_widget.dart';
import 'package:safirah/main.dart';

import '../../features/leagues_mangement/leagues/persntaion/page/details_league_user_page.dart';

/// Deep link contract:
/// - Supports: safirah://league/<leagueSyncId>
/// - Supports: https://saferah.dev-station.com/league/<leagueSyncId>
/// - (Legacy) https://safirah.app/league/<leagueSyncId>
/// - If a link is opened, the app navigates to [DetailsLeagueWidget] for that league.
///
/// Note: we keep navigation imperative since the app isn't using named routes.
class DeepLinkService {
  DeepLinkService._();

  static final DeepLinkService I = DeepLinkService._();

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _sub;

  bool _started = false;

  Future<void> start() async {
    if (_started) return;
    _started = true;

    // Handle cold-start.
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleUri(initialUri);
      }
    } catch (e, st) {
      debugPrint('DeepLinkService getInitialLink error: $e\n$st');
    }

    // Handle links while app is running.
    _sub = _appLinks.uriLinkStream.listen(
      _handleUri,
      onError: (e, st) => debugPrint('DeepLinkService stream error: $e\n$st'),
    );
  }

  Future<void> dispose() async {
    await _sub?.cancel();
    _sub = null;
    _started = false;
  }

  void _handleUri(Uri uri) {
    final leagueSyncId = _parseLeagueId(uri);
    if (leagueSyncId == null || leagueSyncId.isEmpty) return;

    // If navigator isn't ready yet, retry after first frame.
    _navigateToLeague(leagueSyncId);
  }

  String? _parseLeagueId(Uri uri) {
    // Expected patterns:
    // safirah://league/<id>
    // safirah://league?leagueSyncId=<id>
    // https://saferah.dev-station.com/league/<id>
    // (legacy) https://safirah.app/league/<id>

    // 1) Enforce allowed hosts for HTTPS so random domains can't trigger in-app navigation.
    if (uri.scheme == 'https') {
      const allowedHosts = <String>{
        'saferah.dev-station.com',
        'safirah.app', // legacy
      };
      if (!allowedHosts.contains(uri.host)) return null;
    }

    // 2) Path-based: /league/<id>
    final segments = uri.pathSegments;
    if (segments.length >= 2 && segments.first == 'league') {
      return segments[1];
    }

    // 3) Custom scheme host-based: safirah://league/<id>  => host=league, pathSegments=[<id>]
    if (uri.scheme == 'safirah' && uri.host == 'league') {
      if (segments.isNotEmpty) return segments.first;
    }

    // 4) Query-based fallback.
    // Accept multiple keys to be resilient.
    final q = uri.queryParameters['leagueSyncId'] ??
        uri.queryParameters['id'] ??
        uri.queryParameters['leagueId'];
    if (q != null && q.isNotEmpty) return q;

    return null;
  }

  void _navigateToLeague(String leagueSyncId) {
    final nav = appNavigatorKey;

    void go() {
      final ctx = nav.currentContext;
      if (ctx == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => go());
        return;
      }

      // Ensure we are in the main shell then push league.
      nav.currentState?.pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const BottomNavigationBarOfMangeLeagueWidget(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
        (route) => false,
      );

      // Push details on top.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nav.currentState?.push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => DetailsLeagueUserPage(leagueSyncId: leagueSyncId),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      });
    }

    go();
  }
}
