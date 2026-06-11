import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:invastro/src/core/error/error_helper.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app_feedback.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/shared/models/redirect_model.dart';
import '../../../auth/presentation/screens/otp_screen.dart';
import '../screens/add_ad_pay_screen.dart';

class MyAdsController {
  static Future<void> addAd(Map<String, dynamic>? data) async {
    try {
      AppFeedback.loadingMessage(message: S.current.pleaseWait);
      await LocatorService.myAdsService.addAd({...?data}, rethrowError: true);
      AppFeedback.showToast(S.current.numberHasBeenVerifiedSuccessfully);
      LocatorService.navigationService.currentState?.pushNamed(
        AddAdPayScreen.routeName,
        arguments: data,
      );
    } catch (e) {
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
      }
    }
  }

  static Future<void> sendAdOtp(Map<String, dynamic>? data) async {
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
          'from': OtpFlow.addAd,
        },
      );
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }
}
