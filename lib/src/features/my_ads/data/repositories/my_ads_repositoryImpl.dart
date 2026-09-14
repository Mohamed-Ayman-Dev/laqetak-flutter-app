import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../datasources/my_ads_remote_data_source.dart';
import '../models/ad_otp_result.dart';
import '../models/pay_ad_result.dart';
import 'my_ads_repository.dart';

class MyAdsRepositoryImpl implements MyAdsRepository {
  MyAdsRepositoryImpl({required MyAdsRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final MyAdsRemoteDataSource _remoteDataSource;

  @override
  Future<ApiResult<PaginationList<AdModel>>> getMyAds(int page) async {
    try {
      final ads = await _remoteDataSource.getMyAds(page);
      return ApiResult.success(ads);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<AdModel?>> addAd(Map<String, dynamic> data) async {
    try {
      final ad = await _remoteDataSource.addAd(data);
      return ApiResult.success(ad);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> editAd(Map<String, dynamic> data) async {
    try {
      await _remoteDataSource.editAd(data);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<AdOtpResult>> sendAdOtp(Map<String, dynamic> data) async {
    try {
      final result = await _remoteDataSource.sendAdOtp(data);
      return ApiResult.success(result);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> deleteAd(num id) async {
    try {
      await _remoteDataSource.deleteAd(id);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<PayAdResult>> payAd(Map<String, dynamic> data) async {
    try {
      final result = await _remoteDataSource.payAd(data);
      return ApiResult.success(result);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> closeAd(num id) async {
    try {
      await _remoteDataSource.closeAd(id);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }
}
