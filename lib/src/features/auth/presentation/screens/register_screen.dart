import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/shared/controllers/others_controller.dart';
import 'package:invastro/src/core/shared/providers/others.dart';
import 'package:invastro/src/features/auth/presentation/screens/register_password_screen.dart';
import 'package:invastro/src/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/models/details_model.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_text_button.dart';
import '../../../../core/shared/widgets/custom_Text.dart';
import '../../../../core/shared/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/shared/widgets/fields_widgets/my_custom_drop_down_menu.dart';
import '../../../../core/shared/widgets/label_widget.dart';
import '../../../../core/themes/text_styles.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Map<String, dynamic> data = {};
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  Future<void> _register() async {
    if (_registerFormKey.currentState!.validate()) {
      _registerFormKey.currentState!.save();
      LocatorService.navigationService.currentState?.pushNamed(
        RegisterPasswordScreen.routeName,
        arguments: data,
      );
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OthersController.getCities();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0).r,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthAppbar(showGuestButton: true),
            24.heightSpace,
            CustomText(S.current.welcome, style: AppTextStyles.headlineMedium),
            15.heightSpace,
            CustomText(
              S.current.pleaseEnterYourDetails,
              style: AppTextStyles.headlineSmall,
            ),
            24.heightSpace,
            Form(
              key: _registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelWidget(text: S.of(context).username),
                  CustomTextField(
                    onSaved: (val) {
                      data['name'] = val;
                    },
                    validator: (value) {
                      return ValidationHelper.validateName(
                        value,
                        emptyMessage: S.of(context).pleaseEnterYourName,
                        invalidMessage: S.of(context).pleaseEnterAValidName,
                      );
                    },
                    hintText: S.of(context).enterUsername,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    keyboardType: TextInputType.name,
                  ),
                  24.heightSpace,
                  LabelWidget(text: S.current.mobileNumber),
                  CustomTextField(
                    onSaved: (val) {
                      data['phone'] = val;
                    },
                    validator: (value) {
                      return ValidationHelper.validatePhone(value, context);
                    },
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    hintText: S.current.mobileNumber,
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
                  LabelWidget(text: S.of(context).emailAddress),
                  CustomTextField(
                    onChanged: (value) {
                      setState(() {});
                    },

                    hintText: S.of(context).enterYourEmail,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,

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
                  24.heightSpace,
                  LabelWidget(text: S.current.city),
                  Selector<Others, List<DetailsModel>?>(
                    selector: (context, provider) => provider.myCities,
                    builder: (context, myCities, child) {
                      return MyCustomDropdownFormField<DetailsModel>(
                        hint: S.of(context).city,
                        items: myCities,
                        itemAsString: (item) => item.name ?? '',
                        value: data['city_id'] == null
                            ? null
                            : myCities?.firstWhere(
                                (e) => e.id == data['city_id'],
                                orElse: () => DetailsModel(),
                              ),
                        validator: (value) {
                          if (value == null) {
                            return S.of(context).pleaseSelectACity;
                          }
                          return null;
                        },
                        onChanged: (val) {
                          data['city_id'] = val?.id;
                        },
                        onSaved: (val) {
                          data['city_id'] = val?.id;
                        },
                      );
                    },
                  ),
                  24.heightSpace,

                  Hero(
                    tag: 'auth-button',
                    child: CustomElevatedButton(
                      text: S.of(context).next,
                      icon: SvgAssets.assetsSvgArrowRight,
                      onPressed: _register,
                    ),
                  ),
                  16.heightSpace,
                  Center(
                    child: CustomTextButton(
                      text: S.of(context).alreadyHaveAnAccount,
                      onPressed: () {
                        LocatorService.navigationService.currentState?.pop();
                      },
                    ),
                  ),
                  64.heightSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
