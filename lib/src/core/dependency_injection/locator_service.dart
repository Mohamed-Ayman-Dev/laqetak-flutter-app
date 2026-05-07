import 'package:invastro/src/features/auth/presentation/cubit/auth_cubit.dart';

import '../../config/app_settings/presentation/app_settings_cubit.dart';
import '../cache/cache_helper.dart';
import '../cache/cache_manager.dart';
import '../network/api_service.dart';
import '../services/navigation_service.dart';
import 'locator.dart';

final class LocatorService {
  LocatorService._();

  /// ---------------- Cache ----------------
  static CacheHelper get cacheHelper => sl<CacheHelper>();

  static CacheManager get cacheManager => sl<CacheManager>();

  static CacheManager get sessionManager => sl<CacheManager>();

  /// ---------------- Api ----------------
  static ApiService get apiService => sl<ApiService>();

  /// ---------------- Cubits ----------------
  static AuthCubit get authCubit => sl<AuthCubit>();

  static AppSettingsCubit get appSettingsCubit => sl<AppSettingsCubit>();

  /// ---------------- Services ----------------
  static NavigationService get navigationService => sl<NavigationService>();
}
