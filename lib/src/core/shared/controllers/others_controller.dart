import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:invastro/src/core/error/error_helper.dart';

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

  static Future<void> getRegions() async {
    // try {
    //   final response = await LocatorService.addressService.getRegions(
    //     rethrowError: true,
    //   );
    //   LocatorService.addresses.setRegions(
    //     response['data']
    //         .map<DetailsModel>((e) => DetailsModel.fromJson(e))
    //         .toList(),
    //   );
    // } catch (e) {
    //   ApiService.handleApiError(e);
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // }
  }
}
