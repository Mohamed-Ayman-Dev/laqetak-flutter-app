import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';

import '../../../../core/di/locator_service.dart';
import '../../../../core/widgets/buttons_widgets/svg_button.dart';

class AuthAppbar extends StatelessWidget {
  final bool showGuestButton;

  const AuthAppbar({super.key, this.showGuestButton = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 16).r,
        child: Row(
          children: [
            Spacer(),

            SvgButton(
              icon: SvgAssets.assetsSvgArrowLeft,
              onTap: () {
                LocatorService.navigationService.currentState?.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
