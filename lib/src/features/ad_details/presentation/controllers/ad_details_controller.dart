import '../../../../core/di/locator_service.dart';
import '../../../../core/error/error_helper.dart';
import '../../../../core/shared/models/ad_model.dart';

class AdDetailsController {
  static Future<void> getCustomerAds({
    required num id,
    bool refresh = false,
  }) async {
    LocatorService.adDetails.setLoadingAds(true);

    try {
      int? currentPage =
          LocatorService.adDetails.myCustomerAds[id]?.currentPage;
      int? lastPage = LocatorService.adDetails.myCustomerAds[id]?.lastPage;
      int nextPage = refresh ? 1 : ((currentPage ?? 0) + 1);
      if (!refresh && currentPage != null && currentPage == lastPage) return;
      final response = await LocatorService.adDetailsService.getCustomerAds(
        queryParameters: {'page': nextPage},
        id: id,
        rethrowError: true,
      );
      response["data"] = response["data"]
          .map<AdModel>((x) => AdModel.fromJson(x))
          .toList();
      LocatorService.adDetails.setCustomerAds(
        response,
        refresh,
        customerId: id,
      );
    } catch (e) {
      ErrorHelper.handleApiError(e);
    } finally {
      LocatorService.adDetails.setLoadingAds(false);
    }
  }
}
