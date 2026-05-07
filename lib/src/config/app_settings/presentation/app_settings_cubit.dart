import 'dart:ui';

import 'package:invastro/src/config/app_settings/data/models/settings_model.dart';
import 'package:invastro/src/config/app_settings/data/repositories/settings_repository.dart';
import 'package:invastro/src/core/constants/string_manager.dart';

import '../../../../generated/l10n.dart';
import '../../../core/bloc_helpers/base_cubit.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/constants/app_feedback.dart';
import '../../../core/constants/enums.dart';
import 'app_settings_state.dart';

class AppSettingsCubit extends BaseCubit<AppSettingsState> {
  final CacheHelper _cacheHelper;
  final SettingsRepository _settingsRepository;

  AppSettingsCubit(this._cacheHelper, this._settingsRepository)
    : super(const AppSettingsState());

  String? get langCode => state.language;

  Future<void> getGeneralSettings() async {
    final result = await _settingsRepository.getGeneralSettings();
    result.when(
      success: (settings) {
        setSettings(settings);
      },
      failure: (error) {
        AppFeedback.errorMessage(error);
      },
    );
  }

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
    emit(state.copyWith(language: newLanguage));
    await S.load(Locale(newLanguage));
    if (cacheLang) {
      _cacheHelper.saveData(key: StringManager.langKey, value: newLanguage);
    }
  }
}
