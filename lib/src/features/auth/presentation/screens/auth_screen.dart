import 'package:flutter/material.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../shared/widgets/app_logo.dart';

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
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
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
                child: const AppLogo(),
              ),
              128.heightSpace,
              // const AuthChangeLangWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
