import '../../../../core/network/api_result.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../models/conversations_model.dart';
import '../models/message_model.dart';

abstract class ChatRepository {
  Future<ApiResult<PaginationList<ConversationsModel>>> getConversations(
    int page,
  );

  Future<ApiResult<PaginationList<MessageModel>>> getMessages({
    required num conversationId,
    required int page,
  });

  Future<ApiResult<MessageModel>> sendMessage({
    required num conversationId,
    String? message,
    List<String>? filePaths,
  });

  Future<ApiResult<void>> updatePresence(num conversationId);

  Future<ApiResult<void>> leaveChat(num conversationId);

  Future<ApiResult<void>> markAsRead(num conversationId);

  Future<ApiResult<ConversationsModel>> openConversation(num receiverId);
}
