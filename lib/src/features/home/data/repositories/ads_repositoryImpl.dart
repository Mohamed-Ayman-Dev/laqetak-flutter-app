import 'package:laqetak/src/features/home/data/datasources/ads_remote_data_source.dart';
import 'package:laqetak/src/features/home/data/repositories/ads_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';

class AdsRepositoryImpl implements AdsRepository {
  AdsRepositoryImpl({required AdsRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final AdsRemoteDataSource _remoteDataSource;

  @override
  Future<ApiResult<PaginationList<AdModel>>> getAds({
    required int page,
    num? typeId,
    String? search,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final ads = await _remoteDataSource.getAds(
        page: page,
        typeId: typeId,
        search: search,
        filters: filters,
      );
      return ApiResult.success(ads);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<PaginationList<AdModel>>> getFavAds(int page) async {
    try {
      final ads = await _remoteDataSource.getFavAds(page);
      return ApiResult.success(ads);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> toggleFav(num adId) async {
    try {
      await _remoteDataSource.toggleFav(adId);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<AdModel>> getAdDetails(num id) async {
    try {
      final ad = await _remoteDataSource.getAdDetails(id);
      return ApiResult.success(ad);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> sendAdComplaint(Map<String, dynamic> data) async {
    try {
      await _remoteDataSource.sendAdComplaint(data);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> sendCustomerComplaint(
    Map<String, dynamic> data,
  ) async {
    try {
      await _remoteDataSource.sendCustomerComplaint(data);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }
}
