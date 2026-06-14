import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/my_icon_button.dart';
import 'package:invastro/src/core/shared/widgets/lists_widgets/empty_list_placeholder_widget.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/notifications/data/models/notification_model.dart';
import 'package:invastro/src/features/notifications/presentation/controllers/notifications_controller.dart';
import 'package:invastro/src/features/notifications/presentation/widgets/notification_item.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../../../core/shared/widgets/lists_widgets/list_loading_end_widget.dart';
import '../../../../core/shared/widgets/lists_widgets/smart_refresher_header.dart';
import '../../../../core/shared/widgets/login_first_widget.dart';
import '../providers/notifications.dart';
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
      LocatorService.auth.clearNotificationsCount();

      if (isAuth) {
        NotificationsController.getNotifications(refresh: true);
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
    await NotificationsController.getNotifications(refresh: true);
    refreshController.refreshCompleted();
  }

  void _onStoresListener() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50.0 &&
        _gettingData == false) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 200), () async {
        _gettingData = true;
        await NotificationsController.getNotifications(refresh: false);
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
      body: Selector<Notifications, PaginationList<NotificationModel>?>(
        selector: (context, provider) => provider.myNotifications,
        builder: (context, listProvider, child) {
          List<NotificationModel>? notifications = listProvider?.data;

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
                                    duration: const Duration(milliseconds: 800),
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
                                                    // ← delete logic here
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
                                                                NotificationsController.deleteSingleNotification(
                                                                  notifications[index]
                                                                          .id ??
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

                              Selector<Notifications, bool>(
                                selector: (context, provider) =>
                                    provider.isLoading,
                                builder: (context, isLoading, child) {
                                  return ListLoadingEndWidget(
                                    lastPage: listProvider?.lastPage ?? 1,
                                    currentPage: listProvider?.currentPage ?? 1,
                                    isLoading: isLoading,
                                    listLessThan:
                                        notifications != null &&
                                        notifications.length > 6,
                                    noMoreText: S
                                        .of(context)
                                        .thereAreNoMoreNotifications,
                                  );
                                },
                              ),
                            ],
                          ),
                  ),
                );
        },
      ),
    );
  }
}
