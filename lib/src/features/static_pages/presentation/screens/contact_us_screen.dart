import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/enums.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
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

  final Map<String, dynamic> _formData = {};

  Future<void> _send() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
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
      // floatingActionButton: Align(
      //   alignment: Alignment.bottomRight,
      //   child: Padding(
      //     padding:
      //         const EdgeInsets.symmetric(vertical: 130.0, horizontal: 30).r,
      //     child: FloatingActionButton(
      //       onPressed: () {},
      //       shape: const CircleBorder(),
      //       child: Image.asset(
      //         'assets/images/chatting.png',
      //         width: 24.w,
      //         height: 24.h,
      //       ),
      //     ),
      //   ),
      // ),
      appBar: CustomAppbar(icons: [AppbarIcons.logo], flexRight: 8),
      body: SafeArea(
        bottom: true,
        top: false,
        right: false,
        left: false,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.heightSpace,
                Text('الإسم', style: AppTextStyles.labelMedium),
                8.heightSpace,
                CustomTextField(
                  hintText: 'الإسم',
                  controller: _nameController,
                  prefixIconImage: 'assets/images/user.svg',
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
                16.heightSpace,
                Text('رقم الجوال', style: AppTextStyles.labelMedium),
                8.heightSpace,
                CustomTextField(
                  focusNode: _phoneFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  onSaved: (val) {
                    _formData['phone'] = val;
                  },
                  controller: _phoneController,
                  hintText: 'رقم الجوال',
                  validator: (value) {
                    return ValidationHelper.validatePhone(value, context);
                  },
                ),
                16.heightSpace,
                Text('موضوع الرسالة', style: AppTextStyles.bodyLarge),
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
                SocialWidgets(),
                193.heightSpace,
                CustomElevatedButton(
                  text: 'S.of(context).send',
                  onPressed: () {
                    _send();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
