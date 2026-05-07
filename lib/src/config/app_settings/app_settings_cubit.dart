import 'dart:ui';

import 'package:invastro/src/config/app_settings/settings_model.dart';
import 'package:invastro/src/core/constants/string_manager.dart';

import '../../../generated/l10n.dart';
import '../../core/bloc_helpers/base_cubit.dart';
import '../../core/cache/cache_helper.dart';
import '../../core/constants/enums.dart';
import 'app_settings_state.dart';

class AppSettingsCubit extends BaseCubit<AppSettingsState> {
  final CacheHelper cacheHelper;

  AppSettingsCubit({required this.cacheHelper})
    : super(const AppSettingsState());

  String? get langCode => state.language;

  void setSettings(SettingsModel settings) {
    emit(state.copyWith(mySettings: settings));
  }

  void setLoadingSettings(bool loading) {
    if (loading) {
      emit(state.copyWith(settingsRequestState: RequestState.loading));
    } else {
      emit(state.copyWith(settingsRequestState: RequestState.success));
    }
  }

  void changeHomeIndex(int index) {
    if (state.homeIndex == index) return;
    emit(state.copyWith(homeIndex: index));
  }

  Future<void> setLanguage(String newLanguage, {bool cacheLang = true}) async {
    if (cacheLang) {
      cacheHelper.saveData(key: StringManager.langKey, value: newLanguage);
    }
    await S.load(Locale(newLanguage));
    emit(state.copyWith(language: newLanguage));
  }
}
