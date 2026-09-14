import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../data/models/notification_model.dart';

enum NotificationMutation { none, delete, respond }

class NotificationsState extends Equatable {
  const NotificationsState({
    this.notifications,
    this.listStatus = RequestStatus.initial,
    this.actionStatus = RequestStatus.initial,
    this.lastMutation = NotificationMutation.none,
    this.errorMessage,
  });

  final PaginationList<NotificationModel>? notifications;
  final RequestStatus listStatus;
  final RequestStatus actionStatus;
  final NotificationMutation lastMutation;
  final String? errorMessage;

  List<NotificationModel> get items => notifications?.data ?? const [];

  bool get hasListError => listStatus == RequestStatus.error;

  bool get hasActionError => actionStatus == RequestStatus.error;

  NotificationsState copyWith({
    PaginationList<NotificationModel>? notifications,
    RequestStatus? listStatus,
    RequestStatus? actionStatus,
    NotificationMutation? lastMutation,
    String? errorMessage,
    bool clearNotifications = false,
  }) => NotificationsState(
    notifications: clearNotifications
        ? null
        : (notifications ?? this.notifications),
    listStatus: listStatus ?? this.listStatus,
    actionStatus: actionStatus ?? this.actionStatus,
    lastMutation: lastMutation ?? this.lastMutation,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    notifications,
    listStatus,
    actionStatus,
    lastMutation,
    errorMessage,
  ];
}
