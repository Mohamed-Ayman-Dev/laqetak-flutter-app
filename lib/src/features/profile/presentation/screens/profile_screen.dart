import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/images_assets.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/helpers/dialog_helpers.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/custom_outline_button.dart';
import 'package:invastro/src/core/shared/widgets/custom_appbar.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:invastro/src/features/auth/data/models/user_model.dart';
import 'package:invastro/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:invastro/src/features/auth/presentation/providers/auth.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/helpers/image_utils.dart';
import '../../../../core/shared/controllers/others_controller.dart';
import '../../../../core/shared/models/details_model.dart';
import '../../../../core/shared/providers/others.dart';
import '../../../../core/shared/widgets/custom_image.dart';
import '../../../../core/shared/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/shared/widgets/fields_widgets/my_custom_drop_down_menu.dart';
import '../../../../core/shared/widgets/fields_widgets/password_eye_toggle.dart';

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
    emailController.text = LocatorService.auth.user?.email ?? '';
    phoneController.text = LocatorService.auth.user?.phone ?? '';
    data['city_id'] = LocatorService.auth.user?.city?.id;
    data['name'] = LocatorService.auth.user?.name;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OthersController.getCities();
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
    LocatorService.auth.imagePath = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        icons: [AppbarIcons.logo, AppbarIcons.drawer],
        flexRight: 8,
      ),
      drawer: CustomDrawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 28, horizontal: 23).r,
            child: Selector<Auth, UserModel?>(
              selector: (context, provider) => provider.user,
              builder: (context, user, child) {
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
                                        LocatorService.auth.setImagePath(
                                          pickedFile.path,
                                        );
                                        data['avatar'] = pickedFile;
                                      }
                                    }
                                  : null,
                              child: Selector<Auth, String?>(
                                selector: (context, provider) =>
                                    provider.imagePath,
                                builder: (context, imagePath, child) {
                                  return imagePath != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
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
                      Text(user?.name ?? '', style: AppTextStyles.labelLarge),
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
                                  SvgPicture.asset(SvgAssets.assetsSvgEditIcon),
                                  24.widthSpace,
                                ],
                              )
                            : null,
                        hintText: 'البريد الالكتروني',
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
                            emptyMessage: S.of(context).pleaseEnterYourEmail,
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
                          return ValidationHelper.validatePhone(value, context);
                        },
                        borderColor: AppColors.questionBorderColor,
                        borderRadius: 16,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        hintText: "رقم الجوال",
                      ),
                      12.heightSpace,

                      Selector<Others, List<DetailsModel>?>(
                        selector: (context, provider) => provider.myCities,
                        builder: (context, myCities, child) {
                          return MyCustomDropdownFormField(
                            hint: "اختر المدينة",
                            enabled: isEditMode,
                            items: myCities
                                ?.map<DropdownMenuItem<num>>(
                                  (e) => DropdownMenuItem<num>(
                                    value: e.id,
                                    child: Text(
                                      e.name ?? '',
                                      style: AppTextStyles.inputTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ).r,

                            borderColor: AppColors.questionBorderColor,
                            borderRadius: 16,
                            value: data['city_id'],
                            validator: (value) {
                              if (value == null) {
                                return S.of(context).pleaseSelectACity;
                              }
                              return null;
                            },
                            onChanged: (val) {
                              data['city_id'] = val;
                            },
                            onSaved: (val) {},
                          );
                        },
                      ),
                      20.heightSpace,
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'كلمة المرور',
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
                        // validator: (value) {
                        //   return ValidationHelper.validatePassword(
                        //     value,
                        //     context,
                        //   );
                        // },
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 25.h, child: VerticalDivider()),
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
                              SizedBox(height: 25.h, child: VerticalDivider()),
                              5.widthSpace,
                              EyeToggleIcon(
                                isHidden: hidePasswordConfirm,
                                onToggle: () {
                                  setState(() {
                                    hidePasswordConfirm = !hidePasswordConfirm;
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
                          ? CustomElevatedButton(
                              text: 'حفظ',
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  if ((data['phone'] ==
                                      LocatorService.auth.user?.phone)) {
                                    await AuthController.updateProfile(
                                      context,
                                      data,
                                      hasMultipartData: data['avatar'] != null,
                                    );
                                  } else {
                                    await AuthController.sendPhoneOtp(data);
                                  }
                                }
                              },
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: CustomElevatedButton(
                                    text: 'تعديل',
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
                                  child: CustomOutlineButton(
                                    text: 'حذف الحساب',
                                    borderRadius: 8,
                                    borderColor: AppColors.deleteBorderColor,
                                    icon: SvgAssets.assetsSvgDeleteIcon,
                                    onPressed: () {
                                      DialogHelpers.showYesNoDialog(
                                        title: 'تأكيد الإجراء',
                                        subtitle: 'هل انت متأكد من حذف الحساب؟',
                                        onButtonTap: () {
                                          Navigator.of(context).pop();
                                          AuthController.deleteAccount(
                                            context: context,
                                          );
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
    );
  }
}
