import 'dart:async';

import 'package:laqetak/src/core/shared/others/data/datasources/others_remote_data_source.dart';
import 'package:laqetak/src/core/shared/others/data/models/budget_range_model.dart';
import 'package:laqetak/src/core/shared/others/data/models/category_model.dart';
import 'package:laqetak/src/core/shared/others/data/models/details_model.dart';
import 'package:laqetak/src/core/shared/others/data/models/sector_model.dart';
import 'package:laqetak/src/core/shared/others/data/repositories/others_repository.dart';

import '../../../../error/exceptions.dart';
import '../../../../network/api_result.dart';

class OthersRepositoryImpl implements OthersRepository {
  OthersRepositoryImpl({required OthersRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final OthersRemoteDataSource _remoteDataSource;

  @override
  Future<ApiResult<List<CategoryModel>?>> getCategories() async {
    try {
      final categories = await _remoteDataSource.getCategories();
      return ApiResult.success(categories);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<List<BudgetRangeModel>?>> getBudgetRanges() async {
    try {
      final budgetRanges = await _remoteDataSource.getBudgetRanges();
      return ApiResult.success(budgetRanges);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<List<DetailsModel>?>> getCities() async {
    try {
      final cities = await _remoteDataSource.getCities();
      return ApiResult.success(cities);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<List<SectorModel>?>> getSectors() async {
    try {
      final sectors = await _remoteDataSource.getSectors();
      return ApiResult.success(sectors);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }
}
