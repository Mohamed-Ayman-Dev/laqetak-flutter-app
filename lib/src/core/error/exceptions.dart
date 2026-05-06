import 'dart:convert';

import 'package:dio/dio.dart';

import '../network/status_code.dart';
import 'error_message.dart';

///if you want to return a special exception for Api Calls use this
class ApiException implements Exception {
  final String message; // message من API
  final String? messageKey;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.messageKey,
    this.statusCode,
    this.data,
  });

  @override
  String toString() {
    return 'ApiException: $message (statusCode: $statusCode, data: $data)';
  }

  /// Factory method to create an generic Exception
  factory ApiException.fromUnknown(Object e) {
    return ApiException(
      messageKey: ErrorMessages.unexpectedError,
      message: e.toString(),
    );
  }

  /// Factory method to create an ApiException from a DioException
  factory ApiException.fromDioException(DioException dioException) {
    final statusCode = dioException.response?.statusCode;
    final responseData = dioException.response?.data;

    // Decode the response data if it's a JSON string
    dynamic decodedData;
    if (responseData != null && responseData is String) {
      try {
        decodedData = jsonDecode(responseData);
      } catch (e) {
        // If decoding fails, use the raw response data
        decodedData = responseData;
      }
    } else {
      decodedData = responseData;
    }

    String errorMessageKey = _getErrorMessageKey(
      dioException.type,
      statusCode,
      decodedData,
    );
    final message = decodedData is Map<String, dynamic>
        ? (decodedData['message'] ?? decodedData['msg'] ?? 'Unknown Error')
        : 'Unknown Error';
    return ApiException(
      message: message,
      messageKey: errorMessageKey,
      statusCode: statusCode,
      data: decodedData,
    );
  }

  /// Private method to map DioException types and status codes to localization keys
  static String _getErrorMessageKey(
    DioExceptionType type,
    int? statusCode,
    dynamic responseData,
  ) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return ErrorMessages.connectionTimeout;
      case DioExceptionType.receiveTimeout:
        return ErrorMessages.receiveTimeout;
      case DioExceptionType.sendTimeout:
        return ErrorMessages.sendTimeout;
      case DioExceptionType.cancel:
        return ErrorMessages.requestCancelled;
      case DioExceptionType.badResponse:
        return handleHttpStatusCode(statusCode, responseData);
      case DioExceptionType.unknown:
        return ErrorMessages.unknownError;
      default:
        return ErrorMessages.unexpectedError;
    }
  }

  /// Method to handle specific HTTP status codes and provide localization keys
  static String handleHttpStatusCode(int? statusCode, dynamic responseData) {
    // Handle generic HTTP status codes
    switch (statusCode) {
      case StatusCode.badRequest:
        return ErrorMessages.badRequest;
      case StatusCode.unauthorized:
        return ErrorMessages.unauthorized;
      case StatusCode.forbidden:
        return ErrorMessages.forbidden;
      case StatusCode.notFound:
        return ErrorMessages.notFound;
      case StatusCode.conflicts:
        return ErrorMessages.conflicts;
      case StatusCode.internalServerError:
        return ErrorMessages.internalServerError;
      case StatusCode.badGateway:
        return ErrorMessages.badGateway;
      case StatusCode.serviceUnavailable:
        return ErrorMessages.serviceUnavailable;
      case StatusCode.gatewayTimeout:
        return ErrorMessages.gatewayTimeout;
      default:
        return ErrorMessages.invalidStatusCode;
    }
  }
}

// ///if you want to return a special exception for local database use this
// class LocalDatabaseException implements Exception {
//   final String message;
//   final int? statusCode;
//   final dynamic data;
//
//   const LocalDatabaseException({
//     required this.message,
//     this.statusCode,
//     this.data,
//   });
//
//   @override
//   String toString() {
//     return 'ApiException: $message (statusCode: $statusCode, data: $data)';
//   }
// }
