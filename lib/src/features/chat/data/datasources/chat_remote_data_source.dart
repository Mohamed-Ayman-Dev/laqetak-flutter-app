import '../../../../core/shared/models/pagination_list.dart';
import '../models/conversations_model.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<PaginationList<ConversationsModel>> getConversations(int page);

  Future<PaginationList<MessageModel>> getMessages({
    required num conversationId,
    required int page,
  });

  Future<MessageModel> sendMessage({
    required num conversationId,
    String? message,
    List<String>? filePaths,
  });

  Future<void> updatePresence(num conversationId);

  Future<void> leaveChat(num conversationId);

  Future<void> markAsRead(num conversationId);

  Future<ConversationsModel> openConversation(num receiverId);

  Future<Map<String, dynamic>> getPusherChannelAuth({
    required String socketId,
    required String channelName,
  });
}
