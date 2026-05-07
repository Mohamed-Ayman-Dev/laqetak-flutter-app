import 'package:flutter_bloc/flutter_bloc.dart';

///if register in locator as factory use create
/// BlocProvider<.AddressCubit>(create: (_) => sl<.AddressCubit>()),
///if register in locator as lazy use value (so you can use one instance of the cubit across the app and access it from locator service in any place in the app)
/// BlocProvider<.AddressCubit>.value(value: sl<.AddressCubit>()),
class AppBlocProviders {
  static List<BlocProvider> providers = [
    // BlocProvider<AddressCubit>.value(value: sl<AddressCubit>()),
    // BlocProvider<AddressFormCubit>.value(value: sl<AddressFormCubit>()),
    // BlocProvider<AuthBloc>.value(value: sl<AuthBloc>()),
  ];
}
