import '../models/settings_model.dart';

/// Defines the contract for fetching data from the remote API.
abstract class SettingsRemoteDataSource {
  Future<SettingsModel?> getSettings();
}
