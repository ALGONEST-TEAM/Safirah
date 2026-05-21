import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/widgets.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import 'package:safirah/core/widgets/bottomNavbar/bottom_navigation_bar_of_mange_league_widget.dart';
import 'package:safirah/core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import 'package:safirah/features/leagues_mangement/leagues/persntaion/page/details_league_widget.dart';
import 'package:safirah/features/shop/productManagement/detailsProducts/presentation/page/details_page.dart';
import 'package:safirah/main.dart';

import '../../features/leagues_mangement/leagues/persntaion/page/details_league_user_page.dart';

/// Deep link contract:
/// - Supports: safirah://league/<leagueSyncId>
/// - Supports: https://safirah.store/league/<leagueSyncId>
/// - (Legacy) https://saferah.dev-station.com/league/<leagueSyncId>
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
  bool _splashCompleted = false;
  bool _startupShellReady = false;
  _DeepLinkTarget? _pendingTarget;
  String? _activeNavigationKey;

  Future<void> start() async {
    if (_started) return;
    _started = true;
    _splashCompleted = false;
    _startupShellReady = false;
    _pendingTarget = null;
    _activeNavigationKey = null;

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
    _splashCompleted = false;
    _startupShellReady = false;
    _pendingTarget = null;
    _activeNavigationKey = null;
  }

  void markSplashCompleted() {
    _splashCompleted = true;
    _flushPendingNavigation();
  }

  void markStartupShellReady() {
    _startupShellReady = true;
    _flushPendingNavigation();
  }

  void _handleUri(Uri uri) {
    final target = _parseTarget(uri);
    if (target == null) return;

    if (_canNavigateNow) {
      _dispatchTarget(target);
      return;
    }

    _pendingTarget = target;
  }

  bool get _canNavigateNow => _splashCompleted && _startupShellReady;

  _DeepLinkTarget? _parseTarget(Uri uri) {
    final productId = _parseProductId(uri);
    if (productId != null) {
      return _DeepLinkTarget.product(productId);
    }

    final leagueSyncId = _parseLeagueId(uri);
    if (leagueSyncId == null || leagueSyncId.isEmpty) return null;

    return _DeepLinkTarget.league(leagueSyncId);
  }

  void _flushPendingNavigation() {
    if (!_canNavigateNow) return;

    final target = _pendingTarget;
    if (target == null) return;

    _pendingTarget = null;
    _dispatchTarget(target);
  }

  void _dispatchTarget(_DeepLinkTarget target) {
    if (_activeNavigationKey == target.key) return;

    if (_activeNavigationKey != null) {
      _pendingTarget = target;
      return;
    }

    _activeNavigationKey = target.key;

    switch (target) {
      case _LeagueDeepLinkTarget(:final leagueSyncId):
        _navigateToLeague(leagueSyncId);
      case _ProductDeepLinkTarget(:final productId):
        _navigateToProduct(productId);
    }
  }

  void _completeNavigationDispatch() {
    _activeNavigationKey = null;
    _flushPendingNavigation();
  }

  bool _isAllowedHttpsHost(Uri uri) {
    if (uri.scheme != 'https') return true;

    const allowedHosts = <String>{
      'safirah.store',
      'saferah.dev-station.com',
      'safirah.app', // legacy
    };

    return allowedHosts.contains(uri.host);
  }

  String? _parseLeagueId(Uri uri) {
    // Expected patterns:
    // safirah://league/<id>
    // safirah://league?leagueSyncId=<id>
    // https://safirah.store/league/<id>
    // https://safirah.store/league/index.html?id=<id>
    // https://saferah.dev-station.com/league/<id>
    // https://saferah.dev-station.com/league/index.html?id=<id>
    // (legacy) https://safirah.app/league/<id>

    // 1) Enforce allowed hosts for HTTPS so random domains can't trigger in-app navigation.
    if (!_isAllowedHttpsHost(uri)) return null;

    // 2) Path-based: /league/<id>
    final segments = uri.pathSegments;
    if (segments.length >= 2 && segments.first == 'league') {
      final pathId = segments[1];
      if (pathId.isNotEmpty && pathId != 'index.html') {
        return pathId;
      }
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

  int? _parseProductId(Uri uri) {
    if (!_isAllowedHttpsHost(uri)) return null;

    final segments = uri.pathSegments;

    if (segments.length >= 2 && segments.first == 'product') {
      final pathId = int.tryParse(segments[1]);
      if (pathId != null) return pathId;

      final q = uri.queryParameters['productId'] ?? uri.queryParameters['id'];
      if (q != null && q.isNotEmpty) {
        return int.tryParse(q);
      }
    }

    if (uri.scheme == 'safirah' && uri.host == 'product') {
      if (segments.isNotEmpty) {
        return int.tryParse(segments.first);
      }

      final q = uri.queryParameters['productId'] ?? uri.queryParameters['id'];
      if (q != null && q.isNotEmpty) {
        return int.tryParse(q);
      }
    }

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
        buildAdaptivePageRoute(
          child: const BottomNavigationBarOfMangeLeagueWidget(),
          instant: true,
        ),
        (route) => false,
      );

      // Push details on top.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nav.currentState?.push(
          buildAdaptivePageRoute(
            child: DetailsLeagueUserPage(leagueSyncId: leagueSyncId),
          ),
        );
        _completeNavigationDispatch();
      });
    }

    go();
  }

  void _navigateToProduct(int productId) {
    final nav = appNavigatorKey;

    void go() {
      final ctx = nav.currentContext;
      if (ctx == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => go());
        return;
      }

      nav.currentState?.pushAndRemoveUntil(
        buildAdaptivePageRoute(
          child: const BottomNavigationBarWidget(),
          instant: true,
        ),
        (route) => false,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        nav.currentState?.push(
          buildAdaptivePageRoute(
            child: DetailsPage(
              idProduct: productId,
              image: const [],
              name: '',
              price: '',
            ),
          ),
        );
        _completeNavigationDispatch();
      });
    }

    go();
  }
}

sealed class _DeepLinkTarget {
  const _DeepLinkTarget();

  String get key;

  const factory _DeepLinkTarget.league(String leagueSyncId) =
      _LeagueDeepLinkTarget;
  const factory _DeepLinkTarget.product(int productId) =
      _ProductDeepLinkTarget;
}

class _LeagueDeepLinkTarget extends _DeepLinkTarget {
  const _LeagueDeepLinkTarget(this.leagueSyncId);

  final String leagueSyncId;

  @override
  String get key => 'league:$leagueSyncId';
}

class _ProductDeepLinkTarget extends _DeepLinkTarget {
  const _ProductDeepLinkTarget(this.productId);

  final int productId;

  @override
  String get key => 'product:$productId';
}

