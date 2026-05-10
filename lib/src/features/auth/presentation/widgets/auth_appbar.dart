import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/home/presentation/screens/home_layout_screen.dart';

import '../../../../core/di/locator_service.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_text_button.dart';
import '../../../../core/shared/widgets/buttons_widgets/svg_button.dart';

class AuthAppbar extends StatelessWidget {
  final bool showGuestButton;

  const AuthAppbar({super.key, this.showGuestButton = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 24).r,
        child: Row(
          children: [
            if (showGuestButton)
              CustomTextButton(
                text: 'تخطي',
                onPressed: () {
                  LocatorService.navigationService.currentState?.pushNamed(
                    HomeLayoutScreen.routeName,
                  );
                },
                textColor: AppColors.primaryColor,
              ),
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
