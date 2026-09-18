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
