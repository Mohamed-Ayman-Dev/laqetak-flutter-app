import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/shared/models/redirect_model.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/phone_otp_result.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<ApiResult<Map<String, dynamic>>> login(
    Map<String, dynamic> data,
  ) async {
    try {
      return ApiResult.success(await _remoteDataSource.login(data));
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<RedirectModel>> register(Map<String, dynamic> data) async {
    try {
      return ApiResult.success(await _remoteDataSource.register(data));
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> registerOtp(
    Map<String, dynamic> data,
  ) async {
    try {
      return ApiResult.success(await _remoteDataSource.registerOtp(data));
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> registerOtpResend(Map<String, dynamic> data) async {
    try {
      await _remoteDataSource.registerOtpResend(data);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<bool>> forgetPassword(Map<String, dynamic> data) async {
    try {
      return ApiResult.success(await _remoteDataSource.forgetPassword(data));
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> forgetPasswordOtp(Map<String, dynamic> data) async {
    try {
      await _remoteDataSource.forgetPasswordOtp(data);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> resetPassword(Map<String, dynamic> data) async {
    try {
      await _remoteDataSource.resetPassword(data);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> logout({String? deviceToken}) async {
    try {
      await _remoteDataSource.logout(deviceToken: deviceToken);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> deleteAccount() async {
    try {
      await _remoteDataSource.deleteAccount();
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getProfile() async {
    try {
      return ApiResult.success(await _remoteDataSource.getProfile());
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<String?>> updateProfile({
    required Map<String, dynamic> data,
    required bool hasMultipartData,
  }) async {
    try {
      return ApiResult.success(
        await _remoteDataSource.updateProfile(
          data: data,
          hasMultipartData: hasMultipartData,
        ),
      );
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<PhoneOtpResult>> sendPhoneOtp(String phone) async {
    try {
      return ApiResult.success(await _remoteDataSource.sendPhoneOtp(phone));
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> sendDeviceToken(String token) async {
    try {
      await _remoteDataSource.sendDeviceToken(token);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> changeLang(String language) async {
    try {
      await _remoteDataSource.changeLang(language);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }
}
