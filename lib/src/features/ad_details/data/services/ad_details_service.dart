import 'package:invastro/src/core/network/api_service.dart';

class AdDetailsService {
  Future getCustomerAds({
    bool rethrowError = false,
    required num id,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await ApiService.get(
      '/advertisor/ads/$id',
      rethrowError: rethrowError,
      queryParameters: queryParameters,
    );
  }

  Future toggleHidePhone({bool rethrowError = false, num? adId}) async {
    return await ApiService.get(
      '/my-ads/toggle-contact-phone/$adId',
      rethrowError: rethrowError,
    );
  }
}
