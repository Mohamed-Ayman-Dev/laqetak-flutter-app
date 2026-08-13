import 'dart:convert';

import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({required this.message, this.statusCode, this.data});

  /// Network-related errors (e.g. no internet or timeout) have no HTTP status
  /// code, so cached data can be used as a fallback.
  bool get shouldFallbackToCache => statusCode == null;

  /// Creates an [ApiException] from a [DioException].
  factory ApiException.fromDioException(DioException exception) {
    final statusCode = exception.response?.statusCode;
    final responseData = _decode(exception.response?.data);

    return ApiException(
      message: _extractMessage(exception, responseData),
      statusCode: statusCode,
      data: responseData,
    );
  }

  /// Decode string responses into JSON when possible.
  static dynamic _decode(dynamic data) {
    if (data is String) {
      try {
        return jsonDecode(data);
      } catch (_) {
        return data;
      }
    }
    return data;
  }

  /// Prefer the backend error message, otherwise return
  /// a user-friendly message based on the Dio error type.
  static String _extractMessage(DioException exception, dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final backendMessage =
          responseData['message'] ??
          responseData['msg'] ??
          responseData['error']?['message'];

      if (backendMessage is String && backendMessage.isNotEmpty) {
        return backendMessage;
      }
    }

    switch (exception.type) {
      case DioExceptionType.connectionError:
        return 'No internet connection.';

      case DioExceptionType.connectionTimeout:
        return 'Connection timeout.';

      case DioExceptionType.receiveTimeout:
        return 'Receive timeout.';

      case DioExceptionType.sendTimeout:
        return 'Send timeout.';

      case DioExceptionType.cancel:
        return 'Request cancelled.';

      case DioExceptionType.badResponse:
        return exception.message ?? 'Request failed.';
      default:
        return 'Something went wrong.';
    }
  }

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message)';
}
