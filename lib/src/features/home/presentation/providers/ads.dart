import 'package:flutter/material.dart';
import 'package:invastro/src/core/shared/models/ad_model.dart';
import 'package:invastro/src/features/home/data/models/loading_variables_models/ads_loading_model.dart';

import '../../../../core/shared/models/pagination_list.dart';

class Ads with ChangeNotifier {
  AdsLoadingModel adsLoadingModel = AdsLoadingModel();
  PaginationList<AdModel>? myAds;
  PaginationList<AdModel>? myFavAds;

  Map<num, AdModel> myAdDetails = {};
  Map<String, dynamic> filters = {};

  void updateLoading(String key, dynamic value) {
    adsLoadingModel.updateValue(key, value);
    notifyListeners();
  }

  void changeStoreState(num id, {bool? isFavorite}) {
    final list = myAds?.data;
    if (list != null) {
      // نجيب الـ index
      final index = list.indexWhere((element) => element.id == id);
      if (index != -1) {
        final ad = list[index];
        final current = ad.isFavorite ?? false;
        // لو isFavorite null يبقى بنعمل toggle
        ad.isFavorite = isFavorite ?? !current;
      }
    }
    if (isFavorite != null && isFavorite == false) {
      final favList = myFavAds?.data;

      if (favList != null && favList.isNotEmpty) {
        final index = favList.indexWhere((e) => e.id == id);
        if (index != -1) {
          favList.removeAt(index);
        }
      }
    }
    // change in details same way 👇
    if (myAdDetails[id] != null) {
      final detailsAd = myAdDetails[id]!;
      final currentDetailsFav = detailsAd.isFavorite ?? false;
      detailsAd.isFavorite = isFavorite ?? !currentDetailsFav;
    }

    notifyListeners();
  }

  void setFilters(Map<String, dynamic> data) {
    filters = data;
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

  void setFavAds(dynamic data, bool refresh) {
    if (myFavAds == null || refresh) {
      myFavAds = PaginationList.fromJson(data);
    } else {
      myFavAds?.addItemsToList(data);
    }
    notifyListeners();
  }
}
