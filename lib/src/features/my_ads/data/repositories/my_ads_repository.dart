import '../../../../core/network/api_result.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../models/ad_otp_result.dart';
import '../models/pay_ad_result.dart';

abstract class MyAdsRepository {
  Future<ApiResult<PaginationList<AdModel>>> getMyAds(int page);

  Future<ApiResult<AdModel?>> addAd(Map<String, dynamic> data);

  Future<ApiResult<void>> editAd(Map<String, dynamic> data);

  Future<ApiResult<AdOtpResult>> sendAdOtp(Map<String, dynamic> data);

  Future<ApiResult<void>> deleteAd(num id);

  Future<ApiResult<PayAdResult>> payAd(Map<String, dynamic> data);

  Future<ApiResult<void>> closeAd(num id);
}
