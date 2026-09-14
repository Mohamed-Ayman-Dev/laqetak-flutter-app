import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invastro/src/core/bloc_helpers/base_cubit.dart';
import 'package:invastro/src/core/shared/settings/data/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../constants/enums.dart';
import '../../../../constants/string_manager.dart';
import '../../../../di/locator_service.dart';
import '../../../../helpers/navigation_helper.dart';
import '../../../../network/api_service.dart';
import '../../../../widgets/timeout_splashscreen.dart';
import 'settings_state.dart';

class SettingsCubit extends BaseCubit<SettingsState> {
  SettingsCubit(this._settingsRepository, this._prefs)
    : super(const SettingsState());

  final SettingsRepository _settingsRepository;
  final SharedPreferences _prefs;

  Future<void> getSettings() async {
    if (state.settingsStatus == RequestStatus.loading) return;
    emit(state.copyWith(settingsStatus: RequestStatus.loading));

    final result = await _settingsRepository.getSettings();
    result.when(
      success: (settings) => emit(
        state.copyWith(
          settings: settings,
          settingsStatus: RequestStatus.success,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          settingsStatus: RequestStatus.error,
          errorMessage: error.message,
        ),
      ),
    );
  }

  void changeHomeIndex(int index) {
    if (state.homeIndex == index) return;
    emit(state.copyWith(homeIndex: index));
  }

  void resetOnLogout() => emit(state.copyWith(homeIndex: 0));

  Future<void> loadStoredPrefs() async {
    var language = state.language;
    if (_prefs.containsKey('language')) {
      language = _prefs.getString('language') ?? StringManager.arLanguageCode;
    } else {
      await _prefs.setString('language', language);
    }
    ApiService.setLanguage(language);
    await S.load(Locale(language));

    var urlType = state.urlType;
    if (_prefs.containsKey('urlType')) {
      urlType = _prefs.getString('urlType') ?? 'production';
      ApiService.baseOptions.baseUrl = urlType == 'develop'
          ? 'https://invastro.dev4.wady.sa/api/v1/customer'
          : 'https://invastro.dev4.wady.sa/api/v1/customer';
    }

    emit(
      state.copyWith(
        language: language,
        themeMode: ThemeMode.light,
        urlType: urlType,
      ),
    );
  }

  Future<void> changeLanguage(String newLanguage) async {
    if (state.language == newLanguage) return;
    await _prefs.setString('language', newLanguage);
    await S.load(Locale(newLanguage));
    ApiService.setLanguage(newLanguage);
    emit(state.copyWith(language: newLanguage));
    await getSettings();
  }

  void changeLanguageInUi(
    BuildContext context,
    String languageCode, {
    bool showSplashScreen = true,
  }) {
    if (Intl.getCurrentLocale() == languageCode) return;
    if (showSplashScreen) {
      Navigator.of(context)
          .push(
            NavigationHelper.slideRightRouteBuilder(
              context,
              const TimeoutSplashScreen(),
              const Duration(milliseconds: 600),
              {'timeout': const Duration(seconds: 1)},
              TimeoutSplashScreen.routeName,
            ),
          )
          .then((_) async {
            await changeLanguage(languageCode);
            LocatorService.adsCubit.getAds(refresh: true);
          });
    } else {
      changeLanguage(languageCode);
    }
  }
}
