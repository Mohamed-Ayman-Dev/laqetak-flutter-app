import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../di/locator_service.dart';
import '../themes/colors.dart';
import '../themes/text_styles.dart';
import 'buttons_widgets/app_elevated_button.dart';

class LoginFirstWidget extends StatelessWidget {
  const LoginFirstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 100).r,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.cardShadowColor,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).pleaseLogInFirstToViewTheContentOfThis,
                style: AppTextStyles.titleMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Text(
                S.of(context).youNeedToSignInToViewThisPageIf,
                textAlign: TextAlign.center,

                //fontChanged
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.bodyGreyTextColor,
                ),
              ),
              SizedBox(height: 20.h),
              AppElevatedButton(
                onPressed: () {
                  LocatorService.navigationService.currentState?.pushNamed(
                    LoginScreen.routeName,
                  );
                },
                text: S.of(context).logIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
