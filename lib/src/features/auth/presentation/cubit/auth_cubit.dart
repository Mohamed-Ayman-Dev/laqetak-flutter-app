import 'dart:convert';

import 'package:invastro/src/core/bloc_helpers/base_cubit.dart';
import 'package:invastro/src/core/constants/app_feedback.dart';
import 'package:invastro/src/core/constants/string_manager.dart';
import 'package:invastro/src/features/auth/data/models/user_model.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/dependency_injection/locator_service.dart';
import '../../domain/usecases/login_use_case.dart';
import '../screens/login_screen.dart';
import '../screens/otp_screen.dart';
import 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final CacheHelper _cacheHelper;

  AuthCubit(this._loginUseCase, this._cacheHelper) : super(const AuthState());

  String? get token => state.token;

  String? get refreshToken => state.refreshToken;

  bool get isAuth => state.user != null && state.token != null;

  Future<void> login(Map<String, dynamic> data) async {
    AppFeedback.loadingMessage();
    final result = await _loginUseCase(data);
    result.when(
      success: (data) async {
        AppFeedback.successToast(
          data?['message'] ?? S.current.youLoggedInSuccessfully,
        );
      },
      failure: (error) {
        AppFeedback.errorMessage(error);
        final redirect = error.data?['data']?['redirect'];
        if (redirect == 'register-otp') {
          LocatorService.navigationService.currentState?.pushNamed(
            OtpScreen.routeName,
            arguments: {
              'phone': data['phone'],
              'country_code': data['country_code'],
              'from': "login_screen",
              'remainingSeconds': error.data['data']['remainingSeconds'],
            },
          );
        }
      },
    );
  }

  Future<void> setUser(
    Map<String, dynamic> data, {
    bool cacheData = true,
  }) async {
    UserModel? user = UserModel.fromJson(data);
    emit(
      state.copyWith(
        user: user,
        token: data['token'],
        refreshToken: data['refreshToken'],
      ),
    );
    if (cacheData) {
      await _cacheHelper.saveSecureData(
        key: StringManager.userKey,
        value: json.encode(data),
      );
      await _cacheHelper.saveSecureData(
        key: StringManager.tokenKey,
        value: data['token'],
      );
      if (data['refreshToken'] != null) {
        await _cacheHelper.saveSecureData(
          key: StringManager.refreshTokenKey,
          value: data['refreshToken'],
        );
      }
    }
  }

  Future<void> resetUser({bool navigateToLogin = false}) async {
    state.copyWith(user: null, token: null, refreshToken: null);
    await _cacheHelper.removeSecureData(key: StringManager.tokenKey);
    await _cacheHelper.removeSecureData(key: StringManager.refreshTokenKey);
    await _cacheHelper.removeData(key: StringManager.userKey);
    if (navigateToLogin) {
      LocatorService.navigationService.currentState?.pushNamedAndRemoveUntil(
        LoginScreen.routeName,
        (route) => false,
      );
    }
  }

  void clearNotificationsCount() {
    emit(state.copyWith(user: state.user?.copyWith(notificationCount: 0)));
  }
}
