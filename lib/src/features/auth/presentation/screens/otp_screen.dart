import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:invastro/src/features/auth/presentation/screens/register_screen.dart';
import 'package:invastro/src/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_Text.dart';
import '../../../../core/shared/widgets/fields_widgets/pin_code_widget.dart';
import '../../../../core/themes/text_styles.dart';
import '../providers/auth_naviagtions.dart';
import '../widgets/auth_appbar.dart';
import '../widgets/timer_resend_widget.dart';

class OtpScreen extends StatefulWidget {
  static const routeName = '/otp';

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool once = false;
  bool isRegisterOTP = false;
  bool isForgetPassword = false;
  bool isUpdatePhone = false;

  int? remainingSeconds;
  String otp = '';
  String phone = '';
  Map<String, dynamic>? changePhoneData;

  String? previousScreenName;

  @override
  void didChangeDependencies() {
    if (!once) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (arguments?['from'] != null) {
        previousScreenName = arguments?['from'];
        isRegisterOTP = arguments?['from'] == 'register';
        isForgetPassword = arguments?['from'] == 'forgetPassword';
        isUpdatePhone = arguments?['from'] == 'updatePhone';
        changePhoneData = arguments?['data'];
        if (arguments?['remainingSeconds'] != null) {
          remainingSeconds = arguments?['remainingSeconds'];
        }
        phone = arguments?['phone'] ?? '';
      }

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        LocatorService.timers.startTimer(initialSeconds: remainingSeconds);
      });
      once = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    LocatorService.timers.stopTimer();
    LocatorService.authNavigations.activationFormKey.currentState?.dispose();
    LocatorService.authNavigations.wrongVerificationError = null;
    LocatorService.authNavigations.isNotValid = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16).r,
        child: Consumer<AuthNavigations>(
          builder: (context, navigationsProvider, child) {
            return Column(
              children: [
                AuthAppbar(),
                18.heightSpace,
                CustomText(
                  'تحقق من رقم هاتفك المحمول',
                  style: AppTextStyles.headlineMedium,
                ),
                16.heightSpace,
                CustomText(
                  'الرجاء إدخال رمز التحقق المرسل إلى',
                  style: AppTextStyles.headlineSmall,
                ),
                16.heightSpace,
                RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            isForgetPassword
                                ? LocatorService.navigationService.currentState
                                      ?.popUntil(
                                        (route) =>
                                            route.settings.name ==
                                            ForgetPasswordScreen.routeName,
                                      )
                                : LocatorService.navigationService.currentState
                                      ?.popUntil(
                                        (route) =>
                                            route.settings.name ==
                                            RegisterScreen.routeName,
                                      );
                          },
                          child: Text(
                            'تغيير الرقم',
                            style: AppTextStyles.headlineMedium.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: '  |  ',
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      TextSpan(
                        text: "096600000000+",
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.labelTextColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                24.heightSpace,
                Form(
                  key: LocatorService.authNavigations.activationFormKey,
                  child: Selector<AuthNavigations, String?>(
                    selector: (context, provider) =>
                        provider.wrongVerificationError,
                    builder: (context, wrongVerificationError, child) {
                      return PinCodeWidget(
                        onSaved: (checkCode) {
                          setState(() {
                            otp = checkCode!;
                          });
                        },
                        isNotValid: navigationsProvider.isNotValid,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).pleaseEnterVerificationCode;
                          } else if (value.length < 4) {
                            return 'S.of(context).pleaseEnter4DigitCode';
                          } else if (wrongVerificationError != null) {
                            return wrongVerificationError;
                          }
                          // else if (value !=
                          //     (navigationsProvider.newCode ??
                          //         code.toString())) {
                          //   return S.of(context).wrongVerificationCode;
                          // }
                          else {
                            return null; // No error
                          }
                        },
                      );
                    },
                  ),
                ),
                15.heightSpace,
                Hero(
                  tag: 'auth-button',
                  child: CustomElevatedButton(
                    text: isForgetPassword
                        ? S.of(context).verify
                        : S.of(context).confirm,
                    onPressed: () {
                      _onSubmit(
                        LocatorService.authNavigations.activationFormKey,
                      );
                    },
                  ),
                ),
                24.heightSpace,
                TimerResendWidget(
                  phone: phone,
                  previousScreenName: previousScreenName ?? 'register',
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _onSubmit(GlobalKey<FormState> formKey) async {
    LocatorService.authNavigations.wrongVerificationError = null;
    LocatorService.authNavigations.isNotValid = false;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      LocatorService.authNavigations.setIsNotValid(false);

      if (isRegisterOTP) {
        // // Register OTP verification
        // await AuthController.registerOtp(context, {
        //   'phone': phone,
        //   'code': otp,
        // }, isFromLogin: false);
      } else if (isForgetPassword) {
        // // Forget password OTP verification
        // await AuthController.forgetPasswordOtp(context, {
        //   'phone': phone,
        //   'code': otp,
        // });
        LocatorService.navigationService.currentState?.pushNamed(
          ResetPasswordScreen.routeName,
        );
      } else if (isUpdatePhone) {
        // changePhoneData?.addAll({'otp_code': otp});
        // await AuthController.updateProfile(context, changePhoneData ?? {});
        // LocatorService.navigationService.currentState?.popUntil(
        //   (route) => route.settings.name == HomeLayoutScreen.routeName,
        // );
        // LocatorService.appSettings.changeHomeIndex(0);
      } else {
        // // Login OTP verification (for non-activated accounts)
        // await AuthController.registerOtp(context, {
        //   'phone': phone,
        //   'code': otp,
        // }, isFromLogin: true);
      }
    } else {
      HapticFeedback.heavyImpact();
      LocatorService.authNavigations.setIsNotValid(true);
    }
  }
}
