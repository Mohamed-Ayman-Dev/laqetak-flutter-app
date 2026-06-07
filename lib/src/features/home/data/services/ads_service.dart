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

  Future getAdDetails({bool rethrowError = false, required num id}) async {
    return await ApiService.get('/ads/detail/$id', rethrowError: rethrowError);
  }
}
