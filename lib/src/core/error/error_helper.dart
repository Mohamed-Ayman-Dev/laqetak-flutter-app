import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

import '../../../generated/l10n.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

abstract class ErrorHelper {
  static void handleApiError(dynamic e) {
    if (e is DioError) {
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
      if (error.response?.statusCode == 401) {
        if (error.requestOptions.path.contains('login') ||
            error.requestOptions.path.contains('register')) {
          EasyLoading.showError(
            S.current.usernameOrPasswordIsIncorrect,
            dismissOnTap: true,
          );
        } else {
          EasyLoading.showError(
            S.current.sessionExpiredPleaseLoginAgain,
            dismissOnTap: true,
          );

          // TODO : if the user is already in login screen and his token is expired he will be logged out and show the error message but he is already in login screen so no need to log him out again
          // AuthController.logout(sessionExpired: true);
        }
      }
      dynamic responseData = error.response?.data;
      if (responseData != null && responseData['message'] != null) {
        // Check if 'msg' is a String
        if (responseData['message'] is String) {
          if (responseData['message'].contains('حسابك محظور حاليا') ||
              responseData['message'].contains('قم بتسجيل الدخول أولا') ||
              responseData['code'].contains('002')) {
            if (NavigationHistoryObserver().top!.settings.name !=
                LoginScreen.routeName) {
              ///user token is expired but he continue to use the app as a guest
              // LocatorService.auth.user = null;
              // TODO :2 if the user is already in login screen and his token is expired he will be logged out and show the error message but he is already in login screen so no need to log him out again
              // AuthController.logout(sessionExpired: true);
            }
            return;
          } else {
            EasyLoading.showError(responseData['message'], dismissOnTap: true);
            return;
          }
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
