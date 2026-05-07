import 'package:invastro/src/config/app_settings/data/datasources/settings_remote_data_source.dart';
import 'package:invastro/src/config/app_settings/data/models/settings_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_result.dart';

///repo can only use to get the data from the data source ..
/// data source can be api or cached or local or else
/// the only thing you can do here is to check on something like internet (offline -online) and use the result to return the right data source if there is more than one

class SettingsRepository {
  final SettingsRemoteDataSource _settingsRemoteDataSource;

  SettingsRepository(this._settingsRemoteDataSource);

  Future<ApiResult<SettingsModel>> getGeneralSettings() async {
    try {
      final settingsModel = await _settingsRemoteDataSource
          .getGeneralSettings();
      return ApiResult.success(settingsModel);
    } catch (e) {
      return ApiResult.failure(
        e is ApiException ? e : ApiException(message: e.toString()),
      );
    }
  }
}
