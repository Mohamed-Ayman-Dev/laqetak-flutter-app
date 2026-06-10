import '../../../../core/network/api_service.dart';

class AdsService {
  Future getAds({
    bool rethrowError = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await ApiService.get(
      '/ads/list',
      rethrowError: rethrowError,
      queryParameters: queryParameters,
    );
  }

  Future getFavAds({
    bool rethrowError = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await ApiService.get(
      '/favorites/list',
      rethrowError: rethrowError,
      queryParameters: queryParameters,
    );
  }

  Future toggleFav({
    bool rethrowError = false,
    required Map<String, dynamic> data,
  }) async {
    return await ApiService.post(
      '/favorites/toggle',
      rethrowError: rethrowError,
      data: data,
    );
  }

  Future getAdDetails({bool rethrowError = false, required num id}) async {
    return await ApiService.get('/ads/detail/$id', rethrowError: rethrowError);
  }

  Future sendAdComplaint({
    bool rethrowError = false,
    Map<String, dynamic>? data,
  }) async {
    return await ApiService.post(
      '/ads/complaint',
      rethrowError: rethrowError,
      data: data,
    );
  }

  Future sendCustomerComplaint({
    bool rethrowError = false,
    Map<String, dynamic>? data,
  }) async {
    return await ApiService.post(
      '/advertisor/complaint',
      rethrowError: rethrowError,
      data: data,
    );
  }
}
