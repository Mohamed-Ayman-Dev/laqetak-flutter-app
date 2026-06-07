import 'package:invastro/src/core/error/error_helper.dart';

import '../../di/locator_service.dart';
import '../models/settings_model.dart';

abstract class SettingsController {
  ///get general settings
  static Future<void> getGeneralSettings() async {
    try {
      LocatorService.appSettings.setLoadingSettings(true);
      final response = await LocatorService.settingsService.getSettings(
        rethrowError: true,
      );
      final settings = SettingsModel.fromJson(response['data']);
      LocatorService.appSettings.setSettings(settings);
    } catch (e) {
      ErrorHelper.handleApiError(e);
    } finally {
      LocatorService.appSettings.setLoadingSettings(false);
    }
  }
}
