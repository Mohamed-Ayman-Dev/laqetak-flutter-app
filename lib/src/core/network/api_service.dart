import 'package:dio/dio.dart';

import 'api_response.dart';

abstract class ApiService {
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  });

  Future<ApiResponse> post(
    String path, {
    Map<String, dynamic>? data,
    Options? options,
    Map<String, dynamic>? queryParameters,
    bool hasMultipartData = false,
    CancelToken? cancelToken,
  });

  Future<ApiResponse> put(
    String path, {
    Map<String, dynamic>? data,
    Options? options,
    Map<String, dynamic>? queryParameters,
    bool hasMultipartData = false,
  });

  Future<ApiResponse> patch(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });

  Future<ApiResponse> delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response<dynamic>> getHead(String path);
}
