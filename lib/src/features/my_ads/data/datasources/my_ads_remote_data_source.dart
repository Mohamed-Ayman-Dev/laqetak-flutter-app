import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../models/ad_otp_result.dart';
import '../models/pay_ad_result.dart';

abstract class MyAdsRemoteDataSource {
  Future<PaginationList<AdModel>> getMyAds(int page);

  Future<AdModel?> addAd(Map<String, dynamic> data);

  Future<void> editAd(Map<String, dynamic> data);

  Future<AdOtpResult> sendAdOtp(Map<String, dynamic> data);

  Future<void> deleteAd(num id);

  Future<PayAdResult> payAd(Map<String, dynamic> data);

  Future<void> closeAd(num id);
}
