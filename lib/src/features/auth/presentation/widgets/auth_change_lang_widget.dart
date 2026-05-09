import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/features/auth/presentation/screens/login_screen.dart';

import '../../../../core/helpers/others_helper.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_g_radio_button.dart';

class AuthChangeLangWidget extends StatefulWidget {
  const AuthChangeLangWidget({super.key});

  @override
  State<AuthChangeLangWidget> createState() => _AuthChangeLangWidgetState();
}

class _AuthChangeLangWidgetState extends State<AuthChangeLangWidget> {
  int groupValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      groupValue = value;
    });
  }

  @override
  void initState() {
    if (isArabic) {
      groupValue = 0;
    } else {
      groupValue = 1;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 40, 16, 50).r,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomGRadioButton(
            label: 'العربية',
            value: 0,
            groupValue: groupValue,
            onChanged: _handleRadioValueChange,
          ),
          Divider(indent: 25.w, endIndent: 25.w, height: 30.h),
          CustomGRadioButton(
            label: 'English',
            value: 1,
            groupValue: groupValue,
            onChanged: _handleRadioValueChange,
          ),
          25.heightSpace,
          Hero(
            tag: 'auth-button',
            child: CustomElevatedButton(
              text: 'تأكيد',
              onPressed: () {
                LocatorService.navigationService.currentState?.pushNamed(
                  LoginScreen.routeName,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
