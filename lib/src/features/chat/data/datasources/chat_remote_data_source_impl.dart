import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../models/conversations_model.dart';
import '../models/message_model.dart';
import 'chat_remote_data_source.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  PaginationList<T> _parsePage<T>(
    dynamic responseData,
    T Function(dynamic) fromJson,
  ) {
    final json = Map<String, dynamic>.from(responseData as Map);
    json['data'] = (json['data'] as List).map(fromJson).toList();
    return PaginationList<T>.fromJson(json);
  }

  @override
  Future<PaginationList<ConversationsModel>> getConversations(int page) async {
    final response = await _apiClient.get(
      EndPoints.getConversations,
      queryParameters: {'page': page},
    );
    return _parsePage(
      response.responseData,
      (e) => ConversationsModel.fromJson(e),
    );
  }

  @override
  Future<PaginationList<MessageModel>> getMessages({
    required num conversationId,
    required int page,
  }) async {
    final response = await _apiClient.get(
      EndPoints.getChatMessages(conversationId),
      queryParameters: {'page': page},
    );
    return _parsePage(response.responseData, (e) => MessageModel.fromJson(e));
  }

  @override
  Future<MessageModel> sendMessage({
    required num conversationId,
    String? message,
    List<String>? filePaths,
  }) async {
    final data = <String, dynamic>{'conversation_id': conversationId};
    if (message != null && message.trim().isNotEmpty) {
      data['message'] = message;
    }
    if (filePaths != null && filePaths.isNotEmpty) {
      final files = <MultipartFile>[];
      for (final path in filePaths) {
        if (path.trim().isNotEmpty) {
          files.add(
            MultipartFile.fromFileSync(path, filename: path.split('/').last),
          );
        }
      }
      if (files.isNotEmpty) {
        data['documents[]'] = files;
      }
    }
    final hasFiles = filePaths != null && filePaths.isNotEmpty;
    final response = await _apiClient.post(
      EndPoints.sendChatMessage,
      data: data,
      hasMultipartData: hasFiles,
    );
    return MessageModel.fromJson(response.responseData['data']);
  }

  @override
  Future<void> updatePresence(num conversationId) async {
    await _apiClient.post(
      EndPoints.chatPresenceHeartbeat,
      data: {'conversation_id': conversationId},
    );
  }

  @override
  Future<void> leaveChat(num conversationId) async {
    await _apiClient.post(
      EndPoints.chatPresenceLeave,
      data: {'conversation_id': conversationId},
    );
  }

  @override
  Future<void> markAsRead(num conversationId) async {
    await _apiClient.post(
      EndPoints.markConversationRead,
      data: {'conversation_id': conversationId},
    );
  }

  @override
  Future<ConversationsModel> openConversation(num receiverId) async {
    final response = await _apiClient.post(
      EndPoints.openConversation,
      data: {'receiver_id': receiverId},
    );
    return ConversationsModel.fromJson(response.responseData['data']);
  }

  @override
  Future<Map<String, dynamic>> getPusherChannelAuth({
    required String socketId,
    required String channelName,
  }) async {
    final response = await _apiClient.get(
      EndPoints.pusherAuth,
      queryParameters: {'socket_id': socketId, 'channel_name': channelName},
    );
    final data = response.responseData;
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    return {};
  }
}
