import '../../../../network/api_result.dart';
import '../models/settings_model.dart';

/// Defines the contract for retrieving data.

abstract class SettingsRepository {
  Future<ApiResult<SettingsModel?>> getSettings();
}
