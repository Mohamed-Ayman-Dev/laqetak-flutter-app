import '../../../../core/network/api_result.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../models/notification_model.dart';

abstract class NotificationsRepository {
  Future<ApiResult<PaginationList<NotificationModel>>> getNotifications(
    int page,
  );

  Future<ApiResult<void>> markAllRead();

  Future<ApiResult<void>> deleteNotification(num notificationId);

  Future<ApiResult<void>> respondShowNumberRequest({
    required String status,
    required num requestId,
  });
}
