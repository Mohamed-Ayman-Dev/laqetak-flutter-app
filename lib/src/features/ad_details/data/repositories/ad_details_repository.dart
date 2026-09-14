import '../../../../core/network/api_result.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';

abstract class AdDetailsRepository {
  Future<ApiResult<PaginationList<AdModel>>> getCustomerAds({
    required num customerId,
    required int page,
  });

  Future<ApiResult<void>> toggleHidePhone(num adId);

  Future<ApiResult<void>> sendShowPhoneRequest(num adId);
}
