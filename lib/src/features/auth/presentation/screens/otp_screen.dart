import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  static const routeName = '/otp';

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  // bool once = false;
  // bool isRegisterOTP = false;
  // bool isForgetPassword = false;
  // bool isUpdatePhone = false;
  //
  // int? remainingSeconds;
  // String otp = '';
  // String phone = '';
  // Map<String, dynamic>? changePhoneData;
  //
  // String? previousScreenName;
  //
  // @override
  // void didChangeDependencies() {
  //   if (!once) {
  //     final arguments =
  //         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
  //     if (arguments?['from'] != null) {
  //       previousScreenName = arguments?['from'];
  //       isRegisterOTP = arguments?['from'] == 'register';
  //       isForgetPassword = arguments?['from'] == 'forgetPassword';
  //       isUpdatePhone = arguments?['from'] == 'updatePhone';
  //       changePhoneData = arguments?['data'];
  //       if (arguments?['remainingSeconds'] != null) {
  //         remainingSeconds = arguments?['remainingSeconds'];
  //       }
  //       phone = arguments?['phone'] ?? '';
  //     }
  //
  //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //       LocatorService.timers.startTimer(initialSeconds: remainingSeconds);
  //     });
  //     once = true;
  //   }
  //   super.didChangeDependencies();
  // }
  //
  // @override
  // void dispose() {
  //   LocatorService.timers.stopTimer();
  //   LocatorService.authNavigations.activationFormKey.currentState?.dispose();
  //   LocatorService.authNavigations.wrongVerificationError = null;
  //   LocatorService.authNavigations.isNotValid = false;
  //   super.dispose();
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: CustomAppbar(icons: []),
  //     body: SingleChildScrollView(
  //       padding: EdgeInsets.symmetric(horizontal: 16).r,
  //       child: Consumer<AuthNavigations>(
  //         builder: (context, navigationsProvider, child) {
  //           return Column(
  //             children: [
  //               24.heightSpace,
  //               Image.asset(
  //                 'assets/images/otp_image.png',
  //                 height: 172.h,
  //                 width: 172.w,
  //               ),
  //               32.heightSpace,
  //               Text(
  //                 isForgetPassword
  //                     ? S.of(context).verifyYourIdentity
  //                     : isRegisterOTP
  //                     ? S.of(context).verifyYourPhoneNumber
  //                     : S.of(context).continueToSignIn,
  //                 style: AppTextStyles.labelMedium.copyWith(fontSize: 24.sp),
  //               ),
  //               16.heightSpace,
  //               RichText(
  //                 textAlign: TextAlign.center,
  //                 text: TextSpan(
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     fontFamily: 'Almarai',
  //                     color: Colors.black,
  //                   ),
  //                   children: [
  //                     TextSpan(
  //                       text: S.of(context).enterTheVerificationCodeWeSentTo,
  //                       style: AppTextStyles.labelSmall.copyWith(
  //                         fontSize: 16.sp,
  //                       ),
  //                     ),
  //                     TextSpan(
  //                       text: isForgetPassword
  //                           ? " ${S.of(context).yourPhoneNumber} "
  //                           : '$phone ',
  //                       style: TextStyle(fontWeight: FontWeight.bold),
  //                     ),
  //
  //                     TextSpan(
  //                       text: isForgetPassword
  //                           ? S.of(context).toContinueResettingYourPassword
  //                           : isRegisterOTP
  //                           ? S.of(context).toCompleteYourAccountCreation
  //                           : S.of(context).toSignIn,
  //                       style: AppTextStyles.labelSmall.copyWith(
  //                         fontSize: 16.sp,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               24.heightSpace,
  //               Form(
  //                 key: LocatorService.authNavigations.activationFormKey,
  //                 child: Selector<AuthNavigations, String?>(
  //                   selector: (context, provider) =>
  //                       provider.wrongVerificationError,
  //                   builder: (context, wrongVerificationError, child) {
  //                     return PinCodeWidget(
  //                       onSaved: (checkCode) {
  //                         setState(() {
  //                           otp = checkCode!;
  //                         });
  //                       },
  //                       isNotValid: navigationsProvider.isNotValid,
  //                       validator: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return S.of(context).pleaseEnterVerificationCode;
  //                         } else if (value.length < 4) {
  //                           return 'S.of(context).pleaseEnter4DigitCode';
  //                         } else if (wrongVerificationError != null) {
  //                           return wrongVerificationError;
  //                         }
  //                         // else if (value !=
  //                         //     (navigationsProvider.newCode ??
  //                         //         code.toString())) {
  //                         //   return S.of(context).wrongVerificationCode;
  //                         // }
  //                         else {
  //                           return null; // No error
  //                         }
  //                       },
  //                     );
  //                   },
  //                 ),
  //               ),
  //               24.heightSpace,
  //               Text(
  //                 S.of(context).didntReceiveTheCode,
  //                 style: AppTextStyles.labelSmall.copyWith(
  //                   fontSize: 12.sp,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //               4.heightSpace,
  //               TimerResendWidget(
  //                 phone: phone,
  //                 previousScreenName: previousScreenName ?? 'register',
  //               ),
  //               71.heightSpace,
  //               Hero(
  //                 tag: 'IntroButton',
  //                 child: CustomElevatedButton(
  //                   text: isForgetPassword
  //                       ? S.of(context).verify
  //                       : S.of(context).confirm,
  //                   onPressed: () {
  //                     _onSubmit(
  //                       LocatorService.authNavigations.activationFormKey,
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
  //
  // Future<void> _onSubmit(GlobalKey<FormState> formKey) async {
  //   LocatorService.authNavigations.wrongVerificationError = null;
  //   LocatorService.authNavigations.isNotValid = false;
  //   if (formKey.currentState!.validate()) {
  //     formKey.currentState!.save();
  //     LocatorService.authNavigations.setIsNotValid(false);
  //
  //     if (isRegisterOTP) {
  //       // Register OTP verification
  //       await AuthController.registerOtp(context, {
  //         'phone': phone,
  //         'code': otp,
  //       }, isFromLogin: false);
  //     } else if (isForgetPassword) {
  //       // Forget password OTP verification
  //       await AuthController.forgetPasswordOtp(context, {
  //         'phone': phone,
  //         'code': otp,
  //       });
  //     } else if (isUpdatePhone) {
  //       changePhoneData?.addAll({'otp_code': otp});
  //       await AuthController.updateProfile(context, changePhoneData ?? {});
  //       LocatorService.navigationService.currentState?.popUntil(
  //         (route) => route.settings.name == HomeLayoutScreen.routeName,
  //       );
  //       LocatorService.appSettings.changeHomeIndex(0);
  //     } else {
  //       // Login OTP verification (for non-activated accounts)
  //       await AuthController.registerOtp(context, {
  //         'phone': phone,
  //         'code': otp,
  //       }, isFromLogin: true);
  //     }
  //   } else {
  //     HapticFeedback.heavyImpact();
  //     LocatorService.authNavigations.setIsNotValid(true);
  //   }
  // }
}
