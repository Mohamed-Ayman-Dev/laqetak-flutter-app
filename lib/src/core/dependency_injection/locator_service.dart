
import '../cache/cache_manager.dart';
import '../cache/cash_helper.dart';
import '../cache/session_manager.dart';
import '../navigation_service.dart';
import '../network/api_service.dart';
import 'locator.dart';

final class LocatorService {
  LocatorService._();

  /// ---------------- Cache ----------------
  static CacheHelper get cacheHelper => sl<CacheHelper>();

  static CacheManager get cacheManager => sl<CacheManager>();

  static SessionManager get sessionManager => sl<SessionManager>();

  /// ---------------- Api ----------------
  static ApiService get apiService => sl<ApiService>();

  /// ---------------- Cubits ----------------
  // static AddressCubit get addressCubit => sl<AddressCubit>();

 /// ---------------- Services ----------------
  static NavigationService get navigationService =>
      sl<NavigationService>();

}
