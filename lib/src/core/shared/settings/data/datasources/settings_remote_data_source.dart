import '../../../../network/api_client.dart';
import '../../../../network/end_points.dart';
import '../models/settings_model.dart';

/// Defines the contract for fetching data from the remote API.
abstract class SettingsRemoteDataSource {
  Future<SettingsModel?> getSettings();
}

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
