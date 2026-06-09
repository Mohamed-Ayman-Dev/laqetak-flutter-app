import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invastro/src/features/chat/data/models/conversations_model.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../core/shared/models/pagination_list.dart';
import '../../data/models/message_model.dart';
import '../../data/services/pusher_service.dart';

class Chat with ChangeNotifier {
  PaginationList<ConversationsModel>? myConversations;
  bool isLoadingConversations = false;
  Map<num, bool> isLoadingChat = {};
  Map<num, PaginationList<MessageModel>> messagesMap = {};
  Map<num, ScrollController> scrollControllers = {};
  Map<num, Function(PusherEvent)?> _pusherListeners = {};
  Map<num, ConversationsModel> conversationDetails = {};

  void setLoadingConversations(bool value) {
    isLoadingConversations = value;
    notifyListeners();
  }

  void setMessages(num conversationId, dynamic data, bool refresh) {
    if (messagesMap[conversationId] == null || refresh) {
      messagesMap[conversationId] = PaginationList.fromJson(data);
    } else {
      messagesMap[conversationId]?.addItemsToList(data);
    }
    notifyListeners();
  }

  void setIsLoadingChat(num conversationId, bool isLoading) {
    isLoadingChat[conversationId] = isLoading;
    notifyListeners();
  }

  void setConversations(dynamic data, bool refresh) {
    if (myConversations == null || refresh) {
      myConversations = PaginationList.fromJson(data);
    } else {
      myConversations?.addItemsToList(data);
    }
    notifyListeners();
  }

  void setConversationsDetails(
    num conversationId,
    ConversationsModel conversation,
  ) {
    if (conversationDetails[conversationId] == conversation) {
      return;
    }
    if (conversationDetails.containsKey(conversationId)) {
      conversationDetails.update(conversationId, (_) => conversation);
    } else {
      conversationDetails[conversationId] = conversation;
    }
    notifyListeners();
  }

  void addOptimisticMessage(num conversationId, MessageModel message) {
    if (messagesMap[conversationId]?.data != null) {
      messagesMap[conversationId]!.data!.insert(0, message);
      notifyListeners();

      // Auto-scroll to bottom
      final controller = scrollControllers[conversationId];
      if (controller != null && controller.hasClients) {
        controller.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  void updateMessageStatus(
    num conversationId,
    num tempId,
    MessageModel newMessage,
  ) {
    final index = messagesMap[conversationId]!.data!.indexWhere(
      (m) => m.id == tempId,
    );
    if (index != -1) {
      messagesMap[conversationId]!.data![index] = newMessage;
      notifyListeners();
    }
  }

  /// Initialize Pusher and subscribe to channel using centralized PusherService
  Future<void> initPusher({
    required num conversationId,
    required String pusherKey,
    required String cluster,
  }) async {
    try {
      conversationId;
      final pusherService = PusherService.instance;

      // Initialize Pusher if not already done
      if (!pusherService.isInitialized) {
        await pusherService.init(apiKey: pusherKey, cluster: cluster);
      }

      // Create event handler for this offerId
      void listener(PusherEvent event) {
        _handlePusherEvent(conversationId, event);
      }

      // Store listener reference
      _pusherListeners[conversationId] = listener;

      // Subscribe to channel
      await pusherService.subscribe(
        channelName: 'chatting-offer-channel-$conversationId',
        onEvent: listener,
      );
    } catch (e) {
      debugPrint('Error initializing Pusher for offerId $conversationId: $e');
    }
  }

  /// Handle incoming Pusher events
  void _handlePusherEvent(num conversationId, PusherEvent event) {
    try {
      final messageData = jsonDecode(event.data);
      final currentOfferId = messageData['quoteOfferId'].toString();
      final message = MessageModel.fromPusher(messageData);

      // Add message to the beginning of the list (newest first)
      if (messagesMap[currentOfferId]?.data != null) {
        int messageIndex = -1;
        for (int i = 0; i < messagesMap[conversationId]!.data!.length; i++) {
          if (messagesMap[conversationId]!.data![i].isTemp &&
              messagesMap[conversationId]!.data![i].message!.trim() ==
                  message.message!.trim()) {
            messageIndex = i;
            break;
          }
          if (i == 9) break;
        }
        if (messageIndex == -1) {
          messageIndex = messagesMap[conversationId]!.data!.indexWhere(
            (e) => e.id == message.id,
          );
        }
        if (messageIndex == -1) {
          messagesMap[currentOfferId]!.data!.insert(0, message);
        } else {
          messagesMap[currentOfferId]!.data![messageIndex] = message;
          notifyListeners();
        }

        // Auto-scroll to bottom if user is near bottom
        final controller = scrollControllers[conversationId];
        if (controller != null && controller.hasClients) {
          if (controller.position.pixels < 100) {
            controller.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        }

        notifyListeners();
      }
    } catch (e, s) {
      debugPrint('Error handling Pusher event: $e');
    }
  }

  /// Dispose Pusher connection for specific offerId
  Future<void> disposePusher(num conversationId) async {
    try {
      final pusherService = PusherService.instance;
      final listener = _pusherListeners[conversationId];

      await pusherService.unsubscribe(
        channelName: 'chatting-offer-channel-$conversationId',
        listener: listener,
      );

      _pusherListeners.remove(conversationId);
    } catch (e) {
      debugPrint('Error disposing Pusher: $e');
    }
  }

  /// Get scroll controller for offerId
  ScrollController getScrollController(num conversationId) {
    if (!scrollControllers.containsKey(conversationId)) {
      scrollControllers[conversationId] = ScrollController();
    }
    return scrollControllers[conversationId]!;
  }

  /// Dispose scroll controller
  void disposeScrollController(num conversationId) {
    scrollControllers[conversationId]?.dispose();
    scrollControllers.remove(conversationId);
  }

  void clearMessagesForLogOut() {
    messagesMap = {};
    isLoadingChat = {};
    scrollControllers = {};
    _pusherListeners = {};
  }

  @override
  void dispose() {
    for (final key in _pusherListeners.keys) {
      disposePusher(key);
    }
    scrollControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }
}
