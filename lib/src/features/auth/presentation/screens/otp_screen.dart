import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/shared/models/redirect_model.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:invastro/src/features/auth/presentation/screens/register_screen.dart';
import 'package:invastro/src/features/my_ads/presentation/controllers/my_ads_controller.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/add_ad_second_screen.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/my_ads_screen.dart';
import 'package:invastro/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/extension/space_extensions_helper.dart';
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
  Map<String, dynamic>? _argsFormData;

  @override
  void didChangeDependencies() {
    if (!once) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      _flow = arguments?['from'];
      _redirectData = arguments?['redirectData'];
      _argsFormData = arguments?['data'];

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
                  S.of(context).verifyYourMobileNumber,
                  style: AppTextStyles.headlineMedium,
                ),
                16.heightSpace,
                CustomText(
                  S.of(context).pleaseEnterTheVerificationCodeSentTo,
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
                                : _flow == OtpFlow.addAd
                                ? LocatorService.navigationService.currentState
                                      ?.popUntil(
                                        (route) =>
                                            route.settings.name ==
                                            AddAdSecondScreen.routeName,
                                      )
                                : _flow == OtpFlow.editAd
                                ? LocatorService.navigationService.currentState
                                      ?.popUntil(
                                        (route) =>
                                            route.settings.name ==
                                            MyAdsScreen.routeName,
                                      )
                                : _flow == OtpFlow.updatePhone
                                ? LocatorService.navigationService.currentState
                                      ?.popUntil(
                                        (route) =>
                                            route.settings.name ==
                                            ProfileScreen.routeName,
                                      )
                                : LocatorService.navigationService.currentState
                                      ?.popUntil(
                                        (route) =>
                                            route.settings.name ==
                                            RegisterScreen.routeName,
                                      );
                          },
                          child: Text(
                            S.of(context).changeNumber,
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
                            return S.of(context).pleaseEnterThe4digitCode;
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
                  argsFormData: _argsFormData,
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
          // Register OTP verification
          await AuthController.registerOtp(context, {
            'phone': _redirectData?.phone,
            'code': otp,
          }, isFromLogin: false);
          break;

        case OtpFlow.forgetPassword:
          // Forget password OTP verification
          await AuthController.forgetPasswordOtp(context, {
            'phone': _redirectData?.phone,
            'code': otp,
          });
          break;

        case OtpFlow.updatePhone:
          _argsFormData?['phone_otp'] = int.tryParse(otp);
          AuthController.updateProfile(
            context,
            _argsFormData!,
            hasMultipartData: _argsFormData?['avatar'] != null,
          );
          break;
        case OtpFlow.addAd:
          _argsFormData?['contact_phone_otp'] = int.tryParse(otp);
          MyAdsController.addAd(_argsFormData);
          break;
        case OtpFlow.editAd:
          _argsFormData?['contact_phone_otp'] = int.tryParse(otp);
          MyAdsController.editAd(_argsFormData);
          break;
        case OtpFlow.login:
          // // Login OTP verification (for non-activated accounts)
          await AuthController.registerOtp(context, {
            'phone': _redirectData?.phone,
            'code': otp,
          }, isFromLogin: true);
          break;
      }
    } else {
      HapticFeedback.heavyImpact();
      LocatorService.authNavigations.setIsNotValid(true);
    }
  }
}
