import '../../../../core/network/api_client.dart';
import '../../../../core/network/end_points.dart';
import '../models/faq_model.dart';
import 'static_pages_remote_data_source.dart';

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
