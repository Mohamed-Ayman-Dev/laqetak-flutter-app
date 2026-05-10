import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/features/auth/presentation/screens/register_screen.dart';
import 'package:invastro/src/features/auth/presentation/widgets/auth_appbar.dart';

import '../../../../core/di/locator_service.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_text_button.dart';
import '../../../../core/shared/widgets/custom_Text.dart';
import '../../../../core/shared/widgets/fields_widgets/country_code_field.dart';
import '../../../../core/shared/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/shared/widgets/fields_widgets/password_eye_toggle.dart';
import '../../../../core/shared/widgets/label_widget.dart';
import '../../../../core/themes/text_styles.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;

  Future<void> _login() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      // await AuthController.login(context, data);
    }
  }

  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {'country_code': '+966'};
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthAppbar(showGuestButton: true),
            24.heightSpace,
            CustomText('مرحبـــــاً', style: AppTextStyles.headlineMedium),
            15.heightSpace,
            CustomText(
              'الرجاء إدخال  رقم الجوال وكلمة المرور',
              style: AppTextStyles.headlineSmall,
            ),
            24.heightSpace,
            Form(
              key: _loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelWidget(text: 'رقم الجوال'),
                  CustomTextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    onSaved: (val) {
                      data['phone'] = val;
                    },
                    validator: (value) {
                      return ValidationHelper.validatePhoneByCountryCode(
                        phone: value,
                        countryCode: data['country_code'],
                        context: context,
                      );
                    },
                    focusNode: _phoneFocusNode,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    controller: _phoneController,
                    hintText: "رقم الجوال",
                    // textDirection: TextDirection.ltr,
                    suffixIcon: CountryCodeField(
                      focusNode: _phoneFocusNode,
                      onChanged: (val) {
                        data['country_code'] = val.toString();
                      },
                      onInit: (val) {
                        data['country_code'] = val.toString();
                      },
                    ),
                  ),
                  24.heightSpace,
                  LabelWidget(text: 'كلمة المرور'),

                  CustomTextField(
                    hintText: 'أدخل كلمة المرور',
                    textInputAction: TextInputAction.done,
                    onSaved: (val) {
                      data['password'] = val;
                    },
                    validator: (value) {
                      return ValidationHelper.validatePassword(value, context);
                    },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextButton(
                        text: 'نسيت كلمة المرور ؟',
                        onPressed: () {
                          LocatorService.navigationService.currentState
                              ?.pushNamed(ForgetPasswordScreen.routeName);
                        },
                      ),
                    ],
                  ),
                  24.heightSpace,
                  Hero(
                    tag: 'auth-button',
                    child: CustomElevatedButton(
                      text: "دخول",
                      onPressed: _login,
                    ),
                  ),
                  16.heightSpace,
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "ليس لديك حساب ؟ ",
                        style: AppTextStyles.labelSmall,
                        children: [
                          TextSpan(
                            text: "سجل الأن !",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                LocatorService.navigationService.currentState
                                    ?.pushNamed(RegisterScreen.routeName);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  64.heightSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
