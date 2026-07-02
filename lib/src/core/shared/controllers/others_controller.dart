import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:invastro/src/core/error/error_helper.dart';
import 'package:invastro/src/core/shared/models/budget_range_model.dart';
import 'package:invastro/src/core/shared/models/category_model.dart';

import '../../../../generated/l10n.dart';
import '../../di/locator_service.dart';
import '../models/details_model.dart';

abstract class OthersController {
  /// Get list of cities
  /// Returns list of cities on success
  static Future<void> getCities({bool showLoading = false}) async {
    if (showLoading) {
      EasyLoading.show(status: S.current.pleaseWait);
    }
    try {
      final response = await LocatorService.othersService.getCities(
        rethrowError: true,
      );
      LocatorService.others.setCities(
        response['data']
            .map<DetailsModel>((e) => DetailsModel.fromJson(e))
            .toList(),
      );
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }

  static Future<void> getSectors() async {
    try {
      final response = await LocatorService.othersService.getSectors(
        rethrowError: true,
      );
      LocatorService.others.setSectors(
        response['data']
            .map<DetailsModel>((e) => DetailsModel.fromJson(e))
            .toList(),
      );
    } catch (e) {
      ErrorHelper.handleApiError(e);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> getBudgetRanges() async {
    try {
      final response = await LocatorService.othersService.getBudgetRanges(
        rethrowError: true,
      );
      LocatorService.others.setBudgetRanges(
        response['data']
            .map<BudgetRangeModel>((e) => BudgetRangeModel.fromJson(e))
            .toList(),
      );
    } catch (e) {
      ErrorHelper.handleApiError(e);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> getCategories() async {
    try {
      final response = await LocatorService.othersService.getCategories(
        rethrowError: true,
      );
      LocatorService.others.setCategories(
        response['data']
            .map<CategoryModel>((e) => CategoryModel.fromJson(e))
            .toList(),
      );
    } catch (e) {
      ErrorHelper.handleApiError(e);
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
