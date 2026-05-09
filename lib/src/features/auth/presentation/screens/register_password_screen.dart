import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/features/auth/presentation/screens/otp_screen.dart';
import 'package:invastro/src/features/auth/presentation/widgets/auth_appbar.dart';

import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/agree_terms_widget.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_Text.dart';
import '../../../../core/shared/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/shared/widgets/fields_widgets/password_eye_toggle.dart';
import '../../../../core/shared/widgets/label_widget.dart';
import '../../../../core/themes/text_styles.dart';

class RegisterPasswordScreen extends StatefulWidget {
  static const routeName = '/register_password_screen';

  const RegisterPasswordScreen({super.key});

  @override
  State<RegisterPasswordScreen> createState() => _RegisterPasswordScreenState();
}

class _RegisterPasswordScreenState extends State<RegisterPasswordScreen> {
  bool once = false;
  bool hidePassword = true;
  bool hidePasswordConfirm = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  Map<String, dynamic> _formData = {'agree_terms': false, 'agree_idea': false};
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  Future<void> _register() async {
    if (_registerFormKey.currentState!.validate()) {
      _registerFormKey.currentState!.save();
      LocatorService.navigationService.currentState?.pushNamed(
        OtpScreen.routeName,
      );
      // await AuthController.register(context, _formData);
    }
  }

  @override
  void dispose() {
    passwordConfirmController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (!once) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        _formData = {..._formData, ...args};
      }
      once = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthAppbar(showGuestButton: true),
            24.heightSpace,
            CustomText('مرحبـــــاً', style: AppTextStyles.headlineMedium),
            15.heightSpace,
            CustomText(
              'الرجاء إدخال ادخل بياناتك',
              style: AppTextStyles.headlineSmall,
            ),
            24.heightSpace,
            Form(
              key: _registerFormKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelWidget(text: 'كلمة المرور'),

                    CustomTextField(
                      hintText: 'أدخل كلمة المرور',
                      textInputAction: TextInputAction.done,
                      onSaved: (val) {
                        _formData['password'] = val;
                      },
                      validator: (value) {
                        return ValidationHelper.validatePassword(
                          value,
                          context,
                        );
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
                    LabelWidget(text: 'تأكيد كلمة المرور'),

                    CustomTextField(
                      hintText: 'تأكيد كلمة المرور',
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
                    AgreeTermsWidget(
                      isChecked: _formData['agree_terms'],
                      onTermsPressed: () {
                        setState(() {
                          _formData['agree_terms'] =
                              !(_formData['agree_terms']);
                        });
                      },
                    ),
                    24.heightSpace,
                    AgreeTermsWidget(
                      isChecked: _formData['agree_idea'],
                      text: 'فكرة المنصة',
                      onTermsPressed: () {
                        setState(() {
                          _formData['agree_idea'] = !(_formData['agree_idea']);
                        });
                      },
                    ),
                    24.heightSpace,
                    Hero(
                      tag: 'auth-button',
                      child: CustomElevatedButton(
                        text: "التالي",
                        icon: SvgAssets.assetsSvgArrowRight,
                        onPressed: _register,
                      ),
                    ),
                    64.heightSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
