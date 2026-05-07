import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invastro/src/config/app_settings/presentation/app_settings_cubit.dart';
import 'package:invastro/src/features/auth/presentation/cubit/auth_cubit.dart';

import '../core/dependency_injection/locator.dart';

///if register in locator as factory use create
/// BlocProvider<.AddressCubit>(create: (_) => sl<.AddressCubit>()),
///if register in locator as lazy use value (so you can use one instance of the cubit across the app and access it from locator service in any place in the app)
/// BlocProvider<.AddressCubit>.value(value: sl<.AddressCubit>()),
class AppBlocProviders {
  static List<BlocProvider> providers = [
    BlocProvider<AppSettingsCubit>.value(value: sl<AppSettingsCubit>()),
    BlocProvider<AuthCubit>.value(value: sl<AuthCubit>()),
  ];
}
