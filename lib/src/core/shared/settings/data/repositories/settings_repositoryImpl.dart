import 'dart:async';

import 'package:invastro/src/core/shared/settings/data/datasources/settings_remote_data_source.dart';
import 'package:invastro/src/core/shared/settings/data/models/settings_model.dart';
import 'package:invastro/src/core/shared/settings/data/repositories/settings_repository.dart';

import '../../../../error/exceptions.dart';
import '../../../../network/api_result.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({required SettingsRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final SettingsRemoteDataSource _remoteDataSource;

  @override
  Future<ApiResult<SettingsModel?>> getSettings() async {
    try {
      final settings = await _remoteDataSource.getSettings();
      return ApiResult.success(settings);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }
}
