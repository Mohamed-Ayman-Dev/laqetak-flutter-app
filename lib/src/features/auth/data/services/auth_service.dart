import 'dart:async';

import '../../../../core/network/api_service.dart';

class AuthService {
  Future login(Map<String, dynamic> data, {rethrowError = false}) async {
    return await ApiService.post(
      '/login',
      data: data,
      rethrowError: rethrowError,
    );
  }

  Future sendBeSellerRequest(
    final data, {
    bool rethrowError = false,
    Function(int, int)? onSendProgress,
  }) async {
    return await ApiService.post(
      '/be-seller',
      onSendProgress: onSendProgress,
      data: data,
      rethrowError: rethrowError,
      hasMultipartData: true,
    );
  }

  Future logout({
    String? deviceToken,
    rethrowError = false,
    Map<String, dynamic>? data,
  }) async {
    return await ApiService.post(
      '/logout',
      rethrowError: rethrowError,
      data: data,
    );
  }

  Future register(
    Map<String, dynamic> data, {
    bool rethrowError = false,
    bool hasMultipartData = false,
  }) async {
    return await ApiService.post(
      '/register',
      data: data,
      hasMultipartData: hasMultipartData,
      rethrowError: rethrowError,
    );
  }

  Future getProfile({
    bool rethrowError = false,
    bool hasMultipartData = false,
  }) async {
    return await ApiService.get('/profile/info', rethrowError: rethrowError);
  }

  Future registerActivateAccount(
    Map<String, dynamic> data, {
    rethrowError = false,
  }) async {
    return await ApiService.post(
      '/register-otp',
      data: data,
      rethrowError: rethrowError,
    );
  }

  Future registerOtpResend(
    Map<String, dynamic> data, {
    rethrowError = false,
  }) async {
    return await ApiService.post(
      '/register-otp-resend',
      data: data,
      rethrowError: rethrowError,
    );
  }

  Future forgetPassword(
    Map<String, dynamic> data, {
    rethrowError = false,
  }) async {
    return await ApiService.post(
      '/forgetpassword',
      queryParameters: data,
      rethrowError: rethrowError,
    );
  }

  Future checkForgetPasswordOTP(
    Map<String, dynamic> data, {
    rethrowError = false,
  }) async {
    return await ApiService.post(
      '/forgetpassword-otp',
      data: data,
      rethrowError: rethrowError,
    );
  }

  Future changePassword(
    Map<String, dynamic> data, {
    rethrowError = false,
  }) async {
    return await ApiService.post(
      '/forgetpassword-reset',
      data: data,
      rethrowError: rethrowError,
    );
  }

  Future changeLang(Map<String, dynamic> data, {rethrowError = false}) async {
    return await ApiService.post(
      '/profile/update-language',
      data: data,
      rethrowError: rethrowError,
    );
  }

  Future editProfile({
    rethrowError = false,
    Map<String, dynamic>? data,
    bool hasMultipartData = false,
  }) async {
    return await ApiService.post(
      '/profile/update',
      rethrowError: rethrowError,
      data: data,
      hasMultipartData: hasMultipartData,
    );
  }

  Future getSettings({bool rethrowError = false}) async {
    return await ApiService.get(
      '/settings',
      useDefaultUrl: true,
      rethrowError: rethrowError,
    );
  }

  Future sendDeviceToken({
    bool rethrowError = false,
    Map<String, dynamic>? data,
  }) async {
    return await ApiService.post(
      '/profile/device-token',
      rethrowError: rethrowError,
      data: data,
    );
  }
}
