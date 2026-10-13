import 'package:laqetak/src/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:laqetak/src/features/notifications/data/models/notification_model.dart';
import 'package:laqetak/src/features/notifications/data/repositories/notifications_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/shared/models/pagination_list.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl({
    required NotificationsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final NotificationsRemoteDataSource _remoteDataSource;

  @override
  Future<ApiResult<PaginationList<NotificationModel>>> getNotifications(
    int page,
  ) async {
    try {
      final notifications = await _remoteDataSource.getNotifications(page);
      return ApiResult.success(notifications);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> markAllRead() async {
    try {
      await _remoteDataSource.markAllRead();
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> deleteNotification(num notificationId) async {
    try {
      await _remoteDataSource.deleteNotification(notificationId);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> respondShowNumberRequest({
    required String status,
    required num requestId,
  }) async {
    try {
      await _remoteDataSource.respondShowNumberRequest(
        status: status,
        requestId: requestId,
      );
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }
}
