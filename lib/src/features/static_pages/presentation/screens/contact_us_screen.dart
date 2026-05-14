import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/helpers/dialog_helpers.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/themes/colors.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../../../../core/shared/widgets/fields_widgets/country_code_field.dart';
import '../../../../core/shared/widgets/fields_widgets/custom_note_field.dart';
import '../../../../core/shared/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/themes/text_styles.dart';
import '../widgets/social_widgets.dart';

class ContactUsScreen extends StatefulWidget {
  static const routeName = '/contact-us';

  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final FocusNode _phoneFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final Map<String, dynamic> _formData = {'country_code': '+966'};

  Future<void> _send() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      DialogHelpers.showSuccessDialog(title: 'تم ارسال رسالتك بنجاح');
      // StaticPagesController.sendContactUs(_formData);
    }
  }

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  bool once = false;

  @override
  void didChangeDependencies() {
    if (!once) {
      if (LocatorService.auth.user != null && LocatorService.auth.isAuth) {
        _nameController.text = LocatorService.auth.user?.name ?? '';
        _phoneController.text = LocatorService.auth.user?.phone ?? '';
      }
      if (LocatorService.appSettings.mySettings == null) {
        // AuthController.getGeneralSettings();
      }
      once = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        icons: [AppbarIcons.logo, AppbarIcons.drawer],
        flexRight: 8,
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightSpace,
              Text(
                'اتصل بنا',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.titleTextColor,
                  fontSize: 16.sp,
                ),
              ),
              30.heightSpace,
              Text(
                'الإسم',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.labelTextColor,
                ),
              ),
              8.heightSpace,
              CustomTextField(
                hintText: 'الإسم',
                controller: _nameController,
                onSaved: (val) {
                  _formData['name'] = val;
                },
                keyboardType: TextInputType.name,

                validator: (value) {
                  return ValidationHelper.validateName(
                    value,
                    emptyMessage: 'S.of(context).youMustEnterYourName',
                    invalidMessage: S.of(context).pleaseEnterAValidName,
                  );
                },
                textInputAction: TextInputAction.next,
                maxLines: 1,
              ),
              24.heightSpace,
              Text(
                'رقم الجوال',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.labelTextColor,
                ),
              ),
              8.heightSpace,
              CustomTextField(
                onChanged: (value) {
                  setState(() {});
                },
                onSaved: (val) {
                  _formData['phone'] = val;
                },
                validator: (value) {
                  return ValidationHelper.validatePhoneByCountryCode(
                    phone: value,
                    countryCode: _formData['country_code'],
                    context: context,
                  );
                },
                focusNode: _phoneFocusNode,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                controller: _phoneController,
                hintText: "رقم الجوال",
                // textDirection: TextDirection.ltr,
                suffixIcon: CountryCodeField(
                  focusNode: _phoneFocusNode,
                  onChanged: (val) {
                    _formData['country_code'] = val.toString();
                  },
                  onInit: (val) {
                    _formData['country_code'] = val.toString();
                  },
                ),
              ),
              24.heightSpace,
              Text(
                'البريد الإلكتروني',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.labelTextColor,
                ),
              ),
              8.heightSpace,
              CustomTextField(
                onChanged: (value) {
                  setState(() {});
                },

                hintText: 'أدخل بريدك الالكتروني',
                textInputAction: TextInputAction.next,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,

                onSaved: (val) {
                  _formData['email'] = val;
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
              Text(
                'موضوع الرسالة',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.labelTextColor,
                ),
              ),
              8.heightSpace,
              CustomNoteField(
                hint: 'أكتب رسالتك',
                keyboardType: TextInputType.text,
                validator: (value) {
                  return ValidationHelper.validateEmpty(
                    value,
                    emptyMessage: S.of(context).messageIsRequired,
                  );
                },
                onSaved: (val) {
                  _formData['message'] = val;
                },
              ),

              24.heightSpace,
              CustomElevatedButton(
                text: 'إرسال',
                icon: SvgAssets.assetsSvgArrowRight,
                onPressed: () {
                  _send();
                },
              ),
              33.heightSpace,
              SocialWidgets(),
              100.heightSpace,
            ],
          ),
        ),
      ),
    );
  }
}
