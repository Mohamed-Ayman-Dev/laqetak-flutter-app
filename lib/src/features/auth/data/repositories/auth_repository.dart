import '../../../../core/network/api_result.dart';
import '../../../../core/shared/models/redirect_model.dart';
import '../models/phone_otp_result.dart';

abstract class AuthRepository {
  Future<ApiResult<Map<String, dynamic>>> login(Map<String, dynamic> data);

  Future<ApiResult<RedirectModel>> register(Map<String, dynamic> data);

  Future<ApiResult<Map<String, dynamic>>> registerOtp(
    Map<String, dynamic> data,
  );

  Future<ApiResult<void>> registerOtpResend(Map<String, dynamic> data);

  Future<ApiResult<bool>> forgetPassword(Map<String, dynamic> data);

  Future<ApiResult<void>> forgetPasswordOtp(Map<String, dynamic> data);

  Future<ApiResult<void>> resetPassword(Map<String, dynamic> data);

  Future<ApiResult<void>> logout({String? deviceToken});

  Future<ApiResult<void>> deleteAccount();

  Future<ApiResult<Map<String, dynamic>>> getProfile();

  Future<ApiResult<String?>> updateProfile({
    required Map<String, dynamic> data,
    required bool hasMultipartData,
  });

  Future<ApiResult<PhoneOtpResult>> sendPhoneOtp(String phone);

  Future<ApiResult<void>> sendDeviceToken(String token);

  Future<ApiResult<void>> changeLang(String language);
}
