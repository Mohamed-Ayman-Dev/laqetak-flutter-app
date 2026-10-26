import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laqetak/src/core/constants/enums.dart';
import 'package:laqetak/src/core/constants/images_assets.dart';
import 'package:laqetak/src/core/constants/svg_assets.dart';
import 'package:laqetak/src/core/di/locator_service.dart';
import 'package:laqetak/src/core/extension/space_extensions_helper.dart';
import 'package:laqetak/src/core/helpers/dialog_helpers.dart';
import 'package:laqetak/src/core/themes/colors.dart';
import 'package:laqetak/src/core/themes/text_styles.dart';
import 'package:laqetak/src/core/widgets/buttons/app_elevated_button.dart';
import 'package:laqetak/src/core/widgets/buttons/app_outline_button.dart';
import 'package:laqetak/src/core/widgets/custom_app_bar.dart';
import 'package:laqetak/src/core/widgets/drawer/app_drawer.dart';
import 'package:laqetak/src/features/auth/data/models/user_model.dart';
import 'package:laqetak/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:laqetak/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:laqetak/src/features/auth/presentation/screens/login_screen.dart';
import 'package:laqetak/src/features/auth/presentation/screens/otp_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app_feedback.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/helpers/image_utils.dart';
import '../../../../core/shared/others/data/models/details_model.dart';
import '../../../../core/shared/others/presentation/cubit/others_cubit.dart';
import '../../../../core/shared/others/presentation/cubit/others_state.dart';
import '../../../../core/widgets/images/custom_image.dart';
import '../../../../core/widgets/fields/custom_drop_down_menu.dart';
import '../../../../core/widgets/fields/custom_text_field.dart';
import '../../../../core/widgets/fields/password_eye_toggle.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile_screen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> data = {};
  bool isEditMode = false;
  bool hidePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    final user = LocatorService.authCubit.state.user;
    emailController.text = user?.email ?? '';
    phoneController.text = user?.phone ?? '';
    data['city_id'] = user?.city?.id;
    data['name'] = user?.name;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OthersCubit>().getCities();
    });
    super.initState();
  }

  bool hidePasswordConfirm = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    LocatorService.authCubit.setImagePath(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.actionStatus != current.actionStatus &&
          (current.lastMutation == AuthMutation.updateProfile ||
              current.lastMutation == AuthMutation.sendPhoneOtp ||
              current.lastMutation == AuthMutation.deleteAccount),
      listener: _onProfile,
      child: Scaffold(
        appBar: CustomAppbar(
          icons: [AppbarIcons.logo, AppbarIcons.drawer],
          flexRight: 8,
        ),
        drawer: AppDrawer(),
        body: SafeArea(
          top: false,
          bottom: true,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 28, horizontal: 23).r,
                child: BlocSelector<AuthCubit, AuthState, UserModel?>(
                  selector: (state) => state.user,
                  builder: (context, user) {
                    return Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Hero(
                            tag: 'profile_image',
                            child: Stack(
                              alignment: Alignment(-0.9, 0.9),
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: isEditMode
                                      ? () async {
                                          final XFile? pickedFile =
                                              await ImageUtils.openPickingOptions(
                                                context,
                                                imageQuality: 70,
                                              );
                                          if (pickedFile != null) {
                                            LocatorService.authCubit
                                                .setImagePath(pickedFile.path);
                                            data['avatar'] = pickedFile;
                                          }
                                        }
                                      : null,
                                  child:
                                      BlocSelector<
                                        AuthCubit,
                                        AuthState,
                                        String?
                                      >(
                                        selector: (state) => state.imagePath,
                                        builder: (context, imagePath) {
                                          return imagePath != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                  child: Image.file(
                                                    File(imagePath),
                                                    width: 122,
                                                    fit: BoxFit.cover,
                                                    height: 122,
                                                  ),
                                                )
                                              : CustomImage(
                                                  imageUrl: user?.avatar ?? '',
                                                  width: 122,
                                                  height: 122,
                                                  borderRadius: 100,
                                                );
                                        },
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Image.asset(
                                    ImagesAssets.assetsImagesProfileEdit,
                                    width: 26.w,
                                    height: 26.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          17.heightSpace,
                          Text(
                            user?.name ?? '',
                            style: AppTextStyles.labelLarge,
                          ),
                          12.heightSpace,
                          Text(
                            user?.email ?? '',
                            style: AppTextStyles.labelMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                              color: AppColors.labelSmallGreyTextColor,
                            ),
                          ),
                          25.heightSpace,
                          CustomTextField(
                            onChanged: (value) {
                              setState(() {});
                            },
                            enabled: isEditMode,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 16,
                            ).r,
                            suffixIcon: isEditMode
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 25.h,
                                        child: VerticalDivider(),
                                      ),
                                      15.widthSpace,
                                      SvgPicture.asset(
                                        SvgAssets.assetsSvgEditIcon,
                                      ),
                                      24.widthSpace,
                                    ],
                                  )
                                : null,
                            hintText: S.current.emailAddress,
                            borderColor: AppColors.questionBorderColor,
                            borderRadius: 16,
                            textInputAction: TextInputAction.next,
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            onSaved: (val) {
                              data['email'] = val;
                            },
                            validator: (value) {
                              return ValidationHelper.validateEmail(
                                value,
                                emptyMessage: S
                                    .of(context)
                                    .pleaseEnterYourEmail,
                                invalidMessage: S
                                    .of(context)
                                    .pleaseEnterAValidEmail,
                              );
                            },
                          ),
                          12.heightSpace,
                          CustomTextField(
                            onChanged: (value) {
                              setState(() {});
                            },
                            enabled: isEditMode,

                            controller: phoneController,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 16,
                            ).r,
                            onSaved: (val) {
                              data['phone'] = val;
                            },
                            validator: (value) {
                              return ValidationHelper.validatePhone(
                                value,
                                context,
                              );
                            },
                            suffixIcon: isEditMode
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 25.h,
                                        child: VerticalDivider(),
                                      ),
                                      15.widthSpace,
                                      SvgPicture.asset(
                                        SvgAssets.assetsSvgEditIcon,
                                      ),
                                      24.widthSpace,
                                    ],
                                  )
                                : null,
                            borderColor: AppColors.questionBorderColor,
                            borderRadius: 16,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            hintText: S.current.mobileNumber,
                          ),
                          12.heightSpace,
                          BlocListener<OthersCubit, OthersState>(
                            listenWhen: (previous, current) =>
                                current.hasError && !previous.hasError,
                            listener: (context, state) =>
                                AppFeedback.errorMessage(state.errorMessage),
                            child:
                                BlocSelector<
                                  OthersCubit,
                                  OthersState,
                                  List<DetailsModel>
                                >(
                                  selector: (state) => state.cities,
                                  builder: (context, myCities) {
                                    return CustomDropdownFormField<
                                      DetailsModel
                                    >(
                                      hint: S.current.selectCity,
                                      enabled: isEditMode,
                                      items: myCities,
                                      itemAsString: (item) => item.name ?? '',
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 16,
                                      ).r,

                                      borderColor:
                                          AppColors.questionBorderColor,
                                      borderRadius: 16,
                                      value: data['city_id'] == null
                                          ? null
                                          : myCities.firstWhere(
                                              (e) => e.id == data['city_id'],
                                              orElse: () => DetailsModel(),
                                            ),
                                      validator: (value) {
                                        if (value == null) {
                                          return S
                                              .of(context)
                                              .pleaseSelectACity;
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        data['city_id'] = val?.id;
                                      },
                                      onSaved: (val) {},
                                    );
                                  },
                                ),
                          ),
                          20.heightSpace,
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              S.current.password,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.titleTextColor,
                              ),
                            ),
                          ),
                          8.heightSpace,
                          CustomTextField(
                            hintText: '*********',
                            borderColor: AppColors.questionBorderColor,
                            borderRadius: 16,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 16,
                            ).r,
                            enabled: isEditMode,
                            textInputAction: TextInputAction.done,
                            onSaved: (val) {
                              data['password'] = val;
                            },
                            controller: passwordController,
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 25.h,
                                  child: VerticalDivider(),
                                ),
                                5.widthSpace,
                                EyeToggleIcon(
                                  isHidden: hidePassword,
                                  onToggle: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                ),
                                10.widthSpace,
                              ],
                            ),
                            maxLines: 1,
                            obscureText: hidePassword,
                          ),
                          12.heightSpace,

                          if (isEditMode)
                            CustomTextField(
                              hintText: '*********',

                              textInputAction: TextInputAction.done,
                              onSaved: (val) {
                                data['password_confirmation'] = val;
                              },
                              validator: (value) {
                                return ValidationHelper.validatePasswordConfirmation(
                                  value,
                                  passwordController.text,
                                  context,
                                  validateEmptyEnabled: false,
                                );
                              },
                              borderColor: AppColors.questionBorderColor,
                              borderRadius: 16,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ).r,
                              controller: passwordConfirmController,
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 25.h,
                                    child: VerticalDivider(),
                                  ),
                                  5.widthSpace,
                                  EyeToggleIcon(
                                    isHidden: hidePasswordConfirm,
                                    onToggle: () {
                                      setState(() {
                                        hidePasswordConfirm =
                                            !hidePasswordConfirm;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              obscureText: hidePasswordConfirm,
                            ),
                          25.heightSpace,
                          isEditMode
                              ? AppElevatedButton(
                                  text: S.current.save,
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      if ((data['phone'] ==
                                          LocatorService
                                              .authCubit
                                              .state
                                              .user
                                              ?.phone)) {
                                        await context
                                            .read<AuthCubit>()
                                            .updateProfile(
                                              data,
                                              hasMultipartData:
                                                  data['avatar'] != null,
                                            );
                                      } else {
                                        await context
                                            .read<AuthCubit>()
                                            .sendPhoneOtp(data);
                                      }
                                    }
                                  },
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: AppElevatedButton(
                                        text: S.of(context).edit,
                                        icon: SvgAssets.assetsSvgArrowRight,
                                        onPressed: () {
                                          setState(() {
                                            isEditMode = true;
                                          });
                                        },
                                      ),
                                    ),
                                    16.widthSpace,
                                    Expanded(
                                      child: AppOutlineButton(
                                        text: S.of(context).deleteAccount,
                                        borderRadius: 8,
                                        borderColor:
                                            AppColors.deleteBorderColor,
                                        icon: SvgAssets.assetsSvgDeleteIcon,
                                        onPressed: () {
                                          DialogHelpers.showYesNoDialog(
                                            title: S.current.confirmAction,
                                            subtitle: S
                                                .of(context)
                                                .areYouSureYouWantToDeleteYourAccount,
                                            onButtonTap: () {
                                              Navigator.of(context).pop();
                                              context
                                                  .read<AuthCubit>()
                                                  .deleteAccount();
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onProfile(BuildContext context, AuthState authState) {
    if (ModalRoute.of(context)?.isCurrent != true) return;
    if (authState.lastMutation == AuthMutation.sendPhoneOtp &&
        authState.otpResent) {
      return;
    }
    switch (authState.actionStatus) {
      case RequestStatus.loading:
        if (authState.otpResent) return;
        if (authState.lastMutation == AuthMutation.deleteAccount) {
          LocatorService.navigationService.currentState?.pop();
          AppFeedback.loadingMessage(message: S.current.deletingAccount);
        } else {
          AppFeedback.loadingMessage();
        }
      case RequestStatus.success:
        EasyLoading.dismiss();
        switch (authState.lastMutation) {
          case AuthMutation.sendPhoneOtp:
            if (authState.successMessage != null) {
              AppFeedback.showToast(authState.successMessage!);
            }
            LocatorService.navigationService.currentState?.pushNamed(
              OtpScreen.routeName,
              arguments: {
                'redirectData': authState.otpRedirect,
                'data': authState.otpFormData,
                'from': OtpFlow.updatePhone,
              },
            );
          case AuthMutation.deleteAccount:
            LocatorService.resetSessionCubits();
            FirebaseAnalytics.instance.setUserId(id: null);
            FirebaseCrashlytics.instance.setUserIdentifier('');
            LocatorService.navigationService.currentState
                ?.pushNamedAndRemoveUntil(
                  LoginScreen.routeName,
                  (route) => false,
                );
            DialogHelpers.showSuccessDialog(
              title: S.current.accountDeletedSuccessfully,
              buttonText: S.current.login,
              onButtonTap: () {
                LocatorService.navigationService.currentState?.popUntil(
                  (route) => route.settings.name == LoginScreen.routeName,
                );
              },
            );
          case AuthMutation.updateProfile:
            DialogHelpers.showSuccessDialog(
              title:
                  authState.successMessage ??
                  S
                      .current
                      .congratulationsYourProfileHasBeenUpdatedSuccessfully,
            );
          default:
            break;
        }
      case RequestStatus.error:
        AppFeedback.errorMessage(authState.errorMessage);
      case RequestStatus.initial:
        break;
    }
  }
}
