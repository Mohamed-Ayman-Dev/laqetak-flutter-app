import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../error/exceptions.dart';
import 'api_response.dart';
import 'api_service.dart';
import 'app_interceptors.dart';
import 'end_points.dart';
import 'pretty_dio_logger.dart';

class ApiServiceImpl implements ApiService {
  final Dio dio;
  final AppInterceptors appInterceptors;

  ApiServiceImpl({required this.dio, required this.appInterceptors}) {
    dio.options
      ..baseUrl = EndPoints.userBaseUrl
      ..followRedirects = true
      ..connectTimeout = Duration(seconds: 30)
      ..headers = {'Accept': 'application/json'}
      ..receiveTimeout = Duration(seconds: 30)
      ..sendTimeout = Duration(seconds: 30)
      ..receiveDataWhenStatusError = true;
    // ..validateStatus = (status) {
    //   if (status == StatusCode.unauthorized) return false;
    //   return status! < StatusCode.internalServerError;
    // };

    if (kDebugMode) {
      dio.interceptors.add(const PrettyDioLogger());
    }
    dio.interceptors.add(appInterceptors);
  }

  @override
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
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  @override
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
            ? FormData.fromMap(data)
            : data,
      );
      return ApiResponse(
        responseData: response.data,
        statusCode: response.statusCode,
      );
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  @override
  Future<ApiResponse> put(
    String path, {
    Map<String, dynamic>? data,
    bool hasMultipartData = false,
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.put(
        path,
        queryParameters: queryParameters,
        options: options,
        data: (hasMultipartData && data != null)
            ? FormData.fromMap(data)
            : data,
      );
      return ApiResponse(
        responseData: response.data,
        statusCode: response.statusCode,
      );
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  @override
  Future<ApiResponse> patch(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.patch(
        path,
        queryParameters: queryParameters,
        data: data,
      );
      return ApiResponse(
        responseData: response.data,
        statusCode: response.statusCode,
      );
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  @override
  Future<ApiResponse> delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        queryParameters: queryParameters,
        data: data,
      );
      return ApiResponse(
        responseData: response.data,
        statusCode: response.statusCode,
      );
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  @override
  Future<Response<dynamic>> getHead(String path) async {
    try {
      final response = await dio.head(path);
      return response;
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  // ApiResponse _handleResponseAsJson(Response<dynamic> response) {
  //   try {
  //     final data = response.data.toString();
  //     final responseJson = jsonDecode(data);
  //     return ApiResponse(
  //       responseData: responseJson,
  //       statusCode: response.statusCode,
  //     );
  //   } on FormatException catch (error) {
  //     return ApiResponse(
  //       responseData: {'error': error.message},
  //       statusCode: response.statusCode,
  //     );
  //   }
  // }
}
