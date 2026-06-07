import 'package:flutter/material.dart';
import 'package:invastro/src/core/shared/models/ad_model.dart';
import 'package:invastro/src/features/home/data/models/loading_variables_models/ads_loading_model.dart';

import '../../../../core/shared/models/pagination_list.dart';

class Ads with ChangeNotifier {
  AdsLoadingModel adsLoadingModel = AdsLoadingModel();
  PaginationList<AdModel>? myAds;
  Map<num, AdModel> myAdDetails = {};

  void updateLoading(String key, dynamic value) {
    adsLoadingModel.updateValue(key, value);
    notifyListeners();
  }

  void setAdDetail(num adId, AdModel ad) {
    if (myAdDetails[adId] == ad) {
      return;
    }
    if (myAdDetails.containsKey(adId)) {
      myAdDetails.update(adId, (_) => ad);
    } else {
      myAdDetails[adId] = ad;
    }
    notifyListeners();
  }

  void setAds(dynamic data, bool refresh) {
    if (myAds == null || refresh) {
      myAds = PaginationList.fromJson(data);
    } else {
      myAds?.addItemsToList(data);
    }
    notifyListeners();
  }
}
