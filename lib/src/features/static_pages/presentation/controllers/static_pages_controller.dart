import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:invastro/src/core/error/error_helper.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/helpers/dialog_helpers.dart';

class StaticPagesController {
  static Future<void> sendContactUs(Map<String, dynamic> data) async {
    try {
      EasyLoading.show(status: S.current.pleaseWait);
      await LocatorService.staticPagesService.sendContactUs(
        data,
        rethrowError: true,
      );
      EasyLoading.dismiss();
      DialogHelpers.showSuccessDialog(title: 'تم ارسال رسالتك بنجاح');
    } catch (e) {
      ErrorHelper.handleApiError(e);
    }
  }
}
