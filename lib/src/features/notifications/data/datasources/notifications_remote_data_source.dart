import '../../../../core/network/api_client.dart';
import '../../../../core/network/end_points.dart';
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

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  NotificationsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<PaginationList<NotificationModel>> getNotifications(int page) async {
    final response = await _apiClient.get(
      EndPoints.getNotifications,
      queryParameters: {'page': page},
    );
    final json = Map<String, dynamic>.from(response.responseData as Map);
    json['data'] = (json['data'] as List)
        .map((e) => NotificationModel.fromJson(e))
        .toList();
    return PaginationList<NotificationModel>.fromJson(json);
  }

  @override
  Future<void> markAllRead() async {
    await _apiClient.post(EndPoints.markNotificationsRead);
  }

  @override
  Future<void> deleteNotification(num notificationId) async {
    await _apiClient.get(EndPoints.deleteNotification(notificationId));
  }

  @override
  Future<void> respondShowNumberRequest({
    required String status,
    required num requestId,
  }) async {
    await _apiClient.post(
      EndPoints.respondContactRequest,
      data: {'status': status, 'contact_request_id': requestId},
    );
  }
}
