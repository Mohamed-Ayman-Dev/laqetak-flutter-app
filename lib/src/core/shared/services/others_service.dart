import '../../network/api_service.dart';

class OthersService {
  Future getRegions({bool rethrowError = false}) async {
    return await ApiService.get(
      '/regions',
      useDefaultUrl: true,
      rethrowError: rethrowError,
    );
  }

  Future getCategories({bool rethrowError = false}) async {
    return await ApiService.get(
      '/categories',
      useDefaultUrl: true,
      rethrowError: rethrowError,
    );
  }

  Future getSectors({bool rethrowError = false}) async {
    return await ApiService.get(
      '/sectors',
      useDefaultUrl: true,
      rethrowError: rethrowError,
    );
  }

  Future getCities({
    bool rethrowError = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await ApiService.get(
      '/cities',
      useDefaultUrl: true,
      rethrowError: rethrowError,
      queryParameters: queryParameters,
    );
  }
}
