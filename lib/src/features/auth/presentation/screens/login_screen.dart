import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:laqetak/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:laqetak/src/features/auth/presentation/screens/register_screen.dart';
import 'package:laqetak/src/features/auth/presentation/widgets/auth_appbar.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app_feedback.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../core/widgets/buttons_widgets/app_elevated_button.dart';
import '../../../../core/widgets/buttons_widgets/app_text_button.dart';
import '../../../../core/widgets/custom_Text.dart';
import '../../../../core/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/widgets/fields_widgets/password_eye_toggle.dart';
import '../../../../core/widgets/label_widget.dart';
import '../../../home/presentation/screens/home_layout_screen.dart';
import 'forget_password_screen.dart';
import 'otp_screen.dart';

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
      await context.read<AuthCubit>().login(data);
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
  final _loginFormKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {
    // 'country_code': '+966'
  };
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.actionStatus != current.actionStatus &&
          current.lastMutation == AuthMutation.login,
      listener: _onLogin,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthAppbar(showGuestButton: true),
              24.heightSpace,
              CustomText(
                S.of(context).welcome,
                style: AppTextStyles.headlineMedium,
              ),

              15.heightSpace,
              CustomText(
                S.of(context).pleaseEnterYourMobileNumberAndPassword,
                style: AppTextStyles.headlineSmall,
              ),
              24.heightSpace,
              Form(
                key: _loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelWidget(text: S.of(context).mobileNumber),
                    CustomTextField(
                      onSaved: (val) {
                        data['phone'] = val;
                      },
                      validator: (value) {
                        return ValidationHelper.validatePhone(value, context);
                      },
                      // focusNode: _phoneFocusNode,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      controller: _phoneController,
                      hintText: S.of(context).mobileNumber,
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
                    LabelWidget(text: S.of(context).password),
                    CustomTextField(
                      hintText: S.of(context).enterPassword,
                      textInputAction: TextInputAction.done,
                      onSaved: (val) {
                        data['password'] = val;
                      },
                      validator: (value) {
                        return ValidationHelper.validatePassword(
                          value,
                          context,
                        );
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
                        AppTextButton(
                          text: S.of(context).forgotPassword,
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
                      child: AppElevatedButton(
                        text: S.of(context).login,
                        onPressed: _login,
                      ),
                    ),
                    16.heightSpace,
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: S.of(context).dontHaveAnAccount,
                          style: AppTextStyles.labelSmall,
                          children: [
                            TextSpan(
                              text: " ${S.of(context).registerNow}",
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
      ),
    );
  }

  void _onLogin(BuildContext context, AuthState authState) {
    if (ModalRoute.of(context)?.isCurrent != true) return;
    switch (authState.actionStatus) {
      case RequestStatus.loading:
        if (authState.otpResent) return;
        AppFeedback.loadingMessage();
      case RequestStatus.success:
        EasyLoading.dismiss();
        if (authState.otpResent) {
          AppFeedback.showToast(
            S.current.verificationCodeHasBeenSentToYourPhone,
          );
        } else if (authState.otpRedirect != null) {
          AppFeedback.showToast(S.current.pleaseVerifyYourPhoneNumber);
          LocatorService.navigationService.currentState?.pushNamed(
            OtpScreen.routeName,
            arguments: {
              'redirectData': authState.otpRedirect,
              'data': authState.otpFormData,
              'from': OtpFlow.login,
            },
          );
        } else {
          LocatorService.navigationService.currentState
              ?.pushNamedAndRemoveUntil(
                HomeLayoutScreen.routeName,
                (route) => false,
              );
          if (LocatorService.settingsCubit.state.homeIndex != 0) {
            LocatorService.settingsCubit.changeHomeIndex(0);
          }
        }
      case RequestStatus.error:
        AppFeedback.errorMessage(authState.errorMessage);
      case RequestStatus.initial:
        break;
    }
  }
}
