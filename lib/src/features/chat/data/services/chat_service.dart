import 'package:dio/dio.dart';
import 'package:invastro/src/core/network/api_service.dart';

class ChatService {
  Future getConversations(
    Map<String, dynamic> queryParameters, {
    rethrowError = false,
  }) async {
    return await ApiService.get(
      '/conversations/list',
      queryParameters: queryParameters,
      rethrowError: rethrowError,
    );
  }

  /// Get paginated messages
  Future getChatMessages(
    Map<String, dynamic> queryParameters, {
    rethrowError = false,
    num? conversationId,
  }) async {
    return await ApiService.get(
      '/messages/list/$conversationId',
      queryParameters: queryParameters,
      rethrowError: rethrowError,
    );
  }

  /// Send a message
  Future sendMessage({
    required num conversationId,
    String? message,
    List<String>? filePaths,
    bool rethrowError = false,
  }) async {
    final data = <String, dynamic>{'conversation_id': conversationId};

    if (message != null && message.trim().isNotEmpty) {
      data['message'] = message;
    }

    // Add files as multipart array
    if (filePaths != null && filePaths.isNotEmpty) {
      final files = <MultipartFile>[];
      for (final path in filePaths) {
        if (path.trim().isNotEmpty) {
          final name = path.split('/').last;
          files.add(MultipartFile.fromFileSync(path, filename: name));
        }
      }
      if (files.isNotEmpty) {
        data['documents[]'] = files;
      }
    }

    return await ApiService.post(
      '/messages/send',
      data: data,
      hasMultipartData: filePaths != null && filePaths.isNotEmpty,
      rethrowError: rethrowError,
    );
  }

  /// Update presence - called every 10 seconds while user is in chat
  Future updatePresence({
    required num conversationId,
    bool rethrowError = false,
  }) async {
    return await ApiService.post(
      '/conversations/presence/heartbeat',
      data: {'conversation_id': conversationId},
      rethrowError: rethrowError,
    );
  }

  /// Leave chat - called when user leaves chat screen or app goes to background
  Future leaveChat({
    required num conversationId,
    bool rethrowError = false,
  }) async {
    return await ApiService.post(
      '/conversations/presence/leave',
      data: {'conversation_id': conversationId},
      rethrowError: rethrowError,
    );
  }

  Future markAsRead({
    required num conversationId,
    bool rethrowError = false,
  }) async {
    return await ApiService.post(
      '/conversations/mark-as-read',
      data: {'conversation_id': conversationId},
      rethrowError: rethrowError,
    );
  }

  Future updateConversationsDetails({
    required num receiverId,
    bool rethrowError = false,
  }) async {
    return await ApiService.post(
      '/conversations/open',
      data: {'receiver_id': receiverId},
      rethrowError: rethrowError,
    );
  }

  /// Get Pusher channel authorization for private channels
  Future<Map<String, dynamic>> getPusherChannelAuth({
    required String socketId,
    required String channelName,
    bool rethrowError = false,
  }) async {
    return await ApiService.post(
      '/pusher/auth',
      data: {'socket_id': socketId, 'channel_name': channelName},
      rethrowError: rethrowError,
    );
  }
}
