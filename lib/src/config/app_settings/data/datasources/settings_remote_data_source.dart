import 'package:invastro/src/config/app_settings/data/models/settings_model.dart';

abstract class SettingsRemoteDataSource {
  Future<SettingsModel> getGeneralSettings();
}
