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
  // static AddressCubit get addressCubit => sl<AddressCubit>();

  /// ---------------- Services ----------------
  static NavigationService get navigationService => sl<NavigationService>();
}
