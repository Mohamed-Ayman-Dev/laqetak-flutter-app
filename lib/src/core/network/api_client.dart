import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../error/exceptions.dart';
import 'api_response.dart';
import 'app_interceptors.dart';
import 'end_points.dart';
import 'pretty_dio_logger.dart';

class ApiClient {
  final Dio dio;
  final AppInterceptors appInterceptors;

  ApiClient({required this.dio, required this.appInterceptors}) {
    dio.options
      ..baseUrl = EndPoints.baseUrl
      ..followRedirects = true
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..sendTimeout = const Duration(seconds: 30)
      ..receiveDataWhenStatusError = true;
    if (kDebugMode) {
      // Log requests and responses only during development.
      dio.interceptors.add(const PrettyDioLogger());
    }
    dio.interceptors.add(appInterceptors);
  }

  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      final response = await dio.get(
        path,
        cancelToken: cancelToken,
        options: options,
        queryParameters: queryParameters,
      );
      return ApiResponse(
        responseData: response.data,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      // Convert Dio exceptions into a unified application exception.
      throw ApiException.fromDioException(e);
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        ApiException(message: e.toString()),
        stackTrace,
      );
    }
  }

  Future<ApiResponse> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool hasMultipartData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        data: (hasMultipartData && data != null)
            // Convert request body to FormData for multipart requests.
            ? FormData.fromMap(data)
            : data,
      );
      return ApiResponse(
        responseData: response.data,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        ApiException(message: e.toString()),
        stackTrace,
      );
    }
  }
}
