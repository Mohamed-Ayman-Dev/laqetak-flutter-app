import 'package:flutter/material.dart';

import '../../../../core/shared/data/models/ad_model.dart';
import '../../../../core/shared/data/models/pagination_list.dart';

class MyAds with ChangeNotifier {
  PaginationList<AdModel>? myAds;
  bool loadingMyAds = false;

  void setMyAds(dynamic data, bool refresh) {
    if (myAds == null || refresh) {
      myAds = PaginationList.fromJson(data);
    } else {
      myAds?.addItemsToList(data);
    }
    notifyListeners();
  }

  void updateLoading(bool value) {
    loadingMyAds = value;
    notifyListeners();
  }

  void resetForLogout() {
    myAds = null;
    loadingMyAds = false;
  }
}
