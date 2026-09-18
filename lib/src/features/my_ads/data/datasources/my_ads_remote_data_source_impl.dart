import '../../../../core/network/api_client.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../../../core/shared/models/redirect_model.dart';
import '../models/ad_otp_result.dart';
import '../models/pay_ad_result.dart';
import 'my_ads_remote_data_source.dart';

class MyAdsRemoteDataSourceImpl implements MyAdsRemoteDataSource {
  MyAdsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  PaginationList<AdModel> _parsePage(dynamic responseData) {
    final json = Map<String, dynamic>.from(responseData as Map);
    json['data'] = (json['data'] as List)
        .map((e) => AdModel.fromJson(e))
        .toList();
    return PaginationList<AdModel>.fromJson(json);
  }

  @override
  Future<PaginationList<AdModel>> getMyAds(int page) async {
    final response = await _apiClient.get(
      EndPoints.getMyAds,
      queryParameters: {'page': page},
    );
    return _parsePage(response.responseData);
  }

  @override
  Future<AdModel?> addAd(Map<String, dynamic> data) async {
    final response = await _apiClient.post(
      EndPoints.createMyAd,
      data: data,
      hasMultipartData: true,
    );
    final payload = response.responseData['data'];
    if (payload == null) return null;
    return AdModel.fromJson(payload);
  }

  @override
  Future<void> editAd(Map<String, dynamic> data) async {
    await _apiClient.post(
      EndPoints.updateMyAd,
      data: data,
      hasMultipartData: true,
    );
  }

  @override
  Future<AdOtpResult> sendAdOtp(Map<String, dynamic> data) async {
    final response = await _apiClient.post(EndPoints.sendAdOtp, data: data);
    final json = response.responseData;
    RedirectModel? redirect;
    if (json is Map && json['data'] != null) {
      redirect = RedirectModel.fromJson(json['data']);
    }
    return AdOtpResult(
      message: json is Map ? json['message']?.toString() : null,
      redirect: redirect,
    );
  }

  @override
  Future<void> deleteAd(num id) async {
    await _apiClient.get(EndPoints.deleteMyAd(id));
  }

  @override
  Future<PayAdResult> payAd(Map<String, dynamic> data) async {
    final response = await _apiClient.post(EndPoints.payMyAd, data: data);
    final payload = response.responseData['data'];
    final map = payload is Map ? Map<String, dynamic>.from(payload) : null;
    final checkoutUrl = map?['checkout_url'];
    return PayAdResult(
      checkoutUrl: checkoutUrl?.toString(),
      time: map?['time'],
    );
  }

  @override
  Future<void> closeAd(num id) async {
    await _apiClient.get(EndPoints.closeMyAd(id));
  }
}
