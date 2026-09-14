import '../../../../core/network/api_client.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';

abstract class AdDetailsRemoteDataSource {
  Future<PaginationList<AdModel>> getCustomerAds({
    required num customerId,
    required int page,
  });

  Future<void> toggleHidePhone(num adId);

  Future<void> sendShowPhoneRequest(num adId);
}

class AdDetailsRemoteDataSourceImpl implements AdDetailsRemoteDataSource {
  AdDetailsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<PaginationList<AdModel>> getCustomerAds({
    required num customerId,
    required int page,
  }) async {
    final response = await _apiClient.get(
      EndPoints.getCustomerAds(customerId),
      queryParameters: {'page': page},
    );
    final json = Map<String, dynamic>.from(response.responseData as Map);
    json['data'] = (json['data'] as List)
        .map((e) => AdModel.fromJson(e))
        .toList();
    return PaginationList<AdModel>.fromJson(json);
  }

  @override
  Future<void> toggleHidePhone(num adId) async {
    await _apiClient.get(EndPoints.toggleHidePhone(adId));
  }

  @override
  Future<void> sendShowPhoneRequest(num adId) async {
    await _apiClient.post(EndPoints.requestContact, data: {'ad_id': adId});
  }
}
