import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/constants/app_feedback.dart';
import 'package:laqetak/src/core/constants/images_assets.dart';
import 'package:laqetak/src/core/di/locator_service.dart';
import 'package:laqetak/src/core/helpers/dialog_helpers.dart';
import 'package:laqetak/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:laqetak/src/features/auth/presentation/cubit/auth_state.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/svg_assets.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/widgets/buttons/app_elevated_button.dart';
import '../../../../core/widgets/fields/custom_text_field.dart';
import '../../../../core/widgets/fields/password_eye_toggle.dart';
import '../../../../core/widgets/fields/label_widget.dart';
import '../widgets/auth_appbar.dart';
import 'login_screen.dart';

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

      await context.read<AuthCubit>().resetPassword({
        'password': _formData['password'],
        'password_confirmation': _formData['password_confirmation'],
        'phone': _formData['phone'],
        'code': _formData['code'],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.actionStatus != current.actionStatus &&
          current.lastMutation == AuthMutation.resetPassword,
      listener: _onResetPassword,
      child: Scaffold(
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
                      child: AppElevatedButton(
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
      ),
    );
  }

  void _onResetPassword(BuildContext context, AuthState authState) {
    if (ModalRoute.of(context)?.isCurrent != true) return;
    switch (authState.actionStatus) {
      case RequestStatus.loading:
        AppFeedback.loadingMessage();
      case RequestStatus.success:
        EasyLoading.dismiss();
        DialogHelpers.showSuccessDialog(
          title: S.current.passwordChangedSuccessfully,
          buttonText: S.current.login,
          onButtonTap: () {
            LocatorService.navigationService.currentState?.pop();
          },
        )?.then((_) {
          LocatorService.navigationService.currentState?.popUntil(
            (route) => route.settings.name == LoginScreen.routeName,
          );
        });
      case RequestStatus.error:
        AppFeedback.errorMessage(authState.errorMessage);
      case RequestStatus.initial:
        break;
    }
  }
}
