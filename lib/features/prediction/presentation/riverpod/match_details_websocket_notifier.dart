import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/websocket_service.dart';
import 'match_details_riverpod.dart';
import 'match_lineups_riverpod.dart';

final matchDetailsWebSocketProvider =
    Provider.family<MatchDetailsWebSocketService, int>((ref, matchId) {
  final service = MatchDetailsWebSocketService(ref, matchId);
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});

class MatchDetailsWebSocketService {
  final Ref _ref;
  final int matchId;
  final WebSocketService _wsService = WebSocketService();
  bool _isSubscribed = false;

  MatchDetailsWebSocketService(this._ref, this.matchId);

  String get channelName {
    if (matchId == 99000001 || matchId == 99000002) {
      return 'private-demo-match.$matchId';
    }
    return 'private-match.$matchId';
  }

  void startListening() {
    if (_isSubscribed) return;
    _isSubscribed = true;

    _wsService.subscribeToPrivateChannel(
      channelName: channelName,
      onEventReceived: _handleMatchDetailsEvent,
    );
    debugPrint(
        '==> [MatchDetailsWebSocketService] Listening started on channel: $channelName');
  }

  void _handleMatchDetailsEvent(
      String eventName, Map<String, dynamic> payload) {
    try {
      debugPrint(
          '==> [MatchDetails WebSocket Event]: $eventName | Match: $matchId | Payload: $payload');

      final innerData = payload['data'] as Map<String, dynamic>?;

      int? homeScore;
      int? awayScore;
      int? stateId;
      String? resultInfo;
      int? minute;
      int? second;
      bool? ticking;
      int? timeAdded;

      if (eventName == 'match.summary.updated' ||
          eventName == 'match.state.changed' ||
          eventName == 'match.finished') {
        stateId = innerData?['state_id'] != null
            ? int.tryParse(innerData!['state_id'].toString())
            : (payload['state_id'] != null
                ? int.tryParse(payload['state_id'].toString())
                : null);

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
        } else if (innerData != null) {
          homeScore = innerData['home_score'] != null
              ? int.tryParse(innerData['home_score'].toString())
              : null;
          awayScore = innerData['away_score'] != null
              ? int.tryParse(innerData['away_score'].toString())
              : null;
          resultInfo = innerData['result_info']?.toString();
        }

        // Resilient timer extraction across match_clock, changes, innerData, and payload
        final clockMap = (innerData?['match_clock'] ??
            changes?['match_clock'] ??
            payload['match_clock']) as Map<String, dynamic>?;

        final rawMinute = clockMap?['minute'] ??
            changes?['minute'] ??
            innerData?['minute'] ??
            payload['minute'];
        final rawSecond = clockMap?['second'] ??
            changes?['second'] ??
            innerData?['second'] ??
            payload['second'];
        final rawTicking = clockMap?['ticking'] ??
            changes?['ticking'] ??
            innerData?['ticking'] ??
            payload['ticking'];
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
            ? (rawTicking == true ||
                rawTicking == 1 ||
                rawTicking.toString() == 'true')
            : null;
        timeAdded =
            rawTimeAdded != null ? int.tryParse(rawTimeAdded.toString()) : null;

        if (eventName == 'match.finished') {
          ticking = false;
          stateId ??= 5;
        }

        _ref.read(matchDetailsProvider(matchId).notifier).updateFromWebSocket(
              homeScore: homeScore,
              awayScore: awayScore,
              stateId: stateId,
              resultInfo: resultInfo,
              minute: minute,
              second: second,
              ticking: ticking,
              timeAdded: timeAdded,
            );
      } else if (eventName == 'match.event.created' ||
          eventName == 'match.event.updated') {
        _ref.read(matchEventsProvider(matchId).notifier).getMatchEvents();
      } else if (eventName == 'match.statistics.updated') {
        _ref
            .read(matchStatisticsProvider(matchId).notifier)
            .getMatchStatistics(forceRefresh: true);
      } else if (eventName == 'match.lineup.updated') {
        _ref.read(matchLineupsProvider(matchId).notifier).getMatchLineups(isRefresh: true);
      }
    } catch (e, stack) {
      debugPrint('==> [MatchDetails WebSocket Event Error]: $e\n$stack');
    }
  }

  void dispose() {
    if (_isSubscribed) {
      _wsService.unsubscribeFromChannel(
        channelName: channelName,
        onEventReceived: _handleMatchDetailsEvent,
      );
      _isSubscribed = false;
      debugPrint(
          '==> [MatchDetailsWebSocketService] Unsubscribed from: $channelName');
    }
  }
}
