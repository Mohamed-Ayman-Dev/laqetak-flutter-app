import 'package:laqetak/src/core/bloc_helpers/base_cubit.dart';
import 'package:laqetak/src/features/notifications/data/repositories/notifications_repository.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../data/models/notification_model.dart';
import 'notifications_state.dart';

class NotificationsCubit extends BaseCubit<NotificationsState> {
  NotificationsCubit(this._notificationsRepository)
    : super(const NotificationsState());

  final NotificationsRepository _notificationsRepository;

  Future<void> getNotifications({bool refresh = false}) async {
    final current = state.notifications;
    if (!refresh &&
        current != null &&
        current.currentPage != null &&
        current.currentPage == current.lastPage) {
      return;
    }
    if (state.listStatus == RequestStatus.loading) return;

    emit(state.copyWith(listStatus: RequestStatus.loading));
    final nextPage = refresh ? 1 : ((current?.currentPage ?? 0) + 1);
    final result = await _notificationsRepository.getNotifications(nextPage);
    result.when(
      success: (page) {
        emit(
          state.copyWith(
            notifications: refresh || current == null
                ? page
                : _append(current, page),
            listStatus: RequestStatus.success,
          ),
        );
      },
      failure: (error) => emit(
        state.copyWith(
          listStatus: RequestStatus.error,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> markAllRead() async {
    await _notificationsRepository.markAllRead();
  }

  Future<void> deleteNotification(num notificationId) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: NotificationMutation.delete,
      ),
    );

    final result = await _notificationsRepository.deleteNotification(
      notificationId,
    );
    await result.when(
      success: (_) async {
        await getNotifications(refresh: true);
        emit(
          state.copyWith(
            actionStatus: RequestStatus.success,
            lastMutation: NotificationMutation.delete,
          ),
        );
      },
      failure: (error) async => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> respondShowNumberRequest({
    required String status,
    required num requestId,
  }) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: NotificationMutation.respond,
      ),
    );

    final result = await _notificationsRepository.respondShowNumberRequest(
      status: status,
      requestId: requestId,
    );
    await result.when(
      success: (_) async {
        await getNotifications(refresh: true);
        emit(
          state.copyWith(
            actionStatus: RequestStatus.success,
            lastMutation: NotificationMutation.respond,
          ),
        );
      },
      failure: (error) async => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          errorMessage: error.message,
        ),
      ),
    );
  }

  void clear() => emit(const NotificationsState());

  PaginationList<NotificationModel> _append(
    PaginationList<NotificationModel> current,
    PaginationList<NotificationModel> next,
  ) {
    return PaginationList<NotificationModel>(
      data: [...?current.data, ...?next.data],
      currentPage: next.currentPage,
      firstPageUrl: next.firstPageUrl,
      from: next.from,
      lastPage: next.lastPage,
      lastPageUrl: next.lastPageUrl,
      nextPageUrl: next.nextPageUrl,
      path: next.path,
      perPage: next.perPage,
      prevPageUrl: next.prevPageUrl,
      to: next.to,
      total: next.total,
    );
  }
}
