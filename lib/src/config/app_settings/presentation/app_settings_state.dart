import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:invastro/src/config/app_settings/data/models/settings_model.dart';

import '../../../core/constants/enums.dart';

class AppSettingsState extends Equatable {
  final String language;
  final ThemeMode themeMode;
  final double rating;
  final int homeIndex;
  final SettingsModel? mySettings;
  final RequestState settingsRequestState;
  final String urlType;

  const AppSettingsState({
    this.language = 'ar',
    this.themeMode = ThemeMode.system,
    this.rating = 0.0,
    this.homeIndex = 0,
    this.mySettings,
    this.settingsRequestState = RequestState.initial,
    this.urlType = 'production',
  });

  AppSettingsState copyWith({
    String? language,
    ThemeMode? themeMode,
    double? rating,
    int? homeIndex,
    SettingsModel? mySettings,
    RequestState? settingsRequestState,
    String? urlType,
  }) {
    return AppSettingsState(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      rating: rating ?? this.rating,
      homeIndex: homeIndex ?? this.homeIndex,
      mySettings: mySettings ?? this.mySettings,
      settingsRequestState: settingsRequestState ?? this.settingsRequestState,
      urlType: urlType ?? this.urlType,
    );
  }

  @override
  List<Object?> get props => [
    language,
    themeMode,
    rating,
    homeIndex,
    mySettings,
    settingsRequestState,
    urlType,
  ];
}
