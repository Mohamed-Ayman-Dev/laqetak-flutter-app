import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app_feedback.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/error/error_helper.dart';
import '../../../../core/shared/models/ad_model.dart';

class AdDetailsController {
  static Future<void> toggleHidePhone({required AdModel ad}) async {
    try {
      // الحالة الجديدة المطلوبة (عكس الحالية)
      final num newState = ad.hidePhone == 1 ? 0 : 1;

      // UI Update سريع (قبل ما نكلم السيرفر)
      LocatorService.ads.changeHidePhoneState(ad.id ?? 0, hide: newState);

      AppFeedback.showToast(
        "${newState == 1 ? S.current.activated : S.current.deactivated} ${S.current.phoneNumberHiddenSuccessfully} ",
      );

      // API Call
      await LocatorService.adDetailsService.toggleHidePhone(
        rethrowError: true,
        adId: ad.id,
      );
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }

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
