import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/images_assets.dart';
import 'package:invastro/src/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/svg_assets.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_Text.dart';
import '../../../../core/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/widgets/label_widget.dart';
import '../../../../core/themes/text_styles.dart';
import '../widgets/auth_appbar.dart';

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
  Map<String, dynamic> data = {};

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_forgetPasswordFormKey.currentState!.validate()) {
      await context.read<AuthCubit>().forgetPassword({
        'phone': _phoneController.text,
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
            CustomText(
              S.of(context).resetPassword,
              style: AppTextStyles.headlineMedium,
            ),
            15.heightSpace,
            CustomText(
              S.of(context).pleaseEnterYourMobileNumber,
              style: AppTextStyles.headlineSmall,
            ),
            24.heightSpace,
            Form(
              key: _forgetPasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelWidget(text: S.of(context).mobileNumber),
                  CustomTextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) {
                      return ValidationHelper.validatePhone(value, context);
                    },
                    // focusNode: _phoneFocusNode,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    controller: _phoneController,
                    hintText: S.of(context).mobileNumber,
                    // textDirection: TextDirection.ltr,
                    // suffixIcon: CountryCodeField(
                    //   focusNode: _phoneFocusNode,
                    //   onChanged: (val) {
                    //     data['country_code'] = val.toString();
                    //   },
                    //   onInit: (val) {
                    //     data['country_code'] = val.toString();
                    //   },
                    // ),
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
