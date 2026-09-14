import '../../../../core/network/api_client.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';

abstract class AdsRemoteDataSource {
  Future<PaginationList<AdModel>> getAds({
    required int page,
    num? typeId,
    String? search,
    Map<String, dynamic>? filters,
  });

  Future<PaginationList<AdModel>> getFavAds(int page);

  Future<void> toggleFav(num adId);

  Future<AdModel> getAdDetails(num id);

  Future<void> sendAdComplaint(Map<String, dynamic> data);

  Future<void> sendCustomerComplaint(Map<String, dynamic> data);
}

class AdsRemoteDataSourceImpl implements AdsRemoteDataSource {
  AdsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  PaginationList<AdModel> _parsePage(dynamic responseData) {
    final json = Map<String, dynamic>.from(responseData as Map);
    json['data'] = (json['data'] as List)
        .map((e) => AdModel.fromJson(e))
        .toList();
    return PaginationList<AdModel>.fromJson(json);
  }

  @override
  Future<PaginationList<AdModel>> getAds({
    required int page,
    num? typeId,
    String? search,
    Map<String, dynamic>? filters,
  }) async {
    final response = await _apiClient.get(
      EndPoints.getAds,
      queryParameters: {
        'page': page,
        'category_id': typeId,
        'search': search,
        ...?filters,
      },
    );
    return _parsePage(response.responseData);
  }

  @override
  Future<PaginationList<AdModel>> getFavAds(int page) async {
    final response = await _apiClient.get(
      EndPoints.getFavAds,
      queryParameters: {'page': page},
    );
    return _parsePage(response.responseData);
  }

  @override
  Future<void> toggleFav(num adId) async {
    await _apiClient.post(EndPoints.toggleFav, data: {'ad_id': adId});
  }

  @override
  Future<AdModel> getAdDetails(num id) async {
    final response = await _apiClient.get(EndPoints.getAdDetails(id));
    return AdModel.fromJson(response.responseData['data']);
  }

  @override
  Future<void> sendAdComplaint(Map<String, dynamic> data) async {
    await _apiClient.post(EndPoints.sendAdComplaint, data: data);
  }

  @override
  Future<void> sendCustomerComplaint(Map<String, dynamic> data) async {
    await _apiClient.post(EndPoints.sendCustomerComplaint, data: data);
  }
}
