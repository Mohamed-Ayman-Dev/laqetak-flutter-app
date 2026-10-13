import 'package:flutter/material.dart';
import 'package:laqetak/src/core/constants/images_assets.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/widgets/app_logo.dart';
import '../widgets/auth_change_lang_widget.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth_screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool pressedLong = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,

        child: Stack(
          children: [
            Image.asset(
              ImagesAssets.assetsImagesSplashImage,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onDoubleTap: () {
                    if (pressedLong) {
                      // AlertUtils.showPassDialog(context, formKey);
                      pressedLong = false;
                    }
                  },
                  onLongPressUp: () {
                    pressedLong = true;
                  },
                  child: const AppLogo(tag: 'splash-tag'),
                ),
                202.heightSpace,
                const AuthChangeLangWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
