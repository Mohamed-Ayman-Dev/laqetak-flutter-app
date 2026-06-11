import 'package:invastro/src/core/network/api_service.dart';

class MyAdsService {
  Future addAdOtp(Map<String, dynamic> data, {rethrowError = false}) async {
    return await ApiService.post(
      '/my-ads/contact-phone-otp',
      data: data,
      rethrowError: rethrowError,
    );
  }
}
