import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:laqetak/src/core/constants/app_feedback.dart';
import 'package:laqetak/src/core/constants/enums.dart';
import 'package:laqetak/src/features/chat/data/models/conversations_model.dart';
import 'package:laqetak/src/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:laqetak/src/features/chat/presentation/cubit/chat_state.dart';
import 'package:laqetak/src/features/chat/presentation/widgets/conversation_item.dart';
import 'package:laqetak/src/features/chat/presentation/widgets/shimmers/convesation_item_shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../../../core/widgets/lists/empty_list_placeholder_widget.dart';
import '../../../../core/widgets/lists/list_loading_end_widget.dart';
import '../../../../core/widgets/lists/smart_refresher_header.dart';
import '../../../../core/widgets/login_first_widget.dart';
import '../../../../core/themes/colors.dart';
import 'chat_screen.dart';

class ConversationsScreen extends StatefulWidget {
  static const routeName = '/conversations_screen';

  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocatorService.authCubit.clearMessagesCount();
      if (isAuth) {
        context.read<ChatCubit>().getConversations(refresh: true);
      }
      _scrollController.addListener(_onStoresListener);
    });
    super.initState();
  }

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  bool _gettingData = false;

  Future<void> _refresh() async {
    final refreshController = _refreshController;
    if (isAuth) {
      await context.read<ChatCubit>().getConversations(refresh: true);
    }
    refreshController.refreshCompleted();
  }

  void _onStoresListener() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50.0 &&
        _gettingData == false) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 200), () async {
        _gettingData = true;
        await context.read<ChatCubit>().getConversations(refresh: false);
        _gettingData = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBKColor,
      body: !isAuth
          ? const LoginFirstWidget()
          : BlocListener<ChatCubit, ChatState>(
              listenWhen: (previous, current) =>
                  current.hasConversationsError &&
                  !previous.hasConversationsError,
              listener: (context, state) {
                AppFeedback.errorMessage(state.errorMessage);
              },
              child: SmartRefresher(
                scrollController: _scrollController,
                controller: _refreshController,
                onRefresh: _refresh,
                header: const SmartRefresherHeader(),
                child: SingleChildScrollView(
                  child:
                      BlocSelector<
                        ChatCubit,
                        ChatState,
                        PaginationList<ConversationsModel>?
                      >(
                        selector: (state) => state.conversations,
                        builder: (context, listProvider) {
                          List<ConversationsModel>? conversations =
                              listProvider?.data;

                          return conversations != null && conversations.isEmpty
                              ? EmptyListPlaceholderWidget(
                                  text: S
                                      .of(context)
                                      .thereAreNoConversationsYet,
                                  paddingTop: 300,
                                )
                              : Column(
                                  children: [
                                    ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                        top: 30,
                                        bottom: 100,
                                      ).r,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          AnimationConfiguration.staggeredList(
                                            position: index,
                                            delay: const Duration(
                                              milliseconds: 10,
                                            ),
                                            child: SlideAnimation(
                                              verticalOffset: 10,
                                              duration: const Duration(
                                                milliseconds: 800,
                                              ),
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              child: FadeInAnimation(
                                                duration: const Duration(
                                                  milliseconds: 1000,
                                                ),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn,
                                                child: conversations == null
                                                    ? ConversationItemShimmer()
                                                    : ConversationItem(
                                                        title:
                                                            conversations[index]
                                                                .otherUser
                                                                ?.name ??
                                                            '',
                                                        onTab: () {
                                                          LocatorService
                                                              .navigationService
                                                              .currentState
                                                              ?.pushNamed(
                                                                ChatScreen
                                                                    .routeName,
                                                                arguments: {
                                                                  'conversation':
                                                                      conversations[index],
                                                                },
                                                              );
                                                        },
                                                        desc:
                                                            conversations[index]
                                                                .latestMessage
                                                                ?.message ??
                                                            S
                                                                .of(context)
                                                                .pressToChat,
                                                        date:
                                                            conversations[index]
                                                                .updatedAtHuman ??
                                                            '',
                                                        image:
                                                            conversations[index]
                                                                .otherUser
                                                                ?.avatar ??
                                                            '',
                                                        messageCount:
                                                            conversations[index]
                                                                .unseenCount ??
                                                            0,
                                                      ),
                                              ),
                                            ),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          22.heightSpace,
                                      itemCount: conversations?.length ?? 10,
                                    ),
                                    BlocSelector<ChatCubit, ChatState, bool>(
                                      selector: (state) =>
                                          state.conversationsStatus ==
                                          RequestStatus.loading,
                                      builder: (context, isLoading) {
                                        return ListLoadingEndWidget(
                                          lastPage: listProvider?.lastPage ?? 1,
                                          currentPage:
                                              listProvider?.currentPage ?? 1,
                                          isLoading: isLoading,
                                          listLessThan:
                                              conversations != null &&
                                              conversations.length > 6,
                                          noMoreText: S
                                              .of(context)
                                              .thereAreNoMoreConversations,
                                        );
                                      },
                                    ),
                                  ],
                                );
                        },
                      ),
                ),
              ),
            ),
    );
  }
}
