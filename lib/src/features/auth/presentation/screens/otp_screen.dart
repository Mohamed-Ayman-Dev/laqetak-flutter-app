import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/shared/models/redirect_model.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:invastro/src/features/auth/presentation/screens/register_screen.dart';
import 'package:invastro/src/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:invastro/src/features/home/presentation/screens/home_layout_screen.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/add_ad_pay_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_Text.dart';
import '../../../../core/shared/widgets/fields_widgets/pin_code_widget.dart';
import '../../../../core/themes/text_styles.dart';
import '../controllers/auth_controller.dart';
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
  String otp = '';
  late final OtpFlow _flow;
  late final RedirectModel? _redirectData;

  @override
  void didChangeDependencies() {
    if (!once) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      _flow = switch (arguments?['from']) {
        'register' => OtpFlow.register,
        'forgetPassword' => OtpFlow.forgetPassword,
        'updatePhone' => OtpFlow.updatePhone,
        'add-ad' => OtpFlow.addAd,
        _ => OtpFlow.login,
      };
      _redirectData = arguments?['redirectData'];

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        LocatorService.timers.startTimer(
          initialSeconds: _redirectData?.remainingSeconds ?? 119,
        );
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
                            _flow == OtpFlow.forgetPassword
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
                        text: _redirectData?.phone,
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
                    text: _flow == OtpFlow.forgetPassword
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
                  phone: _redirectData?.phone ?? '',
                  flow: _flow,
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
      switch (_flow) {
        case OtpFlow.register:
          await DialogHelpers.showSuccessDialog(
            title: 'تم التسجيل بنجاح',
            buttonText: 'تسجيل الدخول',
            onButtonTap: () {
              LocatorService.navigationService.currentState?.pushNamed(
                HomeLayoutScreen.routeName,
              );
            },
          )?.then(
            (value) => LocatorService.navigationService.currentState?.pushNamed(
              HomeLayoutScreen.routeName,
            ),
          );
          // Register OTP verification
          await AuthController.registerOtp(context, {
            'phone': _redirectData?.phone,
            'code': otp,
          }, isFromLogin: false);
          break;

        case OtpFlow.forgetPassword:
          // // Forget password OTP verification
          // await AuthController.forgetPasswordOtp(context, {
          //   'phone': phone,
          //   'code': otp,
          // });
          LocatorService.navigationService.currentState?.pushNamed(
            ResetPasswordScreen.routeName,
          );
          break;

        case OtpFlow.updatePhone:
          // changePhoneData?.addAll({'otp_code': otp});
          // await AuthController.updateProfile(context, changePhoneData ?? {});
          // LocatorService.navigationService.currentState?.popUntil(
          //   (route) => route.settings.name == HomeLayoutScreen.routeName,
          // );
          // LocatorService.appSettings.changeHomeIndex(0);
          break;
        case OtpFlow.addAd:
          LocatorService.navigationService.currentState?.pushNamed(
            AddAdPayScreen.routeName,
          );
          break;

        case OtpFlow.login:
          await DialogHelpers.showSuccessDialog(
            title: 'تهانينا لقد تم تسجيل حسابك بنجاح',
            onButtonTap: () {
              LocatorService.navigationService.currentState?.pushNamed(
                HomeLayoutScreen.routeName,
              );
            },
          )?.then(
            (value) => LocatorService.navigationService.currentState?.pushNamed(
              HomeLayoutScreen.routeName,
            ),
          );
          // // Login OTP verification (for non-activated accounts)
          // await AuthController.registerOtp(context, {
          //   'phone': phone,
          //   'code': otp,
          // }, isFromLogin: true);
          break;
      }
    } else {
      HapticFeedback.heavyImpact();
      LocatorService.authNavigations.setIsNotValid(true);
    }
  }
}
