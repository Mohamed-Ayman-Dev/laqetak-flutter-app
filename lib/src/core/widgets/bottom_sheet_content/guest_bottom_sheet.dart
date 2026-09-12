import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/l10n.dart';
import '../../../features/auth/presentation/screens/login_screen.dart';
import '../../di/locator_service.dart';
import '../../themes/text_styles.dart';
import '../buttons_widgets/custom_elevated_button.dart';

class GuestBottom extends StatefulWidget {
  const GuestBottom({super.key});

  @override
  State<GuestBottom> createState() => _GuestBottomState();
}

class _GuestBottomState extends State<GuestBottom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: const AlignmentDirectional(-0.9, -0.9),
        children: [
          Container(
            height: 260.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(top: 20, bottom: 20).r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  S.of(context).loginToContinue,
                  style: AppTextStyles.titleMedium,
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    S.of(context).byLoggingInYouCanAccessAllTheFeaturesOf,
                    style: AppTextStyles.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 45.h),
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    LocatorService.navigationService.currentState?.pushNamed(
                      LoginScreen.routeName,
                    );
                  },
                  text: S.of(context).logIn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
