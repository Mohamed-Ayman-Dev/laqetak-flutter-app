import 'package:flutter/cupertino.dart';

import 'cache_helper.dart';

/// CacheManager = persistent storage
/// A class to manage cache data,
/// such as token , profile,settings,theme(Dark,light), onboarding status, user role, and language code.
/// It uses the CacheHelper to get and set data in the cache.

final class CacheManager {
  final CacheHelper _cacheHelper;

  CacheManager(this._cacheHelper);

  Future<void> loadCachedData() async {
    try {
      // final userJson = await _cacheHelper.getSecureData(
      //   key: StringManager.userKey,
      // );
      // final language = await _cacheHelper.getData(key: StringManager.langKey);
      // if (userJson != null) {
      //   LocatorService.authCubit.setUser(jsonDecode(userJson), cacheData: true);
      // }
      // if (language != null) {
      //   LocatorService.appSettingsCubit.setLanguage(
      //     language ?? "ar",
      //     cacheLang: false,
      //   );
      // }
    } catch (e) {
      debugPrint('Error loading cached data: $e');
    }
  }
}
