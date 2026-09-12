import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:invastro/src/core/constants/app_feedback.dart';
import 'package:invastro/src/core/error/error_helper.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/shared/models/ad_model.dart';

class AdsController {
  static Future<void> getAds({
    bool refresh = false,
    bool showLoadingSearch = false,
    Map<String, dynamic>? filters,
    num? typeId,
    String? search,
  }) async {
    LocatorService.ads.updateLoading('loadingAds', true);
    if (showLoadingSearch) {
      LocatorService.ads.updateLoading('loadingSearch', true);
    }
    try {
      int? currentPage = LocatorService.ads.ads?.currentPage;
      int? lastPage = LocatorService.ads.ads?.lastPage;
      int nextPage = refresh ? 1 : ((currentPage ?? 0) + 1);
      if (!refresh && currentPage != null && currentPage == lastPage) return;
      final response = await LocatorService.adsService.getAds(
        queryParameters: {
          'page': nextPage,
          'category_id': typeId,
          'search': search,
          ...?filters,
        },
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
      if (showLoadingSearch) {
        LocatorService.ads.updateLoading('loadingSearch', false);
      }
    }
  }

  static Future<void> getFavAds({bool refresh = false}) async {
    LocatorService.ads.updateLoading('loadingFavAds', true);
    try {
      int? currentPage = LocatorService.ads.myFavAds?.currentPage;
      int? lastPage = LocatorService.ads.myFavAds?.lastPage;
      int nextPage = refresh ? 1 : ((currentPage ?? 0) + 1);
      if (!refresh && currentPage != null && currentPage == lastPage) return;
      final response = await LocatorService.adsService.getFavAds(
        queryParameters: {'page': nextPage},
        rethrowError: true,
      );
      response["data"] = response["data"]
          .map<AdModel>((x) => AdModel.fromJson(x))
          .toList();
      LocatorService.ads.setFavAds(response, refresh);
    } catch (e) {
      ErrorHelper.handleApiError(e);
    } finally {
      LocatorService.ads.updateLoading('loadingFavAds', false);
    }
  }

  static Future<void> addOrRemoveAdFromFavorites({required AdModel ad}) async {
    try {
      // الحالة الجديدة المطلوبة (عكس الحالية)
      final bool newState = !(ad.isFavorite ?? false);

      // UI Update سريع (قبل ما نكلم السيرفر)
      LocatorService.ads.changeStoreState(ad.id ?? 0, isFavorite: newState);

      AppFeedback.showToast(
        "${ad.title} ${newState ? S.current.added : S.current.removed} ${newState ? S.current.toFavoritesSuccessfully : S.current.fromFavoritesSuccessfully}",
        // dismissOnTap: true,
        // duration: const Duration(seconds: 1),
        // toastPosition: EasyLoadingToastPosition.bottom,
      );

      // API Call
      await LocatorService.adsService.toggleFav(
        rethrowError: true,
        data: {'ad_id': ad.id},
      );
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }

  static Future<void> getAdDetails(num adId, {bool showLoading = false}) async {
    try {
      if (showLoading) {
        AppFeedback.loadingMessage();
      }
      LocatorService.ads.updateLoading('loadingAdDetails', true);
      final response = await LocatorService.adsService.getAdDetails(
        id: adId,
        rethrowError: true,
      );
      LocatorService.ads.setAdDetail(adId, AdModel.fromJson(response['data']));
    } catch (e) {
      ErrorHelper.handleApiError(e);
    } finally {
      if (showLoading) {
        EasyLoading.dismiss();
      }
      LocatorService.ads.updateLoading('loadingAdDetails', false);
    }
  }

  static Future<void> sendAdComplaint({
    required Map<String, dynamic> data,
  }) async {
    try {
      AppFeedback.loadingMessage();
      await LocatorService.adsService.sendAdComplaint(
        rethrowError: true,
        data: data,
      );
      EasyLoading.dismiss();
      DialogHelpers.showSuccessDialog(
        title: S.current.reportSubmittedSuccessfully,
      );
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }

  static Future<void> sendCustomerComplaint({
    required Map<String, dynamic> data,
  }) async {
    try {
      AppFeedback.loadingMessage();
      await LocatorService.adsService.sendCustomerComplaint(
        rethrowError: true,
        data: data,
      );
      EasyLoading.dismiss();
      DialogHelpers.showSuccessDialog(title: S.current.reportSentSuccessfully);
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }
}
