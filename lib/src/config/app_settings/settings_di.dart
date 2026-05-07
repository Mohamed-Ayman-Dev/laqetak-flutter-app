import 'package:invastro/src/config/app_settings/data/datasources/settings_remote_data_source.dart';
import 'package:invastro/src/config/app_settings/data/datasources/settings_remote_data_source_impl.dart';
import 'package:invastro/src/config/app_settings/data/repositories/settings_repository.dart';
import 'package:invastro/src/config/app_settings/presentation/app_settings_cubit.dart';

import '../../core/dependency_injection/locator.dart';

class SettingsDI {
  static void init() {
    /// ---------------- Data Sources ----------------
    sl.registerLazySingleton<SettingsRemoteDataSource>(
      () => SettingsRemoteDataSourceImpl(sl()),
    );

    /// ---------------- Repositories ----------------
    sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepository(sl()),
    );

    /// ---------------- Cubit ----------------
    sl.registerLazySingleton<AppSettingsCubit>(
      () => AppSettingsCubit(sl(), sl()),
    );
  }
}
