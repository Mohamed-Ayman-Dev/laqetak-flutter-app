import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../constants/enums.dart';
import '../../../../constants/string_manager.dart';
import '../../data/models/settings_model.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.settings,
    this.settingsStatus = RequestStatus.initial,
    this.language = StringManager.arLanguageCode,
    this.themeMode = ThemeMode.light,
    this.homeIndex = 0,
    this.urlType = 'production',
    this.errorMessage,
  });

  final SettingsModel? settings;
  final RequestStatus settingsStatus;
  final String language;
  final ThemeMode themeMode;
  final int homeIndex;
  final String urlType;
  final String? errorMessage;

  bool get hasError => settingsStatus == RequestStatus.error;

  bool get isLoading => settingsStatus == RequestStatus.loading;

  SettingsState copyWith({
    SettingsModel? settings,
    RequestStatus? settingsStatus,
    String? language,
    ThemeMode? themeMode,
    int? homeIndex,
    String? urlType,
    String? errorMessage,
  }) => SettingsState(
    settings: settings ?? this.settings,
    settingsStatus: settingsStatus ?? this.settingsStatus,
    language: language ?? this.language,
    themeMode: themeMode ?? this.themeMode,
    homeIndex: homeIndex ?? this.homeIndex,
    urlType: urlType ?? this.urlType,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    settings,
    settingsStatus,
    language,
    themeMode,
    homeIndex,
    urlType,
    errorMessage,
  ];
}
