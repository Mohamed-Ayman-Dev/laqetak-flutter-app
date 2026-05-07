import 'package:dio/dio.dart';
import 'package:invastro/src/config/app_settings/app_settings_cubit.dart';
import 'package:invastro/src/features/auth/presentation/cubit/auth_cubit.dart';

import '../cache/cache_manager.dart';
import '../error/on_error_helper.dart';

class AppInterceptors extends Interceptor {
  final OnErrorHelper _onErrorHelper;
  final AuthCubit _authCubit;
  final AppSettingsCubit _appSettingsCubit;

  AppInterceptors({
    required OnErrorHelper onErrorHelper,
    required CacheManager cacheManager,
    required AuthCubit authCubit,
    required AppSettingsCubit appSettingsCubit,
  }) : _authCubit = authCubit,
       _appSettingsCubit = appSettingsCubit,
       _onErrorHelper = onErrorHelper;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _authCubit.token;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['language'] = _appSettingsCubit.langCode;
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
    return _onErrorHelper.onError(err, handler, _authCubit, _appSettingsCubit);
  }
}
