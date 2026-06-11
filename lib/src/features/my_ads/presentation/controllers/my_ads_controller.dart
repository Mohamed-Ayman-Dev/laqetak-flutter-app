import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app_feedback.dart';
import '../../../../core/di/locator_service.dart';
import '../screens/add_ad_pay_screen.dart';

class MyAdsController {
  static Future<void> addAdOtp(Map<String, dynamic>? data) async {
    try {
      AppFeedback.loadingMessage(message: S.current.pleaseWait);
      await LocatorService.myAdsService.addAdOtp({
        'contact_phone': data?['contact_phone'],
      }, rethrowError: true);
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
}
