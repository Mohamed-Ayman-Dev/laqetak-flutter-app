import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invastro/src/core/bloc_helpers/base_cubit.dart';
import 'package:invastro/src/core/error/exceptions.dart';
import 'package:invastro/src/core/network/api_service.dart';
import 'package:invastro/src/features/auth/data/models/user_model.dart';
import 'package:invastro/src/features/auth/data/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/shared/models/redirect_model.dart';
import 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit(this._authRepository, this._prefs) : super(const AuthState());

  final AuthRepository _authRepository;
  final SharedPreferences _prefs;
  final GlobalKey<FormState> activationFormKey = GlobalKey<FormState>();

  Future<void> login(
    Map<String, dynamic> data, {
    bool isRefresh = false,
  }) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: AuthMutation.login,
        otpResent: isRefresh,
        clearOtp: true,
      ),
    );
    final result = await _authRepository.login(data);
    await result.when(
      success: (userData) async {
        if (isRefresh) {
          emit(
            state.copyWith(
              actionStatus: RequestStatus.success,
              lastMutation: AuthMutation.login,
              otpResent: true,
            ),
          );
          return;
        }
        await _persistUser(userData);
      },
      failure: (error) async {
        final redirect = _loginOtpRedirect(error);
        if (redirect != null) {
          emit(
            state.copyWith(
              actionStatus: RequestStatus.success,
              lastMutation: AuthMutation.login,
              otpRedirect: redirect,
              otpFormData: data,
              otpResent: isRefresh,
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            actionStatus: RequestStatus.error,
            lastMutation: AuthMutation.login,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  Future<void> register(
    Map<String, dynamic> data, {
    bool isRefresh = false,
  }) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: AuthMutation.register,
        otpResent: isRefresh,
        clearOtp: true,
      ),
    );
    final result = await _authRepository.register(data);
    result.when(
      success: (redirect) => emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          lastMutation: AuthMutation.register,
          otpRedirect: redirect,
          otpFormData: data,
          otpResent: isRefresh,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          lastMutation: AuthMutation.register,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> registerOtp(Map<String, dynamic> data) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: AuthMutation.registerOtp,
        otpVerified: false,
        clearVerification: true,
      ),
    );
    final result = await _authRepository.registerOtp(data);
    await result.when(
      success: (response) async {
        final verified = response['status'] == true;
        if (verified && response['data'] is Map) {
          await _persistUser(
            Map<String, dynamic>.from(response['data'] as Map),
            emitSuccess: false,
          );
        }
        emit(
          state.copyWith(
            actionStatus: RequestStatus.success,
            lastMutation: AuthMutation.registerOtp,
            otpVerified: verified,
          ),
        );
      },
      failure: (error) async {
        emit(
          state.copyWith(
            actionStatus: RequestStatus.error,
            lastMutation: AuthMutation.registerOtp,
            verificationErrorMessage: error.message,
            isNotValid: true,
          ),
        );
      },
    );
  }

  Future<void> registerOtpResend(Map<String, dynamic> data) async {
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: AuthMutation.registerOtpResend,
        otpResent: true,
      ),
    );
    final result = await _authRepository.registerOtpResend(data);
    result.when(
      success: (_) => emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          lastMutation: AuthMutation.registerOtpResend,
          otpResent: true,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          lastMutation: AuthMutation.registerOtpResend,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> sendPhoneOtp(
    Map<String, dynamic>? data, {
    bool isRefresh = false,
  }) async {
    final phone = data?['phone']?.toString();
    if (phone == null || phone.isEmpty) return;
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: AuthMutation.sendPhoneOtp,
        otpResent: isRefresh,
        clearOtp: true,
      ),
    );
    final result = await _authRepository.sendPhoneOtp(phone);
    result.when(
      success: (otp) {
        if (otp.redirect == null) {
          emit(
            state.copyWith(
              actionStatus: RequestStatus.error,
              lastMutation: AuthMutation.sendPhoneOtp,
              errorMessage: otp.message,
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            actionStatus: RequestStatus.success,
            lastMutation: AuthMutation.sendPhoneOtp,
            otpRedirect: otp.redirect!.copyWith(phone: phone),
            otpFormData: data,
            successMessage: otp.message,
            otpResent: isRefresh,
          ),
        );
      },
      failure: (error) => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          lastMutation: AuthMutation.sendPhoneOtp,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> logout({bool sessionExpired = false}) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: AuthMutation.logout,
      ),
    );
    if (!sessionExpired) {
      final deviceToken = await getDeviceToken();
      final result = await _authRepository.logout(deviceToken: deviceToken);
      if (result.isFailure) {
        emit(
          state.copyWith(
            actionStatus: RequestStatus.error,
            lastMutation: AuthMutation.logout,
            errorMessage: result.errorOrNull?.message,
          ),
        );
        return;
      }
    }
    await _clearLocalSession();
    emit(
      const AuthState(
        actionStatus: RequestStatus.success,
        lastMutation: AuthMutation.logout,
      ),
    );
  }

  Future<void> deleteAccount() async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: AuthMutation.deleteAccount,
      ),
    );
    final result = await _authRepository.deleteAccount();
    if (result.isFailure) {
      emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          lastMutation: AuthMutation.deleteAccount,
          errorMessage: result.errorOrNull?.message,
        ),
      );
      return;
    }
    await _clearLocalSession();
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (_) {}
    emit(
      const AuthState(
        actionStatus: RequestStatus.success,
        lastMutation: AuthMutation.deleteAccount,
      ),
    );
  }

  Future<void> forgetPassword(
    Map<String, dynamic> data, {
    bool isRefresh = false,
  }) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: AuthMutation.forgetPassword,
        otpResent: isRefresh,
        clearOtp: true,
      ),
    );
    final result = await _authRepository.forgetPassword(data);
    result.when(
      success: (ok) => emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          lastMutation: AuthMutation.forgetPassword,
          otpRedirect: RedirectModel(
            phone: data['phone'],
            remainingSeconds: 120,
          ),
          otpFormData: data,
          otpResent: isRefresh,
          otpVerified: ok,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          lastMutation: AuthMutation.forgetPassword,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> forgetPasswordOtp(Map<String, dynamic> data) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: AuthMutation.forgetPasswordOtp,
        clearVerification: true,
      ),
    );
    final result = await _authRepository.forgetPasswordOtp(data);
    result.when(
      success: (_) => emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          lastMutation: AuthMutation.forgetPasswordOtp,
          otpFormData: data,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          lastMutation: AuthMutation.forgetPasswordOtp,
          verificationErrorMessage: error.message,
          isNotValid: true,
        ),
      ),
    );
  }

  Future<void> resetPassword(Map<String, dynamic> data) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: AuthMutation.resetPassword,
      ),
    );
    final result = await _authRepository.resetPassword(data);
    result.when(
      success: (_) => emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          lastMutation: AuthMutation.resetPassword,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          lastMutation: AuthMutation.resetPassword,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> getProfile() async {
    final result = await _authRepository.getProfile();
    if (result.isFailure) {
      emit(state.copyWith(errorMessage: result.errorOrNull?.message));
      return;
    }
    await _persistUser(result.dataOrNull ?? {}, emitSuccess: false);
  }

  Future<void> updateProfile(
    Map<String, dynamic> data, {
    bool hasMultipartData = false,
  }) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: AuthMutation.updateProfile,
        clearSuccessMessage: true,
      ),
    );
    final prepared = Map<String, dynamic>.from(data);
    var multipart = hasMultipartData;
    if (prepared['avatar'] != null && prepared['avatar'] is! MultipartFile) {
      String imagePath;
      if (prepared['avatar'] is XFile) {
        imagePath = (prepared['avatar'] as XFile).path;
      } else if (prepared['avatar'] is String) {
        imagePath = prepared['avatar'] as String;
      } else {
        emit(
          state.copyWith(
            actionStatus: RequestStatus.error,
            lastMutation: AuthMutation.updateProfile,
            errorMessage: 'Invalid photo format',
          ),
        );
        return;
      }
      prepared['avatar'] = await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
      );
      multipart = true;
    }
    final result = await _authRepository.updateProfile(
      data: prepared,
      hasMultipartData: multipart,
    );
    await result.when(
      success: (message) async {
        await getProfile();
        emit(
          state.copyWith(
            actionStatus: RequestStatus.success,
            lastMutation: AuthMutation.updateProfile,
            successMessage: message,
            clearImagePath: true,
          ),
        );
      },
      failure: (error) async {
        emit(
          state.copyWith(
            actionStatus: RequestStatus.error,
            lastMutation: AuthMutation.updateProfile,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  Future<void> sendDeviceToken(dynamic token) async {
    if (token == null) return;
    await _authRepository.sendDeviceToken(token.toString());
  }

  Future<String?> getDeviceToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      return null;
    }
  }

  Future<void> changeLang(String lang) async {
    await _authRepository.changeLang(lang);
  }

  Future<bool> tryAutoLogin() async {
    try {
      if (!_prefs.containsKey('token') || !_prefs.containsKey('user')) {
        return false;
      }
      final token = _prefs.getString('token');
      final storedUserData = _prefs.getString('user');
      if (token == null || storedUserData == null || token.isEmpty) {
        return false;
      }
      final userData = json.decode(storedUserData) as Map<String, dynamic>;
      ApiService.setToken(token);
      emit(state.copyWith(token: token, user: UserModel.fromJson(userData)));
      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Auto-login failed: $e');
      }
      return false;
    }
  }

  void setImagePath(String? path) {
    emit(state.copyWith(imagePath: path, clearImagePath: path == null));
  }

  void clearNotificationsCount() {
    final user = state.user;
    if (user == null) return;
    emit(state.copyWith(user: user.copyWith(notificationCount: 0)));
  }

  void clearMessagesCount() {
    final user = state.user;
    if (user == null) return;
    emit(state.copyWith(user: user.copyWith(messagesCount: 0)));
  }

  void setWrongVerificationCode(String? message) {
    emit(
      state.copyWith(
        verificationErrorMessage: message,
        isNotValid: message != null,
        clearVerification: message == null,
      ),
    );
  }

  void setIsNotValid(bool value) {
    emit(state.copyWith(isNotValid: value));
  }

  void clearVerification() {
    emit(state.copyWith(clearVerification: true, isNotValid: false));
  }

  void resetOnLogout() => emit(const AuthState());

  Future<void> _persistUser(
    Map<String, dynamic> userData, {
    bool emitSuccess = true,
  }) async {
    final user = UserModel.fromJson(userData);
    final token = (userData['token'] ?? user.token)?.toString();
    if (token != null && token.isNotEmpty) {
      ApiService.setToken(token);
      await _prefs.setString('token', token);
    }
    await _prefs.setString('user', json.encode(userData));
    if (!emitSuccess) {
      emit(state.copyWith(user: user, token: token ?? state.token));
      return;
    }
    emit(
      state.copyWith(
        user: user,
        token: token ?? state.token,
        actionStatus: RequestStatus.success,
        lastMutation: state.lastMutation,
      ),
    );
  }

  Future<void> _clearLocalSession() async {
    await _prefs.remove('token');
    await _prefs.remove('user');
    ApiService.removeToken();
  }

  RedirectModel? _loginOtpRedirect(ApiException error) {
    final body = error.data;
    if (body is! Map) return null;
    final inner = body['data'];
    if (inner is! Map || inner['redirect'] == 'login') return null;
    return RedirectModel.fromJson(inner);
  }
}
