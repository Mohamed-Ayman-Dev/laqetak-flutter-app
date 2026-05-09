import 'dart:async';

import '../../network/api_service.dart';

class SettingsService {
  Future getSettings({bool rethrowError = false}) async {
    return await ApiService.get(
      '/settings',
      useDefaultUrl: true,
      rethrowError: rethrowError,
    );
  }
}
