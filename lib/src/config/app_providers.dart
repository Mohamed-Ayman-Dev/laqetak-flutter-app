import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invastro/src/core/shared/others/presentation/cubit/others_cubit.dart';
import 'package:invastro/src/core/shared/settings/presentation/cubit/settings_cubit.dart';
import 'package:invastro/src/core/shared/timers/presentation/cubit/timer_cubit.dart';
import 'package:invastro/src/features/ad_details/presentation/cubit/ad_details_cubit.dart';
import 'package:invastro/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:invastro/src/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:invastro/src/features/home/presentation/cubit/ads_cubit.dart';
import 'package:invastro/src/features/my_ads/presentation/cubit/my_ads_cubit.dart';
import 'package:invastro/src/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:invastro/src/features/static_pages/presentation/cubit/static_pages_cubit.dart';

import '../core/di/locator.dart';

class AppBlocProviders {
  static List<BlocProvider> providers = [
    BlocProvider<TimerCubit>.value(value: locator<TimerCubit>()),
    BlocProvider<OthersCubit>.value(value: locator<OthersCubit>()),
    BlocProvider<SettingsCubit>.value(value: locator<SettingsCubit>()),
    BlocProvider<AuthCubit>.value(value: locator<AuthCubit>()),
    BlocProvider<StaticPagesCubit>.value(value: locator<StaticPagesCubit>()),
    BlocProvider<NotificationsCubit>.value(
      value: locator<NotificationsCubit>(),
    ),
    BlocProvider<AdsCubit>.value(value: locator<AdsCubit>()),
    BlocProvider<MyAdsCubit>.value(value: locator<MyAdsCubit>()),
    BlocProvider<ChatCubit>.value(value: locator<ChatCubit>()),
    BlocProvider<AdDetailsCubit>.value(value: locator<AdDetailsCubit>()),
  ];
}
