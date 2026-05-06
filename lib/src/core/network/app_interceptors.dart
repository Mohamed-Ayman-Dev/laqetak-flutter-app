import 'package:dio/dio.dart';

import '../cache/cache_manager.dart';
import '../error/on_error_helper.dart';

class AppInterceptors extends Interceptor {
  final OnErrorHelper _onErrorHelper;
  final CacheManager _cacheManager;

  AppInterceptors({
    required OnErrorHelper onErrorHelper,

    required CacheManager cacheManager,
  }) : _onErrorHelper = onErrorHelper,
       _cacheManager = cacheManager;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _cacheManager.token;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['language'] = _cacheManager.langCode;
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
    return _onErrorHelper.onError(err, handler, _cacheManager);
  }
}
