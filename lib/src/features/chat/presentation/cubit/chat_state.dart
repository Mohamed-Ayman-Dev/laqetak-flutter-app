import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../data/models/conversations_model.dart';
import '../../data/models/message_model.dart';

class ChatState extends Equatable {
  const ChatState({
    this.conversations,
    this.conversationsStatus = RequestStatus.initial,
    this.messages = const {},
    this.messagesStatus = const {},
    this.conversationDetails = const {},
    this.errorMessage,
  });

  final PaginationList<ConversationsModel>? conversations;
  final RequestStatus conversationsStatus;
  final Map<num, PaginationList<MessageModel>> messages;
  final Map<num, RequestStatus> messagesStatus;
  final Map<num, ConversationsModel> conversationDetails;
  final String? errorMessage;

  bool get hasConversationsError => conversationsStatus == RequestStatus.error;

  ChatState copyWith({
    PaginationList<ConversationsModel>? conversations,
    RequestStatus? conversationsStatus,
    Map<num, PaginationList<MessageModel>>? messages,
    Map<num, RequestStatus>? messagesStatus,
    Map<num, ConversationsModel>? conversationDetails,
    String? errorMessage,
    bool clearConversations = false,
  }) => ChatState(
    conversations: clearConversations
        ? null
        : (conversations ?? this.conversations),
    conversationsStatus: conversationsStatus ?? this.conversationsStatus,
    messages: messages ?? this.messages,
    messagesStatus: messagesStatus ?? this.messagesStatus,
    conversationDetails: conversationDetails ?? this.conversationDetails,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    conversations,
    conversationsStatus,
    messages,
    messagesStatus,
    conversationDetails,
    errorMessage,
  ];
}
