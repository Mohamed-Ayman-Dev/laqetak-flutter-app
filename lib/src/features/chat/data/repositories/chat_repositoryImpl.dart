import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../datasources/chat_remote_data_source.dart';
import '../models/conversations_model.dart';
import '../models/message_model.dart';
import 'chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl({required ChatRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final ChatRemoteDataSource _remoteDataSource;

  @override
  Future<ApiResult<PaginationList<ConversationsModel>>> getConversations(
    int page,
  ) async {
    try {
      final pageData = await _remoteDataSource.getConversations(page);
      return ApiResult.success(pageData);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<PaginationList<MessageModel>>> getMessages({
    required num conversationId,
    required int page,
  }) async {
    try {
      final pageData = await _remoteDataSource.getMessages(
        conversationId: conversationId,
        page: page,
      );
      return ApiResult.success(pageData);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<MessageModel>> sendMessage({
    required num conversationId,
    String? message,
    List<String>? filePaths,
  }) async {
    try {
      final sent = await _remoteDataSource.sendMessage(
        conversationId: conversationId,
        message: message,
        filePaths: filePaths,
      );
      return ApiResult.success(sent);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> updatePresence(num conversationId) async {
    try {
      await _remoteDataSource.updatePresence(conversationId);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> leaveChat(num conversationId) async {
    try {
      await _remoteDataSource.leaveChat(conversationId);
      await _remoteDataSource.markAsRead(conversationId);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> markAsRead(num conversationId) async {
    try {
      await _remoteDataSource.markAsRead(conversationId);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<ConversationsModel>> openConversation(num receiverId) async {
    try {
      final conversation = await _remoteDataSource.openConversation(receiverId);
      return ApiResult.success(conversation);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }
}
