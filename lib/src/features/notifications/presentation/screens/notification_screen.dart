import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:invastro/src/core/constants/app_feedback.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/widgets/buttons_widgets/my_icon_button.dart';
import 'package:invastro/src/core/widgets/lists_widgets/empty_list_placeholder_widget.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/notifications/data/models/notification_model.dart';
import 'package:invastro/src/features/notifications/presentation/widgets/notification_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/widgets/lists_widgets/list_loading_end_widget.dart';
import '../../../../core/widgets/lists_widgets/smart_refresher_header.dart';
import '../../../../core/widgets/login_first_widget.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';
import '../widgets/notification_shimmer.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notifications_screen';

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocatorService.authCubit.clearNotificationsCount();

      if (isAuth) {
        final cubit = context.read<NotificationsCubit>();
        cubit.getNotifications(refresh: true).then((_) => cubit.markAllRead());
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
    await context.read<NotificationsCubit>().getNotifications(refresh: true);
    refreshController.refreshCompleted();
  }

  void _onStoresListener() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50.0 &&
        _gettingData == false) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 200), () async {
        _gettingData = true;
        await context.read<NotificationsCubit>().getNotifications(
          refresh: false,
        );
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<NotificationsCubit, NotificationsState>(
            listenWhen: (previous, current) =>
                current.hasListError && !previous.hasListError,
            listener: (context, state) {
              if (state.actionStatus == RequestStatus.loading) return;
              AppFeedback.errorMessage(state.errorMessage);
            },
          ),
          BlocListener<NotificationsCubit, NotificationsState>(
            listenWhen: (previous, current) =>
                previous.actionStatus != current.actionStatus,
            listener: (context, state) {
              switch (state.actionStatus) {
                case RequestStatus.loading:
                  AppFeedback.loadingMessage(
                    message: state.lastMutation == NotificationMutation.delete
                        ? S.current.deletingNotification
                        : S.current.respondingToRequest,
                  );
                case RequestStatus.success:
                  AppFeedback.showToast(
                    state.lastMutation == NotificationMutation.delete
                        ? S.current.notificationDeletedSuccessfully
                        : S.current.responseSentSuccessfully,
                  );
                  LocatorService.adDetailsCubit.clearPhoneRequestLoading();
                case RequestStatus.error:
                  AppFeedback.errorMessage(state.errorMessage);
                  LocatorService.adDetailsCubit.clearPhoneRequestLoading();
                case RequestStatus.initial:
                  break;
              }
            },
          ),
        ],
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          buildWhen: (previous, current) =>
              previous.notifications != current.notifications ||
              previous.listStatus != current.listStatus,
          builder: (context, state) {
            final List<NotificationModel>? notifications =
                state.notifications?.data;
            final isLoading = state.listStatus == RequestStatus.loading;

            return !isAuth
                ? const LoginFirstWidget()
                : SmartRefresher(
                    scrollController: _scrollController,
                    controller: _refreshController,
                    onRefresh: _refresh,
                    header: const SmartRefresherHeader(),
                    child: SingleChildScrollView(
                      child: notifications != null && notifications.isEmpty
                          ? EmptyListPlaceholderWidget(
                              text: S.of(context).thereAreNoNotificationsYet,
                              paddingTop: 300,
                            )
                          : Column(
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                    top: 25,
                                    bottom: 100,
                                  ).r,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                                    position: index,
                                    delay: const Duration(milliseconds: 10),
                                    child: SlideAnimation(
                                      verticalOffset: 10,
                                      duration: const Duration(
                                        milliseconds: 800,
                                      ),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: FadeInAnimation(
                                        duration: const Duration(
                                          milliseconds: 1000,
                                        ),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        child: notifications == null
                                            ? NotificationItemShimmer()
                                            : Slidable(
                                                startActionPane: ActionPane(
                                                  motion: const StretchMotion(),
                                                  extentRatio: 1 / 5,
                                                  children: [
                                                    CustomSlidableAction(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                      onPressed: (_) {},
                                                      backgroundColor:
                                                          Colors.white,
                                                      padding: EdgeInsets.zero,
                                                      child: Row(
                                                        children: [
                                                          10.widthSpace,
                                                          MyIconButton(
                                                            width: 40,
                                                            height: 40,
                                                            onTap: () {
                                                              DialogHelpers.showYesNoDialog(
                                                                title: S
                                                                    .current
                                                                    .confirmAction,
                                                                subtitle: S
                                                                    .of(context)
                                                                    .areYouSureYouWantToDeleteThisNotification,
                                                                onButtonTap: () {
                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                  context
                                                                      .read<
                                                                        NotificationsCubit
                                                                      >()
                                                                      .deleteNotification(
                                                                        notifications[index].id ??
                                                                            0,
                                                                      );
                                                                },
                                                              );
                                                            },
                                                            bkColor: AppColors
                                                                .deleteIconButtonBKColor,
                                                            icon: SvgAssets
                                                                .assetsSvgDeleteIcon,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: NotificationItem(
                                                  title:
                                                      notifications[index]
                                                          .alertText ??
                                                      '',
                                                  index: index,
                                                  rawData:
                                                      notifications[index]
                                                          .data ??
                                                      '',
                                                  desc:
                                                      notifications[index]
                                                          .alertBody ??
                                                      '',
                                                  date:
                                                      notifications[index]
                                                          .createdAt ??
                                                      '',
                                                  messageCount: false,
                                                  isSeen:
                                                      (notifications[index]
                                                          .read ==
                                                      1),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      15.heightSpace,
                                  itemCount: notifications?.length ?? 6,
                                ),
                                ListLoadingEndWidget(
                                  lastPage: state.notifications?.lastPage ?? 1,
                                  currentPage:
                                      state.notifications?.currentPage ?? 1,
                                  isLoading: isLoading,
                                  listLessThan:
                                      notifications != null &&
                                      notifications.length > 6,
                                  noMoreText: S
                                      .of(context)
                                      .thereAreNoMoreNotifications,
                                ),
                              ],
                            ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
