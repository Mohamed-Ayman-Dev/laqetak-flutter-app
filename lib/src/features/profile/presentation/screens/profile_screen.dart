import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/images_assets.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/helpers/dialog_helpers.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/custom_outline_button.dart';
import 'package:invastro/src/core/shared/widgets/custom_appbar.dart';
import 'package:invastro/src/core/shared/widgets/custom_asset_image.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/mock_data_for_loading.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/shared/models/details_model.dart';
import '../../../../core/shared/providers/others.dart';
import '../../../../core/shared/widgets/fields_widgets/country_code_field.dart';
import '../../../../core/shared/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/shared/widgets/fields_widgets/my_custom_drop_down_menu.dart';
import '../../../../core/shared/widgets/fields_widgets/password_eye_toggle.dart';
import '../../../auth/presentation/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile_screen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Set<int> _likedAds = {};
  Map<String, dynamic> data = {};
  bool isEditMode = false;
  final FocusNode _phoneFocusNode = FocusNode();
  bool hidePassword = true;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'profile_image',
                  child: CustomAssetImage(
                    image: ImagesAssets.assetsImagesMockProfileImage,
                    width: 122,
                    height: 122,
                  ),
                ),
                17.heightSpace,
                Text('مصطفى عبد الرحمن', style: AppTextStyles.labelLarge),
                12.heightSpace,
                Text(
                  'moustfaf5059@gmail',
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
                            SizedBox(height: 25.h, child: VerticalDivider()),
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
                  controller: TextEditingController(
                    text: 'mostafa9809@gmail.com',
                  ),
                  onSaved: (val) {
                    data['email'] = val;
                  },
                  validator: (value) {
                    return ValidationHelper.validateEmail(
                      value,
                      emptyMessage: S.of(context).pleaseEnterYourEmail,
                      invalidMessage: S.of(context).pleaseEnterAValidEmail,
                    );
                  },
                ),
                12.heightSpace,
                CustomTextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  enabled: isEditMode,

                  controller: TextEditingController(text: '0966000000000'),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 16,
                  ).r,
                  onSaved: (val) {
                    data['phone'] = val;
                  },
                  validator: (value) {
                    return ValidationHelper.validatePhoneByCountryCode(
                      phone: value,
                      countryCode: data['country_code'],
                      context: context,
                    );
                  },
                  borderColor: AppColors.questionBorderColor,
                  borderRadius: 16,
                  focusNode: _phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  hintText: "رقم الجوال",
                  // textDirection: TextDirection.ltr,
                  suffixIcon: isEditMode
                      ? CountryCodeField(
                          focusNode: _phoneFocusNode,
                          onChanged: (val) {
                            data['country_code'] = val.toString();
                          },
                          onInit: (val) {
                            data['country_code'] = val.toString();
                          },
                        )
                      : null,
                ),
                12.heightSpace,
                Selector<Others, List<DetailsModel>?>(
                  selector: (context, provider) => provider.myCities,
                  builder: (context, myCities, child) {
                    return MyCustomDropdownFormField(
                      hint: S.of(context).city,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ).r,

                      borderColor: AppColors.questionBorderColor,
                      borderRadius: 16,
                      // items: myCities
                      items: MockDataForLoading.mockCites
                          .map<DropdownMenuItem<num>>(
                            (e) => DropdownMenuItem<num>(
                              value: e.id,
                              child: SizedBox(
                                width: 100.w,
                                child: Text(
                                  e.name ?? '',
                                  style: AppTextStyles.inputTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      value: 1,

                      validator: (value) {
                        if (value == null) {
                          return S.of(context).pleaseSelectACity;
                        }
                        return null;
                      },
                      onChanged: (val) {
                        data['city_id'] = val;
                      },
                      onSaved: (val) {
                        data['city_id'] = val;
                      },
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
                  hintText: 'كلمة المرور',
                  controller: TextEditingController(text: 'password123'),

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
                  validator: (value) {
                    return ValidationHelper.validatePassword(value, context);
                  },
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
                25.heightSpace,
                isEditMode
                    ? CustomElevatedButton(
                        text: 'حفظ',
                        onPressed: () {
                          DialogHelpers.showSuccessDialog(
                            title: 'تهانينا لقد تم تعديل الملف الشخصي بنجاح',
                          );
                          setState(() {
                            isEditMode = false;
                          });
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
                                    DialogHelpers.showSuccessDialog(
                                      title: "تم حذف الحساب بنجاح",
                                      buttonText: 'تسجيل الدخول',
                                      onButtonTap: () {
                                        LocatorService
                                            .navigationService
                                            .currentState
                                            ?.popUntil(
                                              (route) =>
                                                  route.settings.name ==
                                                  LoginScreen.routeName,
                                            );
                                      },
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
          ),
        ],
      ),
    );
  }
}
