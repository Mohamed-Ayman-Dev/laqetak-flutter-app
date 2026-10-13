import 'package:flutter/foundation.dart';
import 'package:laqetak/src/core/di/locator.dart';
import 'package:laqetak/src/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

/// Centralized Pusher service for managing WebSocket connections
/// Can be used across the app for different features (chat, notifications, order updates, etc.)
class PusherService {
  static PusherService? _instance;
  PusherChannelsFlutter? _pusher;
  final Map<String, List<Function(PusherEvent)>> _channelListeners = {};
  bool _isInitialized = false;
  bool _isConnected = false;

  PusherService._();

  static PusherService get instance {
    _instance ??= PusherService._();
    return _instance!;
  }

  /// Initialize Pusher connection with channel authorizer for private channels
  Future<void> init({
    required String apiKey,
    required String cluster,
    Function(String, int?, dynamic)? onError,
  }) async {
    if (_isInitialized) return;

    try {
      _pusher = PusherChannelsFlutter.getInstance();

      await _pusher!.init(
        apiKey: apiKey,
        cluster: cluster,
        onEvent: _handlePusherEvent,
        onError: (message, code, exception) {
          debugPrint('Pusher error: $message, code: $code');
          onError?.call(message, code, exception);
        },
        onConnectionStateChange: (currentState, previousState) {
          debugPrint(
            'Pusher connection state changed: $previousState -> $currentState',
          );
          _isConnected = currentState == 'CONNECTED';
        },
        onAuthorizer: _onChannelAuthorizer,
      );

      await _pusher!.connect();
      _isInitialized = true;
    } catch (e) {
      debugPrint('Error initializing Pusher: $e');
      rethrow;
    }
  }

  /// Channel authorizer callback for private and presence channels
  dynamic _onChannelAuthorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    try {
      debugPrint('Authorizing channel: $channelName');

      final response = await locator<ChatRemoteDataSource>()
          .getPusherChannelAuth(socketId: socketId, channelName: channelName);
      debugPrint('Channel authorized successfully: $channelName');
      return response;
    } catch (e) {
      debugPrint('Error authorizing channel $channelName: $e');
      rethrow;
    }
  }

  /// Handle incoming Pusher events and route to appropriate listeners
  void _handlePusherEvent(PusherEvent event) {
    debugPrint('Pusher event received ${event.data}');
    final channelName = event.channelName;
    if (_channelListeners.containsKey(channelName)) {
      for (final listener in _channelListeners[channelName]!) {
        listener(event);
      }
    }
  }

  /// Subscribe to a channel with a listener
  Future<void> subscribe({
    required String channelName,
    required Function(PusherEvent) onEvent,
  }) async {
    if (!_isInitialized) {
      throw Exception('Pusher not initialized. Call init() first.');
    }

    try {
      // Add listener to map
      if (!_channelListeners.containsKey(channelName)) {
        _channelListeners[channelName] = [];
        // Subscribe to channel in Pusher
        await _pusher!.subscribe(channelName: channelName);
      }
      _channelListeners[channelName]!.add(onEvent);
    } catch (e) {
      debugPrint('Error subscribing to channel $channelName: $e');
      rethrow;
    }
  }

  /// Unsubscribe from a channel and remove listener
  Future<void> unsubscribe({
    required String channelName,
    Function(PusherEvent)? listener,
  }) async {
    if (!_isInitialized) return;

    try {
      if (_channelListeners.containsKey(channelName)) {
        if (listener != null) {
          // Remove specific listener
          _channelListeners[channelName]!.remove(listener);

          // If no more listeners, unsubscribe from channel
          if (_channelListeners[channelName]!.isEmpty) {
            _channelListeners.remove(channelName);
            await _pusher!.unsubscribe(channelName: channelName);
          }
        } else {
          // Remove all listeners and unsubscribe
          _channelListeners.remove(channelName);
          await _pusher!.unsubscribe(channelName: channelName);
        }
      }
    } catch (e) {
      debugPrint('Error unsubscribing from channel $channelName: $e');
    }
  }

  /// Disconnect from Pusher
  Future<void> disconnect() async {
    if (!_isInitialized) return;

    try {
      await _pusher!.disconnect();
      _channelListeners.clear();
      _isConnected = false;
      _isInitialized = false;
    } catch (e) {
      debugPrint('Error disconnecting from Pusher: $e');
    }
  }

  /// Check if connected
  bool get isConnected => _isConnected;

  /// Check if initialized
  bool get isInitialized => _isInitialized;
}
