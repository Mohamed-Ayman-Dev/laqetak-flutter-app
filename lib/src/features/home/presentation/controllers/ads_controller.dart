import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:invastro/src/core/constants/app_feedback.dart';
import 'package:invastro/src/core/error/error_helper.dart';
import 'package:invastro/src/core/shared/models/ad_model.dart';

import '../../../../core/di/locator_service.dart';
import '../../../../core/helpers/dialog_helpers.dart';

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

  static Future<void> getAdDetails(num adId) async {
    try {
      LocatorService.ads.updateLoading('loadingAdDetails', true);
      final response = await LocatorService.adsService.getAdDetails(
        id: adId,
        rethrowError: true,
      );
      LocatorService.ads.setAdDetail(adId, AdModel.fromJson(response['data']));
    } catch (e) {
      ErrorHelper.handleApiError(e);
    } finally {
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
      DialogHelpers.showSuccessDialog(title: 'تم ارسال الابلاغ بنجاح');
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
      DialogHelpers.showSuccessDialog(title: 'تم ارسال الابلاغ بنجاح');
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }
}
