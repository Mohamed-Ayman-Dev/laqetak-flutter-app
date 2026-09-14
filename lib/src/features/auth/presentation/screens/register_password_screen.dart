import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/app_feedback.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/helpers/dialog_helpers.dart';
import 'package:invastro/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:invastro/src/features/auth/presentation/widgets/auth_appbar.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/widgets/agree_terms_widget.dart';
import '../../../../core/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_Text.dart';
import '../../../../core/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/widgets/fields_widgets/password_eye_toggle.dart';
import '../../../../core/widgets/label_widget.dart';
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
      if (_formData['agree_terms'] == false) {
        AppFeedback.showToast(
          S.of(context).pleaseAgreeToTheTermsAndConditions,
          isError: true,
        );
        return;
      }
      if (_formData['agree_idea'] == false) {
        AppFeedback.showToast(
          S.of(context).pleaseAgreeToTheIdea,
          isError: true,
        );
        return;
      }
      await context.read<AuthCubit>().register(_formData);
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
        padding: EdgeInsets.symmetric(horizontal: 16.0).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthAppbar(),
            24.heightSpace,
            CustomText(
              S.of(context).welcome,
              style: AppTextStyles.headlineMedium,
            ),
            15.heightSpace,
            CustomText(
              S.of(context).pleaseEnterYourDetails,
              style: AppTextStyles.headlineSmall,
            ),
            24.heightSpace,
            Form(
              key: _registerFormKey,
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
                  AgreeTermsWidget(
                    isChecked: _formData['agree_terms'],
                    onTermsPressed: () {
                      setState(() {
                        _formData['agree_terms'] = !(_formData['agree_terms']);
                      });
                    },
                    onTextPressed: () {
                      DialogHelpers.showTermsDialog();
                    },
                  ),
                  5.heightSpace,
                  AgreeTermsWidget(
                    isChecked: _formData['agree_idea'],
                    text: S.of(context).platformIdea,
                    onTermsPressed: () {
                      setState(() {
                        _formData['agree_idea'] = !(_formData['agree_idea']);
                      });
                    },
                    onTextPressed: () {
                      DialogHelpers.showTermsDialog(
                        title: S.of(context).platformIdea,
                        isIdea: true,
                      );
                    },
                  ),
                  24.heightSpace,
                  Hero(
                    tag: 'auth-button',
                    child: CustomElevatedButton(
                      text: S.current.next,
                      icon: SvgAssets.assetsSvgArrowRight,
                      onPressed: _register,
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
