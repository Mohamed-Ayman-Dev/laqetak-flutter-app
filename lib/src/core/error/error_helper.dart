import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

import '../../../generated/l10n.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

abstract class ErrorHelper {
  static void handleApiError(dynamic e) {
    if (e is DioException) {
      handleDioError(e);
    } else if (e is HttpException) {
      EasyLoading.showError(e.message, dismissOnTap: true);
    } else {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static String mapFieldsErrorResponse(Map data) {
    String error = '';
    data.forEach((key, value) {
      value = value is List ? value.join(', ') : value;
      error += '$value\n';
    });
    return error;
  }

  static void handleDioError(DioException error) {
    if (error.type == DioExceptionType.badResponse) {
      dynamic responseData = error.response?.data;
      if (error.response?.statusCode == 401 &&
          responseData['code'].contains('001')) {
        EasyLoading.showError(
          S.current.sessionExpiredPleaseLoginAgain,
          dismissOnTap: true,
        );
        if (NavigationHistoryObserver().top!.settings.name !=
            LoginScreen.routeName) {
          AuthController.logout(sessionExpired: true);
        }
      }
      if (responseData != null && responseData['message'] != null) {
        // Check if 'msg' is a String
        if (responseData['message'] is String) {
          EasyLoading.showError(responseData['message'], dismissOnTap: true);
          return;
        }
        // Check if 'msg' is a List and not empty
        else if (responseData['message'] is List &&
            responseData['message'].isNotEmpty) {
          EasyLoading.showError(
            responseData['message'].first,
            dismissOnTap: true,
          );
          return;
        }
      }
      // If 'msg' key is not found or empty, show the default error message
      EasyLoading.showError(
        responseData is Map
            ? mapFieldsErrorResponse(responseData)
            : (responseData['message'] ?? error.message),
        dismissOnTap: true,
      );
    } else {
      EasyLoading.showError(
        error.message!.contains('The connection errored')
            ? S.current.connectionErrorPleaseCheckYourInternetConnection
            : error.message.toString(),
        dismissOnTap: true,
      );
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
