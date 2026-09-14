import 'package:dio/dio.dart';

import '../di/locator_service.dart';

class AppInterceptors extends Interceptor {
  // final OnErrorHelper _onErrorHelper;
  //
  // AppInterceptors({required OnErrorHelper onErrorHelper})
  //   : _onErrorHelper = onErrorHelper;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // final token = LocatorService.authCubit.token;
    options.headers.addAll({
      'Accept': 'application/json',
      'language': LocatorService.settingsCubit.state.language,
      if (LocatorService.authCubit.state.token != null)
        'Authorization': 'Bearer ${LocatorService.authCubit.state.token}',
    });

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Describe the processing you want to insert with this interceptor

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // return _onErrorHelper.onError(err, handler);
    /// Let ApiClient convert DioException into ApiException.
    handler.next(err);
  }
}
