import 'package:dio/dio.dart';
import 'package:invastro/src/core/dependency_injection/locator_service.dart';

import '../cache/cache_manager.dart';
import '../error/on_error_helper.dart';

class AppInterceptors extends Interceptor {
  final OnErrorHelper _onErrorHelper;

  AppInterceptors({required OnErrorHelper onErrorHelper})
    : _onErrorHelper = onErrorHelper;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = LocatorService.authCubit.token;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['language'] = LocatorService.appSettingsCubit.langCode;
    handler.next(options);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   // Describe the processing you want to insert with this interceptor
  //   //...
  //   handler.next(response); // Proceed to the next Interceptor
  // }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return _onErrorHelper.onError(err, handler);
  }
}
