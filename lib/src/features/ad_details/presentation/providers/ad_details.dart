import 'package:flutter/material.dart';

import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/customer_model.dart';
import '../../../../core/shared/models/pagination_list.dart';

class AdDetails with ChangeNotifier {
  Map<num, PaginationList<AdModel>?> myCustomerAds = {};
  Map<num, CustomerModel> myCustomerDetails = {};
  bool loadingAds = false;
  bool loadingRequestPhone = false;

  void setLoadingAds(bool value) {
    loadingAds = value;
    notifyListeners();
  }

  void setLoadingRequestPhone(bool value) {
    loadingRequestPhone = value;
    notifyListeners();
  }

  void setCustomerAds(dynamic data, bool refresh, {required num customerId}) {
    if (myCustomerAds[customerId] == null || refresh) {
      myCustomerAds[customerId] = PaginationList.fromJson(data);
    } else {
      myCustomerAds[customerId]?.addItemsToList(data);
    }
    notifyListeners();
  }

  void resetForLogout() {
    loadingAds = false;
    notifyListeners();
  }
}
