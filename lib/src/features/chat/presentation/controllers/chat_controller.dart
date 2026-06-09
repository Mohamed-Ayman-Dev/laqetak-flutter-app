import 'package:flutter/foundation.dart';
import 'package:invastro/src/features/chat/data/models/conversations_model.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/error/error_helper.dart';
import '../../data/models/message_file_model.dart';
import '../../data/models/message_model.dart';

class ChatController {
  static Future<void> getConversations({bool refresh = false}) async {
    LocatorService.chat.setLoadingConversations(true);
    try {
      int? currentPage = LocatorService.chat.myConversations?.currentPage;
      int? lastPage = LocatorService.chat.myConversations?.lastPage;
      int nextPage = refresh ? 1 : ((currentPage ?? 0) + 1);
      if (!refresh && currentPage != null && currentPage == lastPage) return;
      final response = await LocatorService.chatService.getConversations({
        'page': nextPage,
      }, rethrowError: true);
      response["data"] = response["data"]
          .map<ConversationsModel>((x) => ConversationsModel.fromJson(x))
          .toList();
      LocatorService.chat.setConversations(response, refresh);
    } catch (e) {
      ErrorHelper.handleApiError(e);
    } finally {
      LocatorService.chat.setLoadingConversations(false);
    }
  }

  static Future<void> getMessages({
    required num conversationId,
    bool refresh = false,
  }) async {
    LocatorService.chat.setIsLoadingChat(conversationId, true);
    try {
      int? currentPage =
          LocatorService.chat.messagesMap[conversationId]?.currentPage;
      int? lastPage = LocatorService.chat.messagesMap[conversationId]?.lastPage;
      int nextPage = refresh ? 1 : ((currentPage ?? 0) + 1);
      if (!refresh && currentPage != null && currentPage == lastPage) return;
      final response = await LocatorService.chatService.getChatMessages(
        {'page': nextPage},
        conversationId: conversationId,
        rethrowError: true,
      );
      response["data"] = response["data"]
          .map<MessageModel>((x) => MessageModel.fromJson(x))
          .toList();
      LocatorService.chat.setMessages(conversationId, response, refresh);
    } catch (e) {
      ErrorHelper.handleApiError(e);
    } finally {
      LocatorService.chat.setIsLoadingChat(conversationId, false);
    }
  }

  /// Send message
  static Future<bool> sendMessage({
    required num conversationId,
    String? message,
    List<String>? filePaths,
  }) async {
    if ((message == null || message.trim().isEmpty) &&
        (filePaths == null || filePaths.isEmpty)) {
      return false;
    }

    // Create optimistic message
    final tempMessage = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch,
      message: message,
      isTemp: true,
      files: filePaths
          ?.map(
            (path) => MessageFileModel(
              original: path,
              preview: path,
              thumb: path,
              isFile: true,
            ),
          )
          .toList(),
      isMine: true,
      createdAt: 'الآن',
      status: MessageStatus.sending,
    );

    // Add to list immediately (optimistic update)
    LocatorService.chat.addOptimisticMessage(conversationId, tempMessage);

    try {
      final response = await LocatorService.chatService.sendMessage(
        conversationId: conversationId,
        message: message,
        filePaths: filePaths,
        rethrowError: true,
      );

      // Update with real message from server
      // final sentMessage = MessageModel.fromJson(response['data']);
      LocatorService.chat.updateMessageStatus(
        conversationId,
        tempMessage.id!,
        tempMessage.copyWith(status: MessageStatus.sent),
      );

      return true;
    } catch (e) {
      // Mark as failed
      LocatorService.chat.updateMessageStatus(
        conversationId,
        tempMessage.id!,
        tempMessage.copyWith(status: MessageStatus.failed),
      );
      ErrorHelper.handleApiError(e);
      return false;
    }
  }

  /// Initialize Pusher and subscribe
  static Future<void> initPusher({
    required num conversationId,
    required String pusherKey,
    required String cluster,
  }) async {
    await LocatorService.chat.initPusher(
      conversationId: conversationId,
      pusherKey: pusherKey,
      cluster: cluster,
    );
  }

  /// Retry failed message
  static Future<bool> retryMessage({
    required num conversationId,
    required MessageModel message,
  }) async {
    // Update status to sending
    LocatorService.chat.updateMessageStatus(
      conversationId,
      message.id!,
      message.copyWith(status: MessageStatus.sending),
    );

    // Retry sending
    return await sendMessage(
      conversationId: conversationId,
      message: message.message,
      filePaths: message.files?.map((file) => file.original ?? '').toList(),
    );
  }

  /// Update presence - called every 10 seconds while user is in chat
  static Future<void> updatePresence({required num conversationId}) async {
    try {
      await LocatorService.chatService.updatePresence(
        conversationId: conversationId,
        rethrowError: false,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  /// Leave chat - called when user leaves chat screen or app goes to background
  static Future<void> leaveChat({required num conversationId}) async {
    try {
      await LocatorService.chatService.leaveChat(
        conversationId: conversationId,

        rethrowError: false,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> getConversationDetails(num receiverId) async {
    try {
      final response = await LocatorService.chatService
          .updateConversationsDetails(
            receiverId: receiverId,
            rethrowError: false,
          );
      LocatorService.chat.setConversationsDetails(
        receiverId,
        ConversationsModel.fromJson(response['data']),
      );
    } catch (e) {
      // ErrorHelper.handleApiError(e);
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
