import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:invastro/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:invastro/src/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:invastro/src/features/auth/presentation/screens/register_screen.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/add_ad_second_screen.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/my_ads_screen.dart';
import 'package:invastro/src/features/profile/presentation/screens/profile_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/models/redirect_model.dart';
import '../../../../core/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_Text.dart';
import '../../../../core/widgets/fields_widgets/pin_code_widget.dart';
import '../../../../core/themes/text_styles.dart';
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
        LocatorService.timerCubit.startTimer(
          initialSeconds: _redirectData?.remainingSeconds ?? 119,
        );
      });
      once = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    LocatorService.timerCubit.stopTimer();
    LocatorService.authCubit.clearVerification();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16).r,
        child: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) =>
              previous.verificationErrorMessage !=
                  current.verificationErrorMessage ||
              previous.isNotValid != current.isNotValid,
          builder: (context, authState) {
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
                  key: LocatorService.authCubit.activationFormKey,
                  child: PinCodeWidget(
                    onSaved: (checkCode) {
                      setState(() {
                        otp = checkCode!;
                      });
                    },
                    isNotValid: authState.isNotValid,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseEnterVerificationCode;
                      } else if (value.length < 4) {
                        return S.of(context).pleaseEnterThe4digitCode;
                      } else if (authState.verificationErrorMessage != null) {
                        return authState.verificationErrorMessage;
                      } else {
                        return null;
                      }
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
                      _onSubmit(LocatorService.authCubit.activationFormKey);
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
    final cubit = context.read<AuthCubit>();
    cubit.clearVerification();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      cubit.setIsNotValid(false);
      switch (_flow) {
        case OtpFlow.register:
          await cubit.registerOtp({'phone': _redirectData?.phone, 'code': otp});
          break;

        case OtpFlow.forgetPassword:
          await cubit.forgetPasswordOtp({
            'phone': _redirectData?.phone,
            'code': otp,
          });
          break;

        case OtpFlow.updatePhone:
          _argsFormData?['phone_otp'] = int.tryParse(otp);
          cubit.updateProfile(
            _argsFormData!,
            hasMultipartData: _argsFormData?['avatar'] != null,
          );
          break;
        case OtpFlow.addAd:
          _argsFormData?['contact_phone_otp'] = int.tryParse(otp);
          LocatorService.myAdsCubit.addAd(_argsFormData);
          break;
        case OtpFlow.editAd:
          _argsFormData?['contact_phone_otp'] = int.tryParse(otp);
          LocatorService.myAdsCubit.editAd(_argsFormData);
          break;
        case OtpFlow.login:
          await cubit.registerOtp({'phone': _redirectData?.phone, 'code': otp});
          break;
      }
    } else {
      HapticFeedback.heavyImpact();
      cubit.setIsNotValid(true);
    }
  }
}
