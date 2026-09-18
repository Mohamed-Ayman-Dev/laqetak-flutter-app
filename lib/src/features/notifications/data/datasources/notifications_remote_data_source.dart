import '../../../../core/shared/models/pagination_list.dart';
import '../models/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<PaginationList<NotificationModel>> getNotifications(int page);

  Future<void> markAllRead();

  Future<void> deleteNotification(num notificationId);

  Future<void> respondShowNumberRequest({
    required String status,
    required num requestId,
  });
}
