import 'package:invastro/src/core/network/api_service.dart';

class MyAdsService {
  Future addAd(Map<String, dynamic> data, {rethrowError = false}) async {
    return await ApiService.post(
      '/my-ads/create',
      data: data,
      hasMultipartData: true,
      rethrowError: rethrowError,
    );
  }

  Future sendAdOtp(Map<String, dynamic> data, {rethrowError = false}) async {
    return await ApiService.post(
      '/my-ads/contact-phone-otp',
      data: data,
      rethrowError: rethrowError,
    );
  }

  Future getMyAds({
    bool rethrowError = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await ApiService.get(
      '/my-ads/list',
      rethrowError: rethrowError,
      queryParameters: queryParameters,
    );
  }
}
