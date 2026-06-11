import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invastro/src/core/constants/app_feedback.dart';
import 'package:invastro/src/core/error/error_helper.dart';
import 'package:invastro/src/core/shared/models/redirect_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/network/api_service.dart';
import '../../../home/presentation/screens/home_layout_screen.dart';
import '../providers/auth.dart';
import '../screens/login_screen.dart';
import '../screens/otp_screen.dart';
import '../screens/reset_password_screen.dart';

abstract class AuthController {
  /// Login with phone and password
  /// Handles navigation to OTP screen or HomeLayoutScreen based on response
  static Future<void> login(Map<String, dynamic> data) async {
    try {
      EasyLoading.show(status: S.current.pleaseWait);
      final response = await LocatorService.authService.login(
        data,
        rethrowError: true,
      );
      EasyLoading.dismiss();
      // cache user data
      _saveUserData(userData: response['data']);
      // Navigate to home screen (replace all previous routes)
      LocatorService.navigationService.currentState?.pushNamedAndRemoveUntil(
        HomeLayoutScreen.routeName,
        (route) => false,
      );
      if (LocatorService.appSettings.homeIndex != 0) {
        LocatorService.appSettings.homeIndex = 0;
      }
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData['data'] != null) {
          final redirect = RedirectModel.fromJson(responseData['data']);
          AppFeedback.showToast(S.current.pleaseVerifyYourPhoneNumber);
          LocatorService.navigationService.currentState?.pushNamed(
            OtpScreen.routeName,
            arguments: {'redirectData': redirect, 'from': OtpFlow.login},
          );
        } else {
          ErrorHelper.handleApiError(e);
        }
      }
    }
  }

  /// Register a new user
  /// Handles navigation to OTP screen on success
  static Future<void> register(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    try {
      EasyLoading.show(status: S.current.pleaseWait);
      final response = await LocatorService.authService.register(
        data,
        rethrowError: true,
        hasMultipartData: true,
      );
      EasyLoading.dismiss();

      // Registration successful - navigate to OTP verification
      final redirect = RedirectModel.fromJson(response['data']);
      if (!context.mounted) return;
      LocatorService.navigationService.currentState?.pushNamed(
        OtpScreen.routeName,
        arguments: {'redirectData': redirect, 'from': OtpFlow.register},
      );
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }

  static Future<void> registerOtp(
    BuildContext context,
    Map<String, dynamic> data, {
    bool isFromLogin = false,
  }) async {
    try {
      EasyLoading.show(status: S.current.pleaseWait);
      final response = await LocatorService.authService.registerActivateAccount(
        data,
        rethrowError: true,
      );
      EasyLoading.dismiss();
      await DialogHelpers.showSuccessDialog(
        title: 'تهانينا لقد تم تسجيل حسابك بنجاح',
        onButtonTap: () {
          LocatorService.navigationService.currentState?.pop();
        },
      )?.then((value) async {
        if (response != null && response['status'] == true) {
          // OTP verified - save user data and token
          if (!context.mounted) return;
          final authProvider = Provider.of<Auth>(context, listen: false);
          final userData = response['data'];
          // Set token first
          if (userData['token'] != null) {
            authProvider.setToken(userData['token']);
          }
          // Set user data and store in preferences
          await authProvider.setUser(userData, store: true);
          // Navigate based on source
          LocatorService.navigationService.currentState
              ?.pushNamedAndRemoveUntil(
                HomeLayoutScreen.routeName,
                (route) => false,
              );
        }
      });
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        EasyLoading.dismiss();
        LocatorService.authNavigations.setWrongVerificationCode(
          responseData['message'],
        );
        Future.delayed(const Duration(milliseconds: 100), () {
          LocatorService.authNavigations.activationFormKey.currentState
              ?.validate();
        });
      }
    }
  }

  /// Resend OTP for registration
  /// Returns Map with remainingSeconds
  static Future<Map<String, dynamic>?> registerOtpResend(
    Map<String, dynamic> data,
  ) async {
    try {
      EasyLoading.show(status: S.current.pleaseWait);
      final response = await LocatorService.authService.registerOtpResend(
        data,
        rethrowError: true,
      );
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      EasyLoading.dismiss();
      ErrorHelper.handleApiError(e);
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  static void resetAccount() {
    LocatorService.auth.resetUserForLogOut();
    LocatorService.appSettings.resetAppSettingsForLogOut();
    // LocatorService.addresses.clearAddressForLogOut();
    // LocatorService.chat.clearMessagesForLogOut();
    // LocatorService.invoices.clearAllInvoices();
    // LocatorService.notifications.clearNotificationsForLogOut();
    // LocatorService.quoteRequests.clearAllOrdersForLogOut();
    // LocatorService.cars.clearMyCarsForLogOut();
    // LocatorService.complaints.clearAll();
    // LocatorService.stores.clearStoresForLogOut();
    // LocatorService.payments.resetPayments();
  }

  /// Logout user
  /// Clears local storage, resets auth state, and navigates to login
  static Future<void> logout({bool sessionExpired = false}) async {
    try {
      EasyLoading.show(status: S.current.pleaseWait);
      if (!sessionExpired) {
        final deviceToken = await getDeviceToken();
        await LocatorService.authService.logout(
          // TODO: implement device token
          data: {'device_token': deviceToken},
          rethrowError: true,
        );
      }
      // Clear local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');
      // Reset Auth provider state
      resetAccount();
      // Remove token from ApiService headers
      ApiService.removeToken();
      // Navigate to login screen
      LocatorService.navigationService.currentState?.pushNamedAndRemoveUntil(
        LoginScreen.routeName,
        (route) => false,
      );
      EasyLoading.dismiss();
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }

  /// Request password reset OTP
  /// Handles navigation to OTP screen on success
  static Future<void> forgetPassword(
    BuildContext context,
    Map<String, dynamic> data, {
    bool isRefresh = false,
  }) async {
    try {
      if (!isRefresh) {
        EasyLoading.show(status: S.current.pleaseWait);
      }
      final response = await LocatorService.authService.forgetPassword(
        data,
        rethrowError: true,
      );
      EasyLoading.dismiss();
      AppFeedback.showToast(S.current.verificationCodeHasBeenSentToYourPhone);
      if (!isRefresh && response != null && response['status'] == true) {
        // Navigate to OTP screen for password reset verification
        if (!context.mounted) return;
        LocatorService.navigationService.currentState?.pushNamed(
          OtpScreen.routeName,
          arguments: {
            'redirectData': RedirectModel(
              phone: data['phone'],
              remainingSeconds: 120,
            ),
            'from': OtpFlow.forgetPassword,
          },
        );
      }
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }

  /// Verify OTP for password reset
  /// Handles navigation to reset password screen on success
  static Future<void> forgetPasswordOtp(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    try {
      EasyLoading.show(status: S.current.pleaseWait);
      await LocatorService.authService.checkForgetPasswordOTP(
        data,
        rethrowError: true,
      );
      EasyLoading.dismiss();
      if (!context.mounted) return;
      LocatorService.navigationService.currentState?.pushNamed(
        ResetPasswordScreen.routeName,
        arguments: {'phone': data['phone'], 'code': data['code']},
      );
    } catch (e) {
      EasyLoading.dismiss();
      ErrorHelper.handleApiError(e);
    }
  }

  /// Reset password after OTP verification
  /// Handles navigation to success screen on completion
  static Future<void> forgetPasswordReset(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    try {
      EasyLoading.show(status: S.current.pleaseWait);
      await LocatorService.authService.changePassword(data, rethrowError: true);
      EasyLoading.dismiss();
      // Password reset successful - navigate to success screen
      if (!context.mounted) return;
      await DialogHelpers.showSuccessDialog(
        title: 'تم تغيير كلمة المرور بنجاح',
        buttonText: 'تسجيل الدخول',
        onButtonTap: () {
          LocatorService.navigationService.currentState?.pop();
        },
      )?.then(
        (value) => LocatorService.navigationService.currentState?.popUntil(
          (route) => route.settings.name == LoginScreen.routeName,
        ),
      );
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }

  /// Send device token to the server
  static Future<void> sendDeviceToken(dynamic token) async {
    try {
      await LocatorService.authService.sendDeviceToken(
        data: {'device_token': token},
        rethrowError: true,
      );
      if (kDebugMode) {
        print('✅ Device token sent to the server successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print("sendDeviceToken:${e.toString()}");
      }
      // ErrorHelper.handleApiError(e);
    }
  }

  /// get device token
  static Future<dynamic> getDeviceToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  /// get device token
  static Future<dynamic> changeLang(String lang) async {
    try {
      return await LocatorService.authService.changeLang({
        'language': lang,
      }, rethrowError: true);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  /// start session
  static Future<dynamic> _saveUserData({
    required Map<String, dynamic> userData,
  }) async {
    try {
      // Login successful - save user data and token
      final authProvider = LocatorService.auth;
      // Set token first
      if (userData['token'] != null) {
        authProvider.setToken(userData['token']);
      }
      // Set user data and store in preferences
      await authProvider.setUser(userData, store: true);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  /// Try to automatically login user from stored credentials
  static Future<bool> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('token') || !prefs.containsKey('user')) {
        return false;
      }
      final token = prefs.getString('token');
      final storedUserData = prefs.getString('user');

      if (token == null || storedUserData == null || token.isEmpty) {
        return false;
      }
      Map<String, dynamic> userData =
          json.decode(storedUserData) as Map<String, dynamic>;
      LocatorService.auth.setToken(token);
      LocatorService.auth.setUser(userData, notify: true, store: false);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Auto-login failed: $e');
      }
      return false;
    }
  }

  /// Get user profile data
  /// Returns user data on success
  static Future<Map<String, dynamic>?> getProfile() async {
    try {
      final response = await LocatorService.authService.getProfile(
        rethrowError: true,
      );
      _saveUserData(userData: response['data']);
      return response['data'];
    } catch (e) {
      ErrorHelper.handleApiError(e);
      return null;
    }
  }

  /// Update user profile with automatic photo conversion
  /// Handles XFile to MultipartFile conversion and loading states
  static Future<void> updateProfile(
    BuildContext context,
    Map<String, dynamic> data, {
    bool hasMultipartData = false,
  }) async {
    try {
      // Show loading
      EasyLoading.show(status: S.current.pleaseWait);

      // Convert photo from XFile to MultipartFile if needed
      if (data['photo'] != null && data['photo'] is! MultipartFile) {
        String imagePath;

        if (data['photo'] is XFile) {
          imagePath = (data['photo'] as XFile).path;
        } else if (data['photo'] is String) {
          imagePath = data['photo'];
        } else {
          throw Exception("Invalid photo format");
        }

        String imageName = imagePath.split('/').last;
        data['photo'] = await MultipartFile.fromFile(
          imagePath,
          filename: imageName,
        );
        hasMultipartData = true;
      }

      final response = await LocatorService.authService.editProfile(
        data: data,
        rethrowError: true,
        hasMultipartData: hasMultipartData,
      );
      EasyLoading.dismiss();
      if (response != null &&
          response['data']['redirect'] == "update-phone-check-otp") {
        LocatorService.navigationService.currentState?.pushNamed(
          OtpScreen.routeName,
          arguments: {
            'phone': data['phone'],
            'data': data,
            'from': 'updatePhone',
            if (response['data'] != null &&
                response['data']['remainingSeconds'] != null)
              'remainingSeconds': response['data']['remainingSeconds'],
          },
        );
      } else {
        if (response != null && response['status'] == true) {
          // Update successful - update local user data
          if (!context.mounted) return;
          final authProvider = Provider.of<Auth>(context, listen: false);
          final userData = response['data'];

          // Update user data in provider and store in preferences
          await authProvider.setUser(userData, store: true, notify: true);

          // Show success message
          EasyLoading.showSuccess(
            response['message'] ?? S.current.changesHaveBeenSavedSuccessfully,
            dismissOnTap: true,
          );
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      ErrorHelper.handleApiError(e);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> sendBecomeStoreRequest(Map<String, dynamic> data) async {
    try {
      final Map<String, dynamic> dataToSend = Map<String, dynamic>.from(data);
      Future<void> toFile(String key) async {
        if (dataToSend[key] != null &&
            dataToSend[key] is String &&
            dataToSend[key] is! MultipartFile) {
          final path = dataToSend[key] as String;
          dataToSend[key] = await MultipartFile.fromFile(
            path,
            filename: path.split('/').last,
          );
        }
      }

      await toFile('logo');
      await toFile('comm_reg');
      await toFile('terms_and_conditions');
      EasyLoading.show(status: S.current.sendingRequest);
      final response = await LocatorService.authService.sendBeSellerRequest(
        dataToSend,
        onSendProgress: (int sent, int total) {
          double progress = sent / total;
          if (dataToSend['logo'] != null ||
              dataToSend['comm_reg'] != null ||
              dataToSend['terms_and_conditions'] != null) {
            if ((progress * 100) != 100) {
              EasyLoading.showProgress(
                progress,
                status:
                    '${(progress * 100).toStringAsFixed(0)}% ${S.current.sendingRequest}',
              );
            } else if ((progress * 100) == 100) {
              EasyLoading.dismiss();
              EasyLoading.show(status: S.current.sendingRequest);
            }
          }
        },
        rethrowError: true,
      );
      print(response);
      EasyLoading.dismiss();
      // LocatorService.navigationService.currentState?.pushNamed(
      //   RegisterStoreSuccessScreen.routeName,
      //   arguments: {'ref_number': response['data']['ref_number']},
      // );
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }
}
