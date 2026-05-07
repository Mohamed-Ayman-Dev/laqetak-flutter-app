import 'package:invastro/src/config/app_settings/data/models/settings_model.dart';
import 'package:invastro/src/core/network/api_service.dart';

import '../../../../core/network/end_points.dart';
import 'settings_remote_data_source.dart';

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final ApiService _apiService;

  SettingsRemoteDataSourceImpl(this._apiService);

  @override
  Future<SettingsModel> getGeneralSettings() async {
    final response = await _apiService.get(EndPoints.getAddresses);
    return response.dataOrThrow((data) => SettingsModel.fromJson(data['data']));
  }
}
