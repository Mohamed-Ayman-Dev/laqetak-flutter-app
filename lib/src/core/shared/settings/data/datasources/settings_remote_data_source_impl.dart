import '../../../../network/api_client.dart';
import '../../../../network/end_points.dart';
import '../models/settings_model.dart';
import 'settings_remote_data_source.dart';

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  SettingsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<SettingsModel?> getSettings() async {
    final response = await _apiClient.get(EndPoints.getSettings);
    final data = SettingsModel.fromJson(response.responseData['data']);
    return data;
  }
}
