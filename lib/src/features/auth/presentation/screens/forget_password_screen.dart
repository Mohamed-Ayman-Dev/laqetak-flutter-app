import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/images_assets.dart';

import '../../../../core/constants/svg_assets.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_Text.dart';
import '../../../../core/shared/widgets/fields_widgets/country_code_field.dart';
import '../../../../core/shared/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/shared/widgets/label_widget.dart';
import '../../../../core/themes/text_styles.dart';
import '../widgets/auth_appbar.dart';
import 'otp_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/forget-password';

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final FocusNode _phoneFocusNode = FocusNode();
  final GlobalKey<FormState> _forgetPasswordFormKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();
  Map<String, dynamic> data = {'country_code': '+966'};

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_forgetPasswordFormKey.currentState!.validate()) {
      // await AuthController.forgetPassword(context, {
      //   'phone': _phoneController.text,
      // });
      LocatorService.navigationService.currentState?.pushNamed(
        OtpScreen.routeName,
        arguments: {
          'phone': data['phone'],
          'from': 'forgetPassword',
          'remainingSeconds': 120,
        },
      );
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
            CustomText(
              'إستعاده كلمة المرور',
              style: AppTextStyles.headlineMedium,
            ),
            15.heightSpace,
            CustomText(
              'الرجاء إدخال رقم هاتفك الجوال',
              style: AppTextStyles.headlineSmall,
            ),
            24.heightSpace,
            Form(
              key: _forgetPasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelWidget(text: 'رقم الجوال'),
                  CustomTextField(
                    onChanged: (value) {
                      setState(() {});
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
                  Hero(
                    tag: 'auth-button',
                    child: CustomElevatedButton(
                      text: "التالي",
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
