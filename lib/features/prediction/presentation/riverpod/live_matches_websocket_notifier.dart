import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/websocket_service.dart';
import 'prediction_riverpod.dart';

final liveMatchesWebSocketProvider = Provider<LiveMatchesWebSocketService>((ref) {
  final service = LiveMatchesWebSocketService(ref);
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});

class LiveMatchesWebSocketService {
  final Ref _ref;
  final WebSocketService _wsService = WebSocketService();
  bool _isSubscribed = false;

  LiveMatchesWebSocketService(this._ref);

  void startListening() {
    if (_isSubscribed) return;
    _isSubscribed = true;

    // الاشتراك في القناة العامة الرئيسية والقناة العامة للتجربة Demo
    _wsService.subscribeToChannel(
      channelName: 'live-matches',
      onEventReceived: _handleLiveMatchesEvent,
    );
    _wsService.subscribeToChannel(
      channelName: 'demo-live-matches',
      onEventReceived: _handleLiveMatchesEvent,
    );
    debugPrint('==> [LiveMatchesWebSocketService] Listening started on channels: live-matches & demo-live-matches');
  }

  void _handleLiveMatchesEvent(String eventName, Map<String, dynamic> payload) {
    try {
      final int matchId = payload['match_id'] != null
          ? int.tryParse(payload['match_id'].toString()) ?? 0
          : (payload['data'] is Map && payload['data']['match_id'] != null
              ? int.tryParse(payload['data']['match_id'].toString()) ?? 0
              : 0);
      if (matchId == 0) return;

      final innerData = payload['data'] as Map<String, dynamic>?;

      int? homeScore;
      int? awayScore;
      int? stateId;
      String? resultInfo;
      int? minute;
      int? second;
      bool? ticking;
      int? timeAdded;

      if (eventName == 'match.summary.updated' || eventName == 'match.state.changed') {
        stateId = innerData?['state_id'] != null
            ? int.tryParse(innerData!['state_id'].toString())
            : (payload['state_id'] != null ? int.tryParse(payload['state_id'].toString()) : null);

        final changes = innerData?['changes'] as Map<String, dynamic>?;
        if (changes != null) {
          if (changes['state_id'] != null) {
            stateId = int.tryParse(changes['state_id'].toString());
          }
          homeScore = changes['home_score'] != null
              ? int.tryParse(changes['home_score'].toString())
              : null;
          awayScore = changes['away_score'] != null
              ? int.tryParse(changes['away_score'].toString())
              : null;
          resultInfo = changes['result_info']?.toString();
        }

        // Resilient timer extraction across match_clock, changes, innerData, and payload
        final clockMap = (innerData?['match_clock'] ??
            changes?['match_clock'] ??
            payload['match_clock']) as Map<String, dynamic>?;

        final rawMinute = clockMap?['minute'] ?? changes?['minute'] ?? innerData?['minute'] ?? payload['minute'];
        final rawSecond = clockMap?['second'] ?? changes?['second'] ?? innerData?['second'] ?? payload['second'];
        final rawTicking = clockMap?['ticking'] ?? changes?['ticking'] ?? innerData?['ticking'] ?? payload['ticking'];
        final rawTimeAdded = clockMap?['added_time'] ??
            clockMap?['time_added'] ??
            changes?['added_time'] ??
            changes?['time_added'] ??
            innerData?['added_time'] ??
            innerData?['time_added'] ??
            payload['added_time'] ??
            payload['time_added'];

        minute = rawMinute != null ? int.tryParse(rawMinute.toString()) : null;
        second = rawSecond != null ? int.tryParse(rawSecond.toString()) : null;
        ticking = rawTicking != null
            ? (rawTicking == true || rawTicking == 1 || rawTicking.toString() == 'true')
            : null;
        timeAdded = rawTimeAdded != null ? int.tryParse(rawTimeAdded.toString()) : null;
      } else if (eventName == 'match.finished') {
        if (innerData != null) {
          stateId = innerData['state_id'] != null
              ? int.tryParse(innerData['state_id'].toString())
              : 5;
          homeScore = innerData['home_score'] != null
              ? int.tryParse(innerData['home_score'].toString())
              : null;
          awayScore = innerData['away_score'] != null
              ? int.tryParse(innerData['away_score'].toString())
              : null;
          resultInfo = innerData['result_info']?.toString();
          ticking = false;
        }
      }

      if (homeScore != null ||
          awayScore != null ||
          stateId != null ||
          resultInfo != null ||
          minute != null ||
          second != null ||
          ticking != null) {
        final currentScope = _ref.read(matchesScopeProvider);
        _ref.read(getAllMatchesProvider(currentScope).notifier).updateMatchFromWebSocket(
              matchId: matchId,
              homeScore: homeScore,
              awayScore: awayScore,
              stateId: stateId,
              resultInfo: resultInfo,
              minute: minute,
              second: second,
              ticking: ticking,
              timeAdded: timeAdded,
            );
        debugPrint(
            '==> [WebSocket LIVE UPDATE]: Match: $matchId | Event: $eventName | Home: $homeScore | Away: $awayScore | Min: $minute:$second | Ticking: $ticking');
      }
    } catch (e, stack) {
      debugPrint('==> [WebSocket Event Handle Error]: $e\n$stack');
    }
  }

  void dispose() {
    if (_isSubscribed) {
      _wsService.unsubscribeFromChannel(
        channelName: 'live-matches',
        onEventReceived: _handleLiveMatchesEvent,
      );
      _wsService.unsubscribeFromChannel(
        channelName: 'demo-live-matches',
        onEventReceived: _handleLiveMatchesEvent,
      );
      _isSubscribed = false;
      debugPrint('==> [LiveMatchesWebSocketService] Unsubscribed from live-matches & demo-live-matches');
    }
  }
}
