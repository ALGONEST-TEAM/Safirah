import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../services/auth/auth.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  Timer? _pingTimer;
  Timer? _reconnectTimer;

  bool _isConnected = false;
  bool _isConnecting = false;
  String? socketId;

  static const String _wssUrl =
      'wss://ws.safirah.store/app/7143a11128c121b228f07a8080fad7f4?protocol=7&client=flutter&version=1.0&flash=false';

  final Set<String> _subscribedChannels = {};
  final Set<String> _processedEventIds = {};
  final Map<String, List<Function(String eventName, Map<String, dynamic> data)>>
      _eventListeners = {};

  Future<void> connect() async {
    if (_isConnected || _isConnecting) return;
    _isConnecting = true;

    try {
      debugPrint('==> [WebSocketService] Connecting to $_wssUrl');
      final uri = Uri.parse(_wssUrl);
      _channel = WebSocketChannel.connect(uri);

      _subscription = _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );

      _isConnected = true;
      _isConnecting = false;
      _startPingTimer();
    } catch (e, stack) {
      _isConnecting = false;
      _isConnected = false;
      debugPrint('==> [WebSocketService Connect Exception]: $e\n$stack');
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic rawMessage) {
    if (rawMessage == null) return;
    try {
      final decoded = jsonDecode(rawMessage.toString());
      if (decoded is! Map<String, dynamic>) return;

      final String eventName = decoded['event']?.toString() ?? '';
      final String channelName = decoded['channel']?.toString() ?? '';
      dynamic eventData = decoded['data'];

      if (eventData is String && eventData.isNotEmpty) {
        try {
          eventData = jsonDecode(eventData);
        } catch (_) {}
      }

      final Map<String, dynamic> dataMap =
          eventData is Map<String, dynamic> ? eventData : {'data': eventData};

      // 0. Deduplicate by channel:event_id
      final String rawEventId = dataMap['event_id']?.toString() ??
          decoded['event_id']?.toString() ??
          '';

      final String dedupeKey =
          rawEventId.isNotEmpty ? '$channelName:$rawEventId' : '';

      if (dedupeKey.isNotEmpty) {
        if (_processedEventIds.contains(dedupeKey)) {
          debugPrint('==> [WebSocket] Duplicate event skipped: $dedupeKey');
          return;
        }
        _processedEventIds.add(dedupeKey);
        if (_processedEventIds.length > 500) {
          _processedEventIds.remove(_processedEventIds.first);
        }
      }

      // 1. Handshake Welcome
      if (eventName == 'pusher:connection_established') {
        socketId = dataMap['socket_id']?.toString();
        debugPrint('==> [WebSocket] Connection Established! Socket ID: $socketId');
        _resubscribeAll();
        return;
      }

      // 2. Ping / Pong Heartbeat
      if (eventName == 'pusher:ping') {
        _sendFrame('pusher:pong', {});
        return;
      }

      // 3. Dispatch channel events
      if (channelName.isNotEmpty) {
        final listeners = _eventListeners[channelName];
        if (listeners != null && listeners.isNotEmpty) {
          for (final listener in listeners) {
            listener(eventName, dataMap);
          }
        }
      }
    } catch (e) {
      debugPrint('==> [WebSocket Parse Error]: $e | Raw: $rawMessage');
    }
  }

  void subscribeToChannel({
    required String channelName,
    required Function(String eventName, Map<String, dynamic> data) onEventReceived,
  }) {
    if (!_eventListeners.containsKey(channelName)) {
      _eventListeners[channelName] = [];
    }

    if (!_eventListeners[channelName]!.contains(onEventReceived)) {
      _eventListeners[channelName]!.add(onEventReceived);
    }

    _subscribedChannels.add(channelName);

    if (_isConnected) {
      _sendSubscribeFrame(channelName);
    } else {
      connect();
    }
  }

  void unsubscribeFromChannel({
    required String channelName,
    Function(String eventName, Map<String, dynamic> data)? onEventReceived,
  }) {
    if (_eventListeners.containsKey(channelName)) {
      if (onEventReceived != null) {
        _eventListeners[channelName]!.remove(onEventReceived);
      }
      if (onEventReceived == null || _eventListeners[channelName]!.isEmpty) {
        _eventListeners.remove(channelName);
        _subscribedChannels.remove(channelName);
        if (_isConnected) {
          _sendUnsubscribeFrame(channelName);
        }
      }
    }
  }

  Future<void> subscribeToPrivateChannel({
    required String channelName,
    required Function(String eventName, Map<String, dynamic> data) onEventReceived,
  }) async {
    final String formattedChannel =
        channelName.startsWith('private-') ? channelName : 'private-$channelName';

    if (!_eventListeners.containsKey(formattedChannel)) {
      _eventListeners[formattedChannel] = [];
    }

    if (!_eventListeners[formattedChannel]!.contains(onEventReceived)) {
      _eventListeners[formattedChannel]!.add(onEventReceived);
    }

    _subscribedChannels.add(formattedChannel);

    if (_isConnected && socketId != null && socketId!.isNotEmpty) {
      await _sendPrivateSubscribeFrame(formattedChannel);
    } else {
      await connect();
    }
  }

  Future<void> _sendPrivateSubscribeFrame(String channelName) async {
    try {
      // 1. If socketId is not ready yet, wait briefly for connection_established handshake
      if (socketId == null || socketId!.isEmpty) {
        int retries = 0;
        while ((socketId == null || socketId!.isEmpty) && retries < 10) {
          await Future.delayed(const Duration(milliseconds: 150));
          retries++;
        }
      }

      // 2. If still not ready, skip for now. _resubscribeAll() will trigger it upon connection_established
      if (socketId == null || socketId!.isEmpty) {
        debugPrint(
            '==> [WebSocket Private Auth Skipped] socketId not established yet for: $channelName (will auto-subscribe upon handshake)');
        return;
      }

      final token = Auth().token;
      if (token == null || token.isEmpty) {
        debugPrint(
            '==> [WebSocket Private Auth Skipped] User auth token is empty for: $channelName');
        return;
      }

      final dio = Dio();
      final response = await dio.post(
        'https://safirah.store/broadcasting/auth',
        data: 'socket_id=$socketId&channel_name=$channelName',
        options: Options(
          validateStatus: (status) => status != null && status < 500,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200 && response.data is Map) {
        final authSig = response.data['auth']?.toString() ?? '';
        debugPrint(
            '==> [WebSocket Private Auth Success] Channel: $channelName | Auth: $authSig');

        _sendFrame('pusher:subscribe', {
          'channel': channelName,
          'auth': authSig,
        });
      } else {
        debugPrint(
            '==> [WebSocket Private Auth Failed] Channel: $channelName | Status: ${response.statusCode} | Data: ${response.data}');
      }
    } catch (e) {
      debugPrint('==> [WebSocket Private Auth Error] Channel: $channelName | Error: $e');
    }
  }

  void _sendSubscribeFrame(String channelName) {
    if (channelName.startsWith('private-')) {
      _sendPrivateSubscribeFrame(channelName);
      return;
    }
    debugPrint('==> [WebSocket] Sending Subscribe Frame for: $channelName');
    _sendFrame('pusher:subscribe', {'channel': channelName});
  }

  void _sendUnsubscribeFrame(String channelName) {
    debugPrint('==> [WebSocket] Sending Unsubscribe Frame for: $channelName');
    _sendFrame('pusher:unsubscribe', {'channel': channelName});
  }

  void _sendFrame(String event, Map<String, dynamic> data) {
    if (_channel != null && _isConnected) {
      final frame = jsonEncode({
        'event': event,
        'data': data,
      });
      _channel!.sink.add(frame);
    }
  }

  void _resubscribeAll() {
    for (final channel in _subscribedChannels) {
      if (channel.startsWith('private-')) {
        _sendPrivateSubscribeFrame(channel);
      } else {
        _sendSubscribeFrame(channel);
      }
    }
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 25), (_) {
      if (_isConnected) {
        _sendFrame('pusher:ping', {});
      }
    });
  }

  void _onError(error) {
    debugPrint('==> [WebSocket Stream Error]: $error');
    _handleDisconnect();
  }

  void _onDone() {
    debugPrint('==> [WebSocket Stream Closed/Done]');
    _handleDisconnect();
  }

  void _handleDisconnect() {
    _isConnected = false;
    _isConnecting = false;
    _pingTimer?.cancel();
    _subscription?.cancel();
    _channel = null;
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 4), () {
      if (!_isConnected && _subscribedChannels.isNotEmpty) {
        debugPrint('==> [WebSocket] Retrying reconnection...');
        connect();
      }
    });
  }

  void dispose() {
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    _subscription?.cancel();
    _channel?.sink.close();
    _isConnected = false;
    _isConnecting = false;
  }
}
