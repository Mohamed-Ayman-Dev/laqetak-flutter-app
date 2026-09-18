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
