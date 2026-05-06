import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../cache/cache_manager.dart';
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
    CacheManager cacheManager,
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
    final token = cacheManager.token;

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['language'] = cacheManager.langCode;

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
        final refreshToken = cacheManager.refreshToken;
        if (refreshToken == null) {
          await _logoutFromSession(cacheManager: cacheManager);
          return handler.next(err);
        }
        final refreshResponse = await retryDio.post(
          EndPoints.refreshToken,
          data: {"refresh_token": refreshToken},
        );
        final newToken = refreshResponse.data['data']['token'];
        await cacheManager.saveToken(newToken);

        options.headers['Authorization'] = "Bearer $newToken";
        final response = await retryDio.fetch(options);
        return handler.resolve(response);
      } catch (e) {
        await _logoutFromSession(cacheManager: cacheManager);
        return handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    }

    return handler.next(err);
  }

  //   try {
  //     final isAuthenticated = false;
  //     final navigator = LocatorService.navigationService.currentState;
  //     if (statusCode == null) {
  //       debugPrint('AppInterceptors.onError: statusCode is null');
  //       final bool? result = await navigator?.pushNamed(
  //         InternetConnection.routeName,
  //       );
  //       if (result ?? false) {
  //         debugPrint(
  //           'AppInterceptors.onError: navigating to internet connection page',
  //         );
  //         return handler.resolve(await dio.fetch(options));
  //       } else {
  //         debugPrint(
  //           'AppInterceptors.onError: navigating to internet connection page failed',
  //         );
  //       }
  //       // ignore: dead_code
  //     } else if (statusCode == StatusCode.unauthorized && isAuthenticated) {
  //       //navigator?.pushNamedAndRemoveUntil(RouteNames.authPage);
  //     }
  //     if (!handler.isCompleted) {
  //       debugPrint('AppInterceptors.onError: rejecting error');
  //       return handler.reject(err);
  //     }
  //   } catch (e) {
  //     debugPrint('AppInterceptors.onError: catch block');
  //     return handler.reject(err);
  //   }
  // }

  Future<void> _logoutFromSession({required CacheManager cacheManager}) async {
    await cacheManager.clearSession();
    LocatorService.navigationService.currentState?.pushNamedAndRemoveUntil(
      LoginScreen.routeName,
      (route) => false,
    );

    ///delete all cached data in bloc providers later and remove token from firebase..etc
  }
}
