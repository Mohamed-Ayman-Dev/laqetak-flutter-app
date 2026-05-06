import 'package:flutter/material.dart';

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
      // await AuthController.login(context, data);
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
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {
    // 'country_code': '+966'
  };
  bool pressedLong = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      // appBar: CustomAppbar(
      //   icons: [AppbarIcons.lang, AppbarIcons.guest],
      //   dontShowBackButton: true,
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 37.heightSpace,
            // GestureDetector(
            //   behavior: HitTestBehavior.translucent,
            //   onDoubleTap: () async {
            //     if (pressedLong) {
            //       AlertUtils.showPassDialog(context, formKey);
            //       pressedLong = false;
            //     }
            //   },
            //   onLongPressUp: () {
            //     pressedLong = true;
            //   },
            //   child: AppLogo(
            //     width: isTablet ? 100.w : 118.w,
            //     height: isTablet ? 110.w : 123.h,
            //   ),
            // ),
            // 32.heightSpace,
            // Text(
            //   S.current.logIn,
            //   style: AppTextStyles.titleMedium.copyWith(fontSize: 24.sp),
            // ),
            // 64.heightSpace,
            // Form(
            //   key: _loginFormKey,
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 16.0).r,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           S.current.emailOrMobileNumberOrUsername,
            //           style: AppTextStyles.labelMedium.copyWith(
            //             fontSize: 14.sp,
            //           ),
            //         ),
            //         8.heightSpace,
            //         CustomTextField(
            //           onChanged: (value) {
            //             setState(() {});
            //           },
            //           onSaved: (val) {
            //             data['phone'] = val;
            //           },
            //           validator: (value) {
            //             return ValidationHelper.validateEmpty(
            //               value,
            //               emptyMessage: S
            //                   .of(context)
            //                   .phoneNumberEmailOrUsernameRequired,
            //             );
            //           },
            //           focusNode: _phoneFocusNode,
            //
            //           keyboardType: TextInputType.emailAddress,
            //           textInputAction: TextInputAction.next,
            //           controller: _phoneController,
            //           hintText: S.current.enterYourLoginDetails,
            //           // textDirection: TextDirection.ltr,
            //           // prefix: CountryCodeField(
            //           //   focusNode: _phoneFocusNode,
            //           //   onChanged: (val) {
            //           //     data['country_code'] = val.toString();
            //           //   },
            //           //   onInit: (val) {
            //           //     data['country_code'] = val.toString();
            //           //   },
            //           // ),
            //         ),
            //         24.heightSpace,
            //         Text(
            //           S.current.password,
            //           style: AppTextStyles.labelMedium.copyWith(
            //             fontSize: 14.sp,
            //           ),
            //         ),
            //         8.heightSpace,
            //         CustomTextField(
            //           hintText: '  ••••••••',
            //           prefixIconImage: 'assets/images/pass_lock.svg',
            //           textInputAction: TextInputAction.done,
            //           onSaved: (val) {
            //             data['password'] = val;
            //           },
            //           validator: (value) {
            //             return ValidationHelper.validatePassword(
            //               value,
            //               context,
            //             );
            //           },
            //           suffix: IconButton(
            //             onPressed: () {
            //               setState(() {
            //                 hidePassword = !hidePassword;
            //               });
            //             },
            //             icon: ImageIcon(
            //               hidePassword
            //                   ? const AssetImage('assets/images/eye_off.png')
            //                   : const AssetImage('assets/images/eye_on.png'),
            //               color: hidePassword
            //                   ? AppColors.thirdColor
            //                   : AppColors.primaryColor,
            //             ),
            //           ),
            //           maxLines: 1,
            //           hidePassword: hidePassword,
            //         ),
            //         16.heightSpace,
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             CustomTextButton(
            //               text: S.current.forgotYourPassword,
            //               onPressed: () {
            //                 LocatorService.navigationService.currentState
            //                     ?.pushNamed(ForgetPasswordScreen.routeName);
            //               },
            //             ),
            //           ],
            //         ),
            //         64.heightSpace,
            //         Hero(
            //           tag: 'IntroButton',
            //           child: CustomElevatedButton(
            //             text: S.current.logIn,
            //             onPressed: _phoneController.text.isEmpty
            //                 ? null
            //                 : _login,
            //           ),
            //         ),
            //         16.heightSpace,
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               S.of(context).dontHaveAnAccount,
            //               style: AppTextStyles.labelSmall,
            //             ),
            //             5.widthSpace,
            //             CustomTextButton(
            //               text: S.current.createNewAccount,
            //               onPressed: () {
            //                 LocatorService.navigationService.currentState
            //                     ?.pushNamed(RegisterScreen.routeName);
            //               },
            //             ),
            //           ],
            //         ),
            //         64.heightSpace,
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
