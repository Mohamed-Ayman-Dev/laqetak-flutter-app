import '../../../../core/network/api_result.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';

abstract class AdsRepository {
  Future<ApiResult<PaginationList<AdModel>>> getAds({
    required int page,
    num? typeId,
    String? search,
    Map<String, dynamic>? filters,
  });

  Future<ApiResult<PaginationList<AdModel>>> getFavAds(int page);

  Future<ApiResult<void>> toggleFav(num adId);

  Future<ApiResult<AdModel>> getAdDetails(num id);

  Future<ApiResult<void>> sendAdComplaint(Map<String, dynamic> data);

  Future<ApiResult<void>> sendCustomerComplaint(Map<String, dynamic> data);
}
