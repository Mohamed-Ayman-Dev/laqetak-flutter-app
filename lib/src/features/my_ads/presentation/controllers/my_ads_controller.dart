import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invastro/src/core/error/error_helper.dart';
import 'package:invastro/src/features/home/presentation/controllers/ads_controller.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app_feedback.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/redirect_model.dart';
import '../../../../core/shared/screens/payment_webview.dart';
import '../../../auth/presentation/screens/otp_screen.dart';
import '../screens/add_ad_pay_screen.dart';

class MyAdsController {
  static Future<void> addAd(Map<String, dynamic>? data) async {
    try {
      final readyData = Map<String, dynamic>.from(data ?? {});
      AppFeedback.loadingMessage(message: S.current.pleaseWait);
      // Add files as multipart array
      if (readyData['photos[]'] != null && readyData['photos[]'].isNotEmpty) {
        final files = <MultipartFile>[];
        for (final path in readyData['photos[]']) {
          if (path is MultipartFile) {
            files.add(path);
            continue;
          }
          if (path is XFile) {
            files.add(
              MultipartFile.fromFileSync(path.path, filename: path.name),
            );
            continue;
          }
        }
        if (files.isNotEmpty) {
          readyData['photos[]'] = files;
        }
      }
      final res = await LocatorService.myAdsService.addAd(
        readyData,
        rethrowError: true,
      );
      if (res['data'] != null) {
        final ad = AdModel.fromJson(res['data']);

        LocatorService.navigationService.currentState?.pushNamed(
          AddAdPayScreen.routeName,
          arguments: ad,
        );
      }
    } catch (e, s) {
      if (e is DioException) {
        final responseData = e.response?.data;
        EasyLoading.dismiss();
        LocatorService.authNavigations.setWrongVerificationCode(
          responseData['message'],
        );
        Future.delayed(const Duration(milliseconds: 100), () {
          LocatorService.authNavigations.activationFormKey.currentState
              ?.validate();
        });
      } else {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: s);
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<void> payAd(Map<String, dynamic> data) async {
    try {
      AppFeedback.loadingMessage(message: S.current.pleaseWait);
      final response = await LocatorService.myAdsService.payAd(
        data: data,
        rethrowError: true,
      );
      EasyLoading.dismiss();
      if (data['payment_method'] != 'cash') {
        final redirectUrl = response['data']['checkout_url'];
        if (redirectUrl != null) {
          final result = await LocatorService.navigationService.currentState
              ?.pushNamed(
                PaymentWebView.routeName,
                arguments: {
                  'initialUrl': redirectUrl,
                  'orderId': data['ad_id'],
                  'time': response['data']['time'],
                },
              );
          if (result == true) {
            AdsController.getAds(refresh: true);
            EasyLoading.dismiss();
            DialogHelpers.showSuccessDialog(
              title: S.current.congratulationsPaymentCompletedSuccessfully,
              subtitle: S.current.yourAdHasBeenPublishedSuccessfully,
            );
          } else if (result == false) {
            EasyLoading.showError(
              S.current.paymentFailedPleaseTryAgainLater,
              dismissOnTap: true,
            );
          } else {
            print("User cancelled payment.");
          }
        }
      } else {
        AdsController.getAds(refresh: true);
        EasyLoading.dismiss();
        DialogHelpers.showSuccessDialog(
          title: S.current.congratulationsPaymentCompletedSuccessfully,
          subtitle: S.current.yourAdHasBeenPublishedSuccessfully,
        );
      }
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }

  static Future<void> deleteAd(num id) async {
    try {
      AppFeedback.loadingMessage(message: S.current.pleaseWait);
      await LocatorService.myAdsService.deleteAd(id, rethrowError: true);
      await getMyAds(refresh: true);
      AdsController.getAds(refresh: true);
      EasyLoading.dismiss();
      DialogHelpers.showSuccessDialog(title: S.current.adDeletedSuccessfully);
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }

  static Future<void> closeAd(num id) async {
    try {
      AppFeedback.loadingMessage(message: S.current.pleaseWait);
      await LocatorService.myAdsService.closeAd(id, rethrowError: true);
      await AdsController.getAdDetails(id);
      getMyAds(refresh: true);
      AdsController.getAds(refresh: true);
      EasyLoading.dismiss();
      DialogHelpers.showSuccessDialog(title: S.current.adEndedSuccessfully);
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }

  static Future<void> sendAdOtp(
    Map<String, dynamic>? data, {
    bool edit = false,
  }) async {
    try {
      RedirectModel redirect = RedirectModel();

      AppFeedback.loadingMessage(message: S.current.pleaseWait);
      final response = await LocatorService.myAdsService.sendAdOtp({
        'contact_phone': data?['contact_phone'],
      }, rethrowError: true);
      AppFeedback.showToast(response['message']);
      if (response['data'] != null) {
        redirect = RedirectModel.fromJson(response['data']);
        redirect.phone = data?['contact_phone'];
      }
      LocatorService.navigationService.currentState?.pushNamed(
        OtpScreen.routeName,
        arguments: {
          'redirectData': redirect,
          'data': data,
          'from': edit ? OtpFlow.editAd : OtpFlow.addAd,
        },
      );
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }

  static Future<void> getMyAds({bool refresh = false}) async {
    LocatorService.myAds.updateLoading(true);
    try {
      int? currentPage = LocatorService.myAds.myAds?.currentPage;
      int? lastPage = LocatorService.myAds.myAds?.lastPage;
      int nextPage = refresh ? 1 : ((currentPage ?? 0) + 1);
      if (!refresh && currentPage != null && currentPage == lastPage) return;
      final response = await LocatorService.myAdsService.getMyAds(
        queryParameters: {'page': nextPage},
        rethrowError: true,
      );
      response["data"] = response["data"]
          .map<AdModel>((x) => AdModel.fromJson(x))
          .toList();
      LocatorService.myAds.setMyAds(response, refresh);
    } catch (e) {
      ErrorHelper.handleApiError(e);
    } finally {
      LocatorService.myAds.updateLoading(false);
    }
  }

  static Future<void> editAd(
    Map<String, dynamic>? data, {
    bool checkOtp = true,
  }) async {
    try {
      final readyData = Map<String, dynamic>.from(data ?? {});
      AppFeedback.loadingMessage(message: S.current.pleaseWait);
      // Add files as multipart array
      if (readyData['photos[]'] != null && readyData['photos[]'].isNotEmpty) {
        final files = <MultipartFile>[];
        for (final path in readyData['photos[]']) {
          if (path is MultipartFile) {
            files.add(path);
            continue;
          }
          if (path is XFile) {
            files.add(
              MultipartFile.fromFileSync(path.path, filename: path.name),
            );
            continue;
          }
        }
        if (files.isNotEmpty) {
          readyData['photos[]'] = files;
        }
      }
      await LocatorService.myAdsService.editAd(readyData, rethrowError: true);
      EasyLoading.dismiss();
      DialogHelpers.showSuccessDialog(
        title: S
            .current
            .congratulationsYourAdEditRequestHasBeenSubmittedSuccessfully,
        subtitle: S.current.yourRequestWillBeReviewedByTheAdministrationAndIf,
      );
    } catch (e, s) {
      if (checkOtp && e is DioException) {
        final responseData = e.response?.data;
        EasyLoading.dismiss();
        LocatorService.authNavigations.setWrongVerificationCode(
          responseData['message'],
        );
        Future.delayed(const Duration(milliseconds: 100), () {
          LocatorService.authNavigations.activationFormKey.currentState
              ?.validate();
        });
      } else {
        ErrorHelper.handleApiError(e);
        debugPrint(e.toString());
        debugPrintStack(stackTrace: s);
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
