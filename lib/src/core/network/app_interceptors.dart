import 'package:dio/dio.dart';

import '../di/locator_service.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
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
    LocatorService.networkCubit.markConnected();
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      LocatorService.networkCubit.markDisconnected();
    }
    handler.next(err);
  }
}
