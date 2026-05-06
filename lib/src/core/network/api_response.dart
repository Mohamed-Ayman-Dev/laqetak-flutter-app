import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:invastro/src/core/network/status_code.dart';

import '../constants/string_manager.dart';
import '../error/exceptions.dart';

class ApiResponse {
  final dynamic responseData;
  final int? statusCode;

  ApiResponse({required this.responseData, required this.statusCode});

  bool get ok =>
      (statusCode == StatusCode.ok || statusCode == StatusCode.created);

  dynamic get data =>
      responseData ??
      {'message': StringManager.somethingWentWrong, 'result': false};

  String get errorMessage => data['message'] ?? data['msg'];

  T dataOrThrow<T>(T Function(dynamic data) parse) {
    // if (!ok) {
    //   throw ApiException(
    //     message: errorMessage,
    //     statusCode: statusCode,
    //     data: responseData,
    //   );
    // }
    try {
      return parse(data);
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(
        e,
        stackTrace,
        reason: 'Response parsing failed',
        fatal: false,
      );
      throw ApiException(
        message:
            "${StringManager.somethingWentWrong} - Parsing Error: ${e.toString()}",
        data: responseData,
      );
    }
  }

  @override
  String toString() {
    return 'ApiResponse(responseData: $responseData, statusCode: $statusCode)';
  }
}
