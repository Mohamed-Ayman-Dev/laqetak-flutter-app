import 'package:invastro/src/features/auth/presentation/cubit/auth_cubit.dart';

import '../../core/dependency_injection/locator.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/datasources/auth_remote_data_source_impl.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/login_use_case.dart';

class AuthDI {
  static void init() {
    /// ---------------- Data Sources ----------------
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    );

    /// ---------------- Repositories ----------------
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

    /// ---------------- UseCases ----------------
    sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));

    /// ---------------- Cubit ----------------
    sl.registerFactory<AuthCubit>(() => AuthCubit(sl(), sl()));
  }
}
