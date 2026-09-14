import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../datasources/ad_details_remote_data_source.dart';
import 'ad_details_repository.dart';

class AdDetailsRepositoryImpl implements AdDetailsRepository {
  AdDetailsRepositoryImpl({required AdDetailsRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final AdDetailsRemoteDataSource _remoteDataSource;

  @override
  Future<ApiResult<PaginationList<AdModel>>> getCustomerAds({
    required num customerId,
    required int page,
  }) async {
    try {
      final pageData = await _remoteDataSource.getCustomerAds(
        customerId: customerId,
        page: page,
      );
      return ApiResult.success(pageData);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> toggleHidePhone(num adId) async {
    try {
      await _remoteDataSource.toggleHidePhone(adId);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> sendShowPhoneRequest(num adId) async {
    try {
      await _remoteDataSource.sendShowPhoneRequest(adId);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }
}
