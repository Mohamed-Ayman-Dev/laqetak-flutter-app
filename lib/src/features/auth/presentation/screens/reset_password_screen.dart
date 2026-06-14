import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/images_assets.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/svg_assets.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/shared/widgets/fields_widgets/password_eye_toggle.dart';
import '../../../../core/shared/widgets/label_widget.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_appbar.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset-password';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool hidePassword = true;
  bool hidePasswordConfirm = true;
  bool once = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  final GlobalKey<FormState> _resetPasswordFormKey = GlobalKey();
  final Map<String, dynamic> _formData = {};

  @override
  void didChangeDependencies() {
    if (!once) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        _formData['phone'] = args['phone'] ?? '';
        _formData['code'] = args['code'] ?? '';
      }
      once = true;
    }
    super.didChangeDependencies();
  }

  Future<void> _submit() async {
    if (_resetPasswordFormKey.currentState!.validate()) {
      _resetPasswordFormKey.currentState!.save();

      await AuthController.forgetPasswordReset(context, {
        'password': _formData['password'],
        'password_confirmation': _formData['password_confirmation'],
        'phone': _formData['phone'],
        'code': _formData['code'],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthAppbar(),
            24.heightSpace,
            Image.asset(
              ImagesAssets.assetsImagesResetPasswordImage,
              width: 158.w,
              height: 144.h,
            ),

            24.heightSpace,
            Form(
              key: _resetPasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelWidget(text: S.of(context).password),

                  CustomTextField(
                    hintText: S.of(context).enterPassword,
                    textInputAction: TextInputAction.done,
                    onSaved: (val) {
                      _formData['password'] = val;
                    },
                    validator: (value) {
                      return ValidationHelper.validatePassword(value, context);
                    },
                    controller: passwordController,

                    suffixIcon: EyeToggleIcon(
                      isHidden: hidePassword,
                      onToggle: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                    maxLines: 1,
                    obscureText: hidePassword,
                  ),
                  24.heightSpace,
                  LabelWidget(text: S.of(context).confirmPassword),

                  CustomTextField(
                    hintText: S.of(context).confirmPassword,
                    textInputAction: TextInputAction.done,
                    onSaved: (val) {
                      _formData['password_confirmation'] = val;
                    },
                    validator: (value) {
                      return ValidationHelper.validatePasswordConfirmation(
                        value,
                        passwordController.text,
                        context,
                      );
                    },

                    controller: passwordConfirmController,
                    suffixIcon: EyeToggleIcon(
                      isHidden: hidePasswordConfirm,
                      onToggle: () {
                        setState(() {
                          hidePasswordConfirm = !hidePasswordConfirm;
                        });
                      },
                    ),
                    maxLines: 1,
                    obscureText: hidePasswordConfirm,
                  ),
                  24.heightSpace,
                  Hero(
                    tag: 'auth-button',
                    child: CustomElevatedButton(
                      text: S.of(context).next,
                      icon: SvgAssets.assetsSvgArrowRight,

                      onPressed: _submit,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
