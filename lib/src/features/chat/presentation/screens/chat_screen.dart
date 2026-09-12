import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/shared/widgets/lists_widgets/empty_list_placeholder_widget.dart';
import 'package:invastro/src/core/themes/theme.dart';
import 'package:invastro/src/features/chat/data/models/conversations_model.dart';
import 'package:invastro/src/features/chat/presentation/providers/chat.dart';
import 'package:invastro/src/features/chat/presentation/widgets/shimmers/message_item_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/helpers/image_utils.dart';
import '../../../../core/shared/models/customer_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../../data/models/message_model.dart';
import '../controllers/chat_controller.dart';
import '../widgets/attachment_preview.dart';
import '../widgets/chat_bottom_field.dart';
import '../widgets/chat_time.dart';
import '../widgets/message_item.dart';
import '../widgets/shimmers/chat_list_shimmer.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat_screen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  bool once = false;
  TextEditingController controller = TextEditingController();
  List<String> attachmentPaths = [];
  Timer? _presenceTimer;
  CustomerModel? _receiver;
  ConversationsModel? _conversation;
  num? _conversationId;

  @override
  void didChangeDependencies() {
    if (!once) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      // their are two cases ..
      // 1- conversation is already created and passed and this is the best case no need to do anything
      // 2- conversation is not created yet and receiver is passed
      // if conversation is not created yet and receiver is passed then add _receiver to empty conversation placeholder and get conversation details
      _receiver = args?['receiver'];
      _conversation =
          args?['conversation'] ?? ConversationsModel(otherUser: _receiver);
      _conversationId = _conversation?.id;
      //getting conversation Id and details if its null and only _receiver is passed
      if (_receiver?.id != null) {
        // _getConversationDetails();
        ChatController.getConversationDetails(_receiver!.id!).then((value) {
          final updateConversationDetail =
              LocatorService.chat.conversationDetails[_receiver!.id!];
          if (updateConversationDetail != null) {
            setState(() {
              _conversation = updateConversationDetail;
              _conversationId = _conversation?.id;
            });
          }
          _initChat();
        });
      } else {
        _initChat();
      }

      once = true;
    }
    super.didChangeDependencies();
  }

  void _initChat() {
    if (_conversationId != null) {
      // Load messages
      Future.delayed(Duration.zero, () {
        LocatorService.chat.setConversationAsZeroSeen(
          conversationId: _conversationId!,
        );
        ChatController.getMessages(
          conversationId: _conversationId!,
          refresh: true,
        );
      });

      // Initialize Pusher
      ChatController.initPusher(
        conversationId: _conversationId!,
        pusherKey: '18e688d12badb9fd7978',
        cluster: 'eu',
      );

      // Start presence timer
      _startPresenceTimer();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (_conversationId == null) return;

    switch (state) {
      case AppLifecycleState.resumed:
        // App came to foreground - restart presence updates
        _startPresenceTimer();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // App went to background - stop presence and leave chat
        _stopPresenceTimer();
        _leaveChat();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void _startPresenceTimer() {
    _stopPresenceTimer(); // Cancel existing timer if any

    // Update presence immediately
    _updatePresence();

    // Then update every 10 seconds
    _presenceTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _updatePresence(),
    );
  }

  void _stopPresenceTimer() {
    _presenceTimer?.cancel();
    _presenceTimer = null;
  }

  // void _getConversationDetails() async {
  //   await ChatController.getConversationDetails(_receiver!.id!);
  //   final updateConversationDetail =
  //       LocatorService.chat.conversationDetails[_receiver!.id!];
  //   if (updateConversationDetail != null) {
  //     setState(() {
  //       _conversation = updateConversationDetail;
  //       _conversationId = _conversation?.id;
  //     });
  //   }
  // }

  void _updatePresence() {
    if (_conversationId != null) {
      ChatController.updatePresence(conversationId: _conversationId!);
    }
  }

  void _leaveChat() {
    if (_conversationId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ChatController.leaveChat(conversationId: _conversationId!);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopPresenceTimer();
    _leaveChat();
    controller.dispose();
    if (_conversationId != null) {
      LocatorService.chat.disposeScrollController(_conversationId!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBKColor,
      appBar: CustomAppbar(
        icons: [AppbarIcons.chat],
        chatReceiver: _conversation?.otherUser,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        bottom: true,
        top: false,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                10.heightSpace,
                if (_conversationId == null)
                  ChatListShimmer()
                else
                  Expanded(
                    child: Selector<Chat, PaginationList<MessageModel>?>(
                      selector: (context, provider) =>
                          provider.messagesMap[_conversationId],
                      shouldRebuild: (previous, next) => true,
                      builder: (context, list, child) {
                        final scrollController = LocatorService.chat
                            .getScrollController(_conversationId!);
                        final messages = list?.data;
                        return messages != null && messages.isEmpty
                            ? EmptyListPlaceholderWidget(
                                text: S
                                    .of(context)
                                    .thereAreNoMessagesYetStartAConversation,
                              )
                            : NotificationListener<ScrollNotification>(
                                onNotification: (scrollInfo) {
                                  // Load more when scrolled to top (older messages)
                                  if (scrollInfo.metrics.pixels >=
                                      scrollInfo.metrics.maxScrollExtent -
                                          200) {
                                    ChatController.getMessages(
                                      conversationId: _conversationId!,
                                    );
                                  }
                                  return false;
                                },
                                child: ListView.separated(
                                  padding: EdgeInsets.fromLTRB(
                                    18,
                                    33,
                                    18,
                                    18,
                                  ).r,
                                  reverse: true,
                                  controller: scrollController,

                                  itemBuilder: (context, index) =>
                                      messages == null
                                      ? MessageItemShimmer(
                                          isMine: index % 2 == 0,
                                        )
                                      : MessageItem(
                                          message:
                                              messages[index].message ?? '',
                                          isMine:
                                              messages[index].isMine ?? false,
                                          heroImage:
                                              '$index-"messageBody"-chat',

                                          images: messages[index].files,
                                          createdAt:
                                              messages[index].createdAt ?? '',
                                          seenAt: messages[index].seenAtHuman,
                                          status: messages[index].status,
                                          onRetry:
                                              messages[index].status ==
                                                  MessageStatus.failed
                                              ? () =>
                                                    ChatController.retryMessage(
                                                      conversationId:
                                                          _conversationId!,
                                                      message: messages[index],
                                                    )
                                              : null,
                                          isTemp: messages[index].isTemp,
                                        ),
                                  separatorBuilder: (context, index) =>
                                      16.heightSpace,
                                  itemCount: messages?.length ?? 9,
                                ),
                              );
                      },
                    ),
                  ),
                AttachmentPreview(
                  filePaths: attachmentPaths,
                  onClear: () {
                    setState(() {
                      attachmentPaths.clear();
                    });
                  },
                  onRemoveAt: (index) {
                    setState(() {
                      attachmentPaths.removeAt(index);
                    });
                  },
                ),
                ChatBottomField(
                  onSend: () async {
                    final text = controller.text.trim();
                    if (text.isNotEmpty || attachmentPaths.isNotEmpty) {
                      ChatController.sendMessage(
                        conversationId: _conversationId ?? 0,
                        message: text.isNotEmpty ? text : null,
                        filePaths: attachmentPaths.isNotEmpty
                            ? attachmentPaths
                            : null,
                      );
                      controller.clear();
                      setState(() {
                        attachmentPaths.clear();
                      });
                    }
                  },
                  onAttachment: () async {
                    final pickedImage = await ImageUtils.openPickingOptions(
                      context,
                    );
                    if (pickedImage != null) {
                      setState(() {
                        attachmentPaths.add(pickedImage.path);
                      });
                    }
                  },
                  controller: controller,
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.all(16).r, child: ChatTime()),
          ],
        ),
      ),
    );
  }
}
