import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/constants/app_feedback.dart';
import 'package:laqetak/src/core/di/locator_service.dart';
import 'package:laqetak/src/core/widgets/lists_widgets/empty_list_placeholder_widget.dart';
import 'package:laqetak/src/core/themes/theme.dart';
import 'package:laqetak/src/features/chat/data/models/conversations_model.dart';
import 'package:laqetak/src/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:laqetak/src/features/chat/presentation/cubit/chat_state.dart';
import 'package:laqetak/src/features/chat/presentation/widgets/shimmers/message_item_shimmer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/helpers/image_utils.dart';
import '../../../../core/shared/models/customer_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../data/models/message_model.dart';
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
        final cubit = context.read<ChatCubit>();
        cubit.getConversationDetails(_receiver!.id!).then((_) {
          if (!mounted) return;
          final updateConversationDetail =
              cubit.state.conversationDetails[_receiver!.id!];
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
      Future.delayed(Duration.zero, () {
        LocatorService.chatCubit.markConversationRead(
          conversationId: _conversationId!,
        );
        LocatorService.chatCubit.getMessages(
          conversationId: _conversationId!,
          refresh: true,
        );
      });

      LocatorService.chatCubit.initPusher(conversationId: _conversationId!);

      _startPresenceTimer();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (_conversationId == null) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _startPresenceTimer();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
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
    _stopPresenceTimer();

    _updatePresence();

    _presenceTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _updatePresence(),
    );
  }

  void _stopPresenceTimer() {
    _presenceTimer?.cancel();
    _presenceTimer = null;
  }

  void _updatePresence() {
    if (_conversationId != null) {
      LocatorService.chatCubit.updatePresence(conversationId: _conversationId!);
    }
  }

  void _leaveChat() {
    if (_conversationId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        LocatorService.chatCubit.leaveChat(conversationId: _conversationId!);
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
      LocatorService.chatCubit.disposeScrollController(_conversationId!);
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
      body: BlocListener<ChatCubit, ChatState>(
        listenWhen: (previous, current) =>
            current.errorMessage != null &&
            current.errorMessage != previous.errorMessage,
        listener: (context, state) {
          AppFeedback.errorMessage(state.errorMessage);
        },
        child: SafeArea(
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
                      child:
                          BlocSelector<
                            ChatCubit,
                            ChatState,
                            PaginationList<MessageModel>?
                          >(
                            selector: (state) =>
                                state.messages[_conversationId],
                            builder: (context, list) {
                              final scrollController = LocatorService.chatCubit
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
                                        if (scrollInfo.metrics.pixels >=
                                            scrollInfo.metrics.maxScrollExtent -
                                                200) {
                                          LocatorService.chatCubit.getMessages(
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
                                                    messages[index].message ??
                                                    '',
                                                isMine:
                                                    messages[index].isMine ??
                                                    false,
                                                heroImage:
                                                    '$index-"messageBody"-chat',
                                                images: messages[index].files,
                                                createdAt:
                                                    messages[index].createdAt ??
                                                    '',
                                                seenAt:
                                                    messages[index].seenAtHuman,
                                                status: messages[index].status,
                                                onRetry:
                                                    messages[index].status ==
                                                        MessageStatus.failed
                                                    ? () => LocatorService
                                                          .chatCubit
                                                          .retryMessage(
                                                            conversationId:
                                                                _conversationId!,
                                                            message:
                                                                messages[index],
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
                        LocatorService.chatCubit.sendMessage(
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
      ),
    );
  }
}
