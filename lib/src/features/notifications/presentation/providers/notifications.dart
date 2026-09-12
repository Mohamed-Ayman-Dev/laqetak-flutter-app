import 'package:flutter/material.dart';

import '../../../../core/shared/models/pagination_list.dart';
import '../../data/models/notification_model.dart';

class Notifications with ChangeNotifier {
  PaginationList<NotificationModel>? myNotifications;
  bool isLoading = false;

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void setNotifications(dynamic data, bool refresh) {
    if (myNotifications == null || refresh) {
      myNotifications = PaginationList.fromJson(data);
    } else {
      myNotifications?.addItemsToList(data);
    }
    notifyListeners();
  }

  void clearNotificationsForLogOut() {
    myNotifications = null;
  }
}
