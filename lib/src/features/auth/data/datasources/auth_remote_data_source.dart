import '../../../../core/shared/models/redirect_model.dart';
import '../models/phone_otp_result.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(Map<String, dynamic> data);

  Future<RedirectModel> register(Map<String, dynamic> data);

  Future<Map<String, dynamic>> registerOtp(Map<String, dynamic> data);

  Future<void> registerOtpResend(Map<String, dynamic> data);

  Future<bool> forgetPassword(Map<String, dynamic> data);

  Future<void> forgetPasswordOtp(Map<String, dynamic> data);

  Future<void> resetPassword(Map<String, dynamic> data);

  Future<void> logout({String? deviceToken});

  Future<void> deleteAccount();

  Future<Map<String, dynamic>> getProfile();

  Future<String?> updateProfile({
    required Map<String, dynamic> data,
    required bool hasMultipartData,
  });

  Future<PhoneOtpResult> sendPhoneOtp(String phone);

  Future<void> sendDeviceToken(String token);

  Future<void> changeLang(String language);
}
