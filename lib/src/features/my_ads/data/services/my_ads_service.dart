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

  Future editAd(Map<String, dynamic> data, {rethrowError = false}) async {
    return await ApiService.post(
      '/my-ads/update',
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

  Future deleteAd(num id, {rethrowError = false}) async {
    return await ApiService.get(
      '/my-ads/delete/$id',
      rethrowError: rethrowError,
    );
  }

  Future closeAd(num id, {rethrowError = false}) async {
    return await ApiService.get(
      '/my-ads/close-ad/$id',
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
