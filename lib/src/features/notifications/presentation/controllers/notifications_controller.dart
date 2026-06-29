import 'package:flutter/foundation.dart';
import 'package:invastro/src/core/constants/app_feedback.dart';
import 'package:invastro/src/core/error/error_helper.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../data/models/notification_model.dart';

class NotificationsController {
  static Future<void> getNotifications({bool refresh = false}) async {
    LocatorService.notifications.setIsLoading(true);
    try {
      int? currentPage =
          LocatorService.notifications.myNotifications?.currentPage;
      int? lastPage = LocatorService.notifications.myNotifications?.lastPage;
      int nextPage = refresh ? 1 : ((currentPage ?? 0) + 1);
      if (!refresh && currentPage != null && currentPage == lastPage) return;
      final response = await LocatorService.notificationService
          .getNotifications({'page': nextPage}, rethrowError: true);
      response["data"] = response["data"]
          .map<NotificationModel>((x) => NotificationModel.fromJson(x))
          .toList();
      LocatorService.notifications.setNotifications(response, refresh);
    } catch (e) {
      ErrorHelper.handleApiError(e);
    } finally {
      LocatorService.notifications.setIsLoading(false);
    }
  }

  static Future<void> markAllRead() async {
    try {
      await LocatorService.notificationService.markAsRead(rethrowError: false);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> deleteSingleNotification(num notificationId) async {
    try {
      AppFeedback.loadingMessage(message: S.current.deletingNotification);
      final response = await LocatorService.notificationService
          .setDeleteNotification(
            rethrowError: true,
            notificationId: notificationId,
          );
      await getNotifications(refresh: true);
      AppFeedback.showToast(S.current.notificationDeletedSuccessfully);
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }
}
