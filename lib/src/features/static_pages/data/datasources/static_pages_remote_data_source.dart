import '../../../../core/network/api_client.dart';
import '../../../../core/network/end_points.dart';
import '../models/faq_model.dart';

abstract class StaticPagesRemoteDataSource {
  Future<List<FaqModel>?> getFaqs();

  Future<void> sendContactUs(Map<String, dynamic> data);
}

class StaticPagesRemoteDataSourceImpl implements StaticPagesRemoteDataSource {
  StaticPagesRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<FaqModel>?> getFaqs() async {
    final response = await _apiClient.get(EndPoints.getFaqs);
    final data = response.responseData['data']
        .map<FaqModel>((e) => FaqModel.fromJson(e))
        .toList();
    return data;
  }

  @override
  Future<void> sendContactUs(Map<String, dynamic> data) async {
    await _apiClient.post(EndPoints.contactUs, data: data);
  }
}
