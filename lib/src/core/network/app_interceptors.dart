import 'package:dio/dio.dart';
// import '../error/on_error_helper.dart';

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
      // 'language': LocatorService.appSettingsCubit.langCode,
      // if (token != null) 'Authorization': 'Bearer $token',
    });

    handler.next(options);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   // Describe the processing you want to insert with this interceptor
  //   //...
  //   handler.next(response); // Proceed to the next Interceptor
  // }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // return _onErrorHelper.onError(err, handler);
    /// Let ApiClient convert DioException into ApiException.
    handler.next(err);
  }
}
