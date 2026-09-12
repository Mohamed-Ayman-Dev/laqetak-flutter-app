import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/widgets/custom_direction_widget.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/home/presentation/screens/home_layout_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/widgets/buttons_widgets/custom_text_button.dart';
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
        padding: const EdgeInsets.only(top: 16, bottom: 24).r,
        child: Row(
          children: [
            if (showGuestButton)
              CustomTextButton(
                text: S.of(context).skip,
                onPressed: () {
                  LocatorService.navigationService.currentState?.pushNamed(
                    HomeLayoutScreen.routeName,
                  );
                },
                textColor: AppColors.primaryColor,
              ),
            Spacer(),
            if (LocatorService.navigationService.currentState!.canPop())
              CustomDirectionWidget(
                child: SvgButton(
                  icon: SvgAssets.assetsSvgArrowLeft,
                  onTap: () {
                    LocatorService.navigationService.currentState?.pop();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
