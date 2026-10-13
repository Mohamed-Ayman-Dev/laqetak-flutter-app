import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:laqetak/src/core/bloc_helpers/base_cubit.dart';
import 'package:laqetak/src/features/chat/data/repositories/chat_repository.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/config/app_env.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../data/models/conversations_model.dart';
import '../../data/models/message_file_model.dart';
import '../../data/models/message_model.dart';
import '../../data/services/pusher_service.dart';
import 'chat_state.dart';

class ChatCubit extends BaseCubit<ChatState> {
  ChatCubit(this._chatRepository) : super(const ChatState());

  final ChatRepository _chatRepository;
  final Map<num, ScrollController> _scrollControllers = {};
  final Map<num, Function(PusherEvent)?> _pusherListeners = {};

  Future<void> getConversations({bool refresh = false}) async {
    final current = state.conversations;
    if (!refresh &&
        current != null &&
        current.currentPage != null &&
        current.currentPage == current.lastPage) {
      return;
    }
    if (state.conversationsStatus == RequestStatus.loading) return;

    emit(state.copyWith(conversationsStatus: RequestStatus.loading));
    final nextPage = refresh ? 1 : ((current?.currentPage ?? 0) + 1);
    final result = await _chatRepository.getConversations(nextPage);
    result.when(
      success: (page) => emit(
        state.copyWith(
          conversations: refresh || current == null
              ? page
              : _appendConversations(current, page),
          conversationsStatus: RequestStatus.success,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          conversationsStatus: RequestStatus.error,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> getMessages({
    required num conversationId,
    bool refresh = false,
  }) async {
    final current = state.messages[conversationId];
    if (!refresh &&
        current != null &&
        current.currentPage != null &&
        current.currentPage == current.lastPage) {
      return;
    }
    if (state.messagesStatus[conversationId] == RequestStatus.loading) {
      return;
    }

    final statuses = Map<num, RequestStatus>.from(state.messagesStatus);
    statuses[conversationId] = RequestStatus.loading;
    emit(state.copyWith(messagesStatus: statuses));

    final nextPage = refresh ? 1 : ((current?.currentPage ?? 0) + 1);
    final result = await _chatRepository.getMessages(
      conversationId: conversationId,
      page: nextPage,
    );
    result.when(
      success: (page) {
        final messages = Map<num, PaginationList<MessageModel>>.from(
          state.messages,
        );
        messages[conversationId] = refresh || current == null
            ? page
            : _appendMessages(current, page);
        final nextStatuses = Map<num, RequestStatus>.from(state.messagesStatus);
        nextStatuses[conversationId] = RequestStatus.success;
        emit(state.copyWith(messages: messages, messagesStatus: nextStatuses));
      },
      failure: (error) {
        final nextStatuses = Map<num, RequestStatus>.from(state.messagesStatus);
        nextStatuses[conversationId] = RequestStatus.error;
        emit(
          state.copyWith(
            messagesStatus: nextStatuses,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  Future<bool> sendMessage({
    required num conversationId,
    String? message,
    List<String>? filePaths,
  }) async {
    if ((message == null || message.trim().isEmpty) &&
        (filePaths == null || filePaths.isEmpty)) {
      return false;
    }

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
      createdAtHuman: S.current.now,
      status: MessageStatus.sending,
    );
    _addOptimisticMessage(conversationId, tempMessage);

    final result = await _chatRepository.sendMessage(
      conversationId: conversationId,
      message: message,
      filePaths: filePaths,
    );
    return result.when(
      success: (sent) {
        _updateMessage(
          conversationId,
          tempMessage.id!,
          sent.copyWith(status: MessageStatus.sent),
        );
        return true;
      },
      failure: (error) {
        _updateMessage(
          conversationId,
          tempMessage.id!,
          tempMessage.copyWith(status: MessageStatus.failed),
        );
        emit(state.copyWith(errorMessage: error.message));
        return false;
      },
    );
  }

  Future<bool> retryMessage({
    required num conversationId,
    required MessageModel message,
  }) async {
    _updateMessage(
      conversationId,
      message.id!,
      message.copyWith(status: MessageStatus.sending),
    );
    return sendMessage(
      conversationId: conversationId,
      message: message.message,
      filePaths: message.files?.map((file) => file.original ?? '').toList(),
    );
  }

  Future<void> getConversationDetails(num receiverId) async {
    final result = await _chatRepository.openConversation(receiverId);
    result.when(
      success: (conversation) {
        final details = Map<num, ConversationsModel>.from(
          state.conversationDetails,
        );
        details[receiverId] = conversation;
        emit(state.copyWith(conversationDetails: details));
      },
      failure: (error) {
        if (kDebugMode) {
          debugPrint(error.message);
        }
      },
    );
  }

  Future<void> updatePresence({required num conversationId}) async {
    await _chatRepository.updatePresence(conversationId);
  }

  Future<void> leaveChat({required num conversationId}) async {
    await _chatRepository.leaveChat(conversationId);
  }

  void markConversationRead({required num conversationId}) {
    final current = state.conversations;
    if (current?.data == null) return;
    final index = current!.data!.indexWhere((e) => e.id == conversationId);
    if (index == -1) return;
    final data = [...current.data!];
    data[index] = data[index].copyWith(unseenCount: 0);
    emit(state.copyWith(conversations: _copyConversations(current, data)));
  }

  Future<void> initPusher({required num conversationId}) async {
    if (!AppEnv.hasPusherKey) {
      debugPrint(
        'Pusher key missing. Copy env.example.json to env.json and run with --dart-define-from-file=env.json',
      );
      return;
    }
    try {
      final pusherService = PusherService.instance;
      if (!pusherService.isInitialized) {
        await pusherService.init(
          apiKey: AppEnv.pusherKey,
          cluster: AppEnv.pusherCluster,
        );
      }
      void listener(PusherEvent event) {
        _handlePusherEvent(conversationId, event);
      }

      _pusherListeners[conversationId] = listener;
      await pusherService.subscribe(
        channelName: 'private-conversation.$conversationId',
        onEvent: listener,
      );
    } catch (e) {
      debugPrint('Error initializing Pusher for offerId $conversationId: $e');
    }
  }

  Future<void> disposePusher(num conversationId) async {
    try {
      final listener = _pusherListeners[conversationId];
      await PusherService.instance.unsubscribe(
        channelName: 'private-conversation.$conversationId',
        listener: listener,
      );
      _pusherListeners.remove(conversationId);
    } catch (e) {
      debugPrint('Error disposing Pusher: $e');
    }
  }

  ScrollController getScrollController(num conversationId) {
    return _scrollControllers.putIfAbsent(conversationId, ScrollController.new);
  }

  void disposeScrollController(num conversationId) {
    _scrollControllers[conversationId]?.dispose();
    _scrollControllers.remove(conversationId);
  }

  void resetOnLogout() {
    for (final controller in _scrollControllers.values) {
      controller.dispose();
    }
    _scrollControllers.clear();
    _pusherListeners.clear();
    emit(const ChatState());
  }

  void _addOptimisticMessage(num conversationId, MessageModel message) {
    final page = state.messages[conversationId];
    if (page?.data == null) return;
    final data = [...page!.data!];
    data.insert(0, message);
    final messages = Map<num, PaginationList<MessageModel>>.from(
      state.messages,
    );
    messages[conversationId] = _copyMessages(page, data);
    emit(state.copyWith(messages: messages));
    _scrollToBottom(conversationId);
  }

  void _updateMessage(num conversationId, num tempId, MessageModel newMessage) {
    final page = state.messages[conversationId];
    if (page?.data == null) return;
    final index = page!.data!.indexWhere((m) => m.id == tempId);
    if (index == -1) return;
    final data = [...page.data!];
    data[index] = newMessage;
    final messages = Map<num, PaginationList<MessageModel>>.from(
      state.messages,
    );
    messages[conversationId] = _copyMessages(page, data);
    emit(state.copyWith(messages: messages));
  }

  void _handlePusherEvent(num conversationId, PusherEvent event) {
    try {
      if (event.eventName == 'pusher:subscription_succeeded') return;
      final messageData = jsonDecode(event.data);
      final message = MessageModel.fromPusher(messageData);
      final page = state.messages[conversationId];
      if (page?.data == null) return;
      final data = [...page!.data!];
      var messageIndex = -1;
      for (var i = 0; i < data.length; i++) {
        if (data[i].isTemp &&
            data[i].message!.trim() == message.message!.trim()) {
          messageIndex = i;
          break;
        }
        if (i == 9) break;
      }
      if (messageIndex == -1) {
        messageIndex = data.indexWhere((e) => e.id == message.id);
      }
      if (messageIndex == -1) {
        data.insert(0, message);
      } else {
        data[messageIndex] = message;
      }
      final messages = Map<num, PaginationList<MessageModel>>.from(
        state.messages,
      );
      messages[conversationId] = _copyMessages(page, data);
      emit(state.copyWith(messages: messages));
      final controller = _scrollControllers[conversationId];
      if (controller != null &&
          controller.hasClients &&
          controller.position.pixels < 100) {
        controller.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } catch (e) {
      debugPrint('Error handling Pusher event: $e');
    }
  }

  void _scrollToBottom(num conversationId) {
    final controller = _scrollControllers[conversationId];
    if (controller != null && controller.hasClients) {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  PaginationList<ConversationsModel> _appendConversations(
    PaginationList<ConversationsModel> current,
    PaginationList<ConversationsModel> next,
  ) {
    return _copyConversations(next, [...?current.data, ...?next.data]);
  }

  PaginationList<MessageModel> _appendMessages(
    PaginationList<MessageModel> current,
    PaginationList<MessageModel> next,
  ) {
    return _copyMessages(next, [...?current.data, ...?next.data]);
  }

  PaginationList<ConversationsModel> _copyConversations(
    PaginationList<ConversationsModel> page,
    List<ConversationsModel> data,
  ) {
    return PaginationList<ConversationsModel>(
      data: data,
      currentPage: page.currentPage,
      firstPageUrl: page.firstPageUrl,
      from: page.from,
      lastPage: page.lastPage,
      lastPageUrl: page.lastPageUrl,
      nextPageUrl: page.nextPageUrl,
      path: page.path,
      perPage: page.perPage,
      prevPageUrl: page.prevPageUrl,
      to: page.to,
      total: page.total,
    );
  }

  PaginationList<MessageModel> _copyMessages(
    PaginationList<MessageModel> page,
    List<MessageModel> data,
  ) {
    return PaginationList<MessageModel>(
      data: data,
      currentPage: page.currentPage,
      firstPageUrl: page.firstPageUrl,
      from: page.from,
      lastPage: page.lastPage,
      lastPageUrl: page.lastPageUrl,
      nextPageUrl: page.nextPageUrl,
      path: page.path,
      perPage: page.perPage,
      prevPageUrl: page.prevPageUrl,
      to: page.to,
      total: page.total,
    );
  }
}
