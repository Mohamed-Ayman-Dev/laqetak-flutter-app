import 'package:invastro/src/core/error/error_helper.dart';
import 'package:invastro/src/core/shared/models/ad_model.dart';

import '../../../../core/di/locator_service.dart';

class AdsController {
  static Future<void> getAds({bool refresh = false}) async {
    LocatorService.ads.updateLoading('loadingAds', true);

    try {
      int? currentPage = LocatorService.ads.myAds?.currentPage;
      int? lastPage = LocatorService.ads.myAds?.lastPage;
      int nextPage = refresh ? 1 : ((currentPage ?? 0) + 1);
      if (!refresh && currentPage != null && currentPage == lastPage) return;
      final response = await LocatorService.adsService.getAds(
        queryParameters: {'page': nextPage},
        rethrowError: true,
      );
      response["data"] = response["data"]
          .map<AdModel>((x) => AdModel.fromJson(x))
          .toList();
      LocatorService.ads.setAds(response, refresh);
    } catch (e) {
      ErrorHelper.handleApiError(e);
    } finally {
      LocatorService.ads.updateLoading('loadingAds', false);
    }
  }
}
