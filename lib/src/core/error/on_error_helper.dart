import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:invastro/src/config/app_settings/app_settings_cubit.dart';
import 'package:invastro/src/features/auth/presentation/cubit/auth_cubit.dart';

import '../dependency_injection/locator_service.dart';
import '../network/end_points.dart';
import '../network/pretty_dio_logger.dart';
import '../network/status_code.dart';
import 'no_internet_connection_page.dart';

/// Intercepts errors from Dio requests, handles token refresh and internet connection issues, and manages user session accordingly.
class OnErrorHelper {
  bool _isRefreshing = false;

  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
    AuthCubit authCubit,
    AppSettingsCubit appSettingsCubit,
  ) async {
    final Dio retryDio = Dio()
      ///Create NEW dio instance without main interceptors to avoid infinite loop (logger interceptors only)
      ..interceptors.add(const PrettyDioLogger())
      ..options.baseUrl = EndPoints.userBaseUrl
      ..options.receiveDataWhenStatusError = true
      ..options.followRedirects = false;
    final int? statusCode = err.response?.statusCode;
    final options = err.requestOptions
      ..validateStatus = (s) {
        return true;
      };
    final token = authCubit.token;

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['language'] = appSettingsCubit.langCode;

    ///  handle internet error
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      debugPrint('AppInterceptors.onError: connectionError');

      final navigator = LocatorService.navigationService.currentState;
      debugPrint(
        'AppInterceptors.onError: navigating to internet connection page',
      );
      final bool? result = await navigator?.pushNamed(
        InternetConnection.routeName,
      );

      if (result == true) {
        debugPrint(
          'AppInterceptors.onError: navigating to internet connection page successful, retrying request',
        );
        final response = await retryDio.fetch(options);
        return handler.resolve(response);
      } else {
        debugPrint(
          'AppInterceptors.onError: navigating to internet connection page failed, rejecting error',
        );
        return handler.next(err);
      }
    }

    ///  handle refresh token
    if (statusCode == StatusCode.unauthorized) {
      try {
        /// avoid infinite loop if refresh token request also fails with 401 and prevent multiple refresh calls at the same time
        if (options.path.contains(EndPoints.refreshToken) || _isRefreshing) {
          return handler.next(err);
        }
        _isRefreshing = true;

        /// try to refresh token and retry original request
        final refreshToken = authCubit.refreshToken;
        if (refreshToken == null) {
          await authCubit.resetUser(navigateToLogin: true);
          return handler.next(err);
        }
        final refreshResponse = await retryDio.post(
          EndPoints.refreshToken,
          data: {"refresh_token": refreshToken},
        );
        final newToken = refreshResponse.data['data']['token'];
        final user = refreshResponse.data['data'];
        await authCubit.setUser(user);
        options.headers['Authorization'] = "Bearer $newToken";

        final response = await retryDio.fetch(options);
        return handler.resolve(response);
      } catch (e) {
        await authCubit.resetUser(navigateToLogin: true);
        return handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    }

    return handler.next(err);
  }
}
