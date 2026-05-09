import 'package:invastro/src/core/error/error_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      // Save the current stage to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      if (settings.currentStage != null) {
        await prefs.setString('currentStage', settings.currentStage!);
      }
    } catch (e) {
      ErrorHelper.handleApiError(e);
    } finally {
      LocatorService.appSettings.setLoadingSettings(false);
    }
  }
}
