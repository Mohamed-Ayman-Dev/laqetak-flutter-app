import '../../../../core/network/api_client.dart';
import '../../../../core/network/end_points.dart';
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

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return {};
  }

  @override
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    final response = await _apiClient.post(EndPoints.login, data: data);
    return _asMap(_asMap(response.responseData)['data']);
  }

  @override
  Future<RedirectModel> register(Map<String, dynamic> data) async {
    final response = await _apiClient.post(
      EndPoints.register,
      data: data,
      hasMultipartData: true,
    );
    return RedirectModel.fromJson(_asMap(response.responseData)['data']);
  }

  @override
  Future<Map<String, dynamic>> registerOtp(Map<String, dynamic> data) async {
    final response = await _apiClient.post(EndPoints.registerOtp, data: data);
    return _asMap(response.responseData);
  }

  @override
  Future<void> registerOtpResend(Map<String, dynamic> data) async {
    await _apiClient.post(EndPoints.registerOtpResend, data: data);
  }

  @override
  Future<bool> forgetPassword(Map<String, dynamic> data) async {
    final response = await _apiClient.post(
      EndPoints.forgetPassword,
      queryParameters: data,
    );
    return _asMap(response.responseData)['status'] == true;
  }

  @override
  Future<void> forgetPasswordOtp(Map<String, dynamic> data) async {
    await _apiClient.post(EndPoints.forgetPasswordOtp, data: data);
  }

  @override
  Future<void> resetPassword(Map<String, dynamic> data) async {
    await _apiClient.post(EndPoints.forgetPasswordReset, data: data);
  }

  @override
  Future<void> logout({String? deviceToken}) async {
    await _apiClient.post(
      EndPoints.logout,
      data: {'device_token': deviceToken},
    );
  }

  @override
  Future<void> deleteAccount() async {
    await _apiClient.post(EndPoints.deleteProfile);
  }

  @override
  Future<Map<String, dynamic>> getProfile() async {
    final response = await _apiClient.get(EndPoints.getProfile);
    return _asMap(_asMap(response.responseData)['data']);
  }

  @override
  Future<String?> updateProfile({
    required Map<String, dynamic> data,
    required bool hasMultipartData,
  }) async {
    final response = await _apiClient.post(
      EndPoints.updateProfile,
      data: data,
      hasMultipartData: hasMultipartData,
    );
    return _asMap(response.responseData)['message']?.toString();
  }

  @override
  Future<PhoneOtpResult> sendPhoneOtp(String phone) async {
    final response = await _apiClient.post(
      EndPoints.profilePhoneOtp,
      data: {'phone': phone},
    );
    final json = _asMap(response.responseData);
    final data = json['data'];
    return PhoneOtpResult(
      redirect: data == null ? null : RedirectModel.fromJson(data),
      message: json['message']?.toString(),
    );
  }

  @override
  Future<void> sendDeviceToken(String token) async {
    await _apiClient.post(EndPoints.deviceToken, data: {'device_token': token});
  }

  @override
  Future<void> changeLang(String language) async {
    await _apiClient.post(
      EndPoints.updateLanguage,
      data: {'language': language},
    );
  }
}
