import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/app_feedback.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/helpers/dialog_helpers.dart';
import 'package:invastro/src/core/shared/models/redirect_model.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/shared/widgets/fields_widgets/custom_note_field.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/auth/presentation/screens/otp_screen.dart';
import 'package:invastro/src/features/my_ads/presentation/widgets/ad_image_picker.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../../../../core/shared/widgets/custom_switch.dart';
import '../../../../core/shared/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/themes/text_styles.dart';

class AddAdSecondScreen extends StatefulWidget {
  static const routeName = '/add-ad-second-screen';

  const AddAdSecondScreen({super.key});

  @override
  State<AddAdSecondScreen> createState() => _AddAdSecondScreenState();
}

class _AddAdSecondScreenState extends State<AddAdSecondScreen> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _formData = {};
  bool _isRequired = false;
  bool _isEdit = false;
  bool once = false;

  @override
  void didChangeDependencies() {
    if (!once) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        _isEdit = args['isEdit'];
        _formData = args['data'];
      }
      once = true;
    }
    super.didChangeDependencies();
  }

  Future<void> _send() async {
    if (_formData['photos[]'] == null || _formData['photos[]'].isEmpty) {
      AppFeedback.showToast('الرجاء اختيار صورة علي الأقل', isError: true);
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_isEdit) {
        DialogHelpers.showSuccessDialog(
          title: 'تهانينا لقد تم تعديل الإعلان بنجاح',
        );
      } else {
        LocatorService.navigationService.currentState?.pushNamed(
          OtpScreen.routeName,
          arguments: {
            'redirectData': RedirectModel(
              phone: _formData['contact_phone'],
              remainingSeconds: 120,
            ),
            'data': _formData,
            'from': OtpFlow.addAd,
          },
        );
      }
    }
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
          padding: EdgeInsets.only(left: 15, right: 17).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightSpace,
              Text(
                'أضف إعلانك',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.titleTextColor,
                  fontSize: 16.sp,
                ),
              ),
              25.heightSpace,
              Text('صور الإعلان', style: AppTextStyles.labelSmall),
              8.heightSpace,
              AdImagePicker(
                onImagesChanged: (images) {
                  _formData['photos[]'] = images;
                },
              ),
              17.heightSpace,
              Text('تفاصيل الإعلان', style: AppTextStyles.labelSmall),
              8.heightSpace,
              CustomNoteField(
                hint: 'اكتب تفاصيل الإعلان',
                keyboardType: TextInputType.text,
                validator: (value) {
                  return ValidationHelper.validateEmpty(
                    value,
                    emptyMessage: S.of(context).detailsAreRequired,
                  );
                },
                onSaved: (val) {
                  _formData['description'] = val;
                },
              ),
              9.heightSpace,
              Text('رقم التواصل', style: AppTextStyles.labelSmall),
              8.heightSpace,
              CustomTextField(
                onSaved: (val) {
                  _formData['contact_phone'] = val;
                },
                validator: (value) {
                  return ValidationHelper.validatePhone(value, context);
                },
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                hintText: "رقم الجوال",
              ),
              15.heightSpace,
              CustomSwitch(
                value: _isRequired,
                onChanged: (val) => setState(() => _isRequired = val),
              ),
              10.heightSpace,
              Row(
                children: [
                  CustomElevatedButton(
                    text: 'التالي',
                    icon: SvgAssets.assetsSvgArrowRight,
                    size: Size(163.w, 48.h),
                    onPressed: () {
                      _send();
                    },
                  ),
                  12.widthSpace,
                  CustomElevatedButton(
                    text: 'السابق',
                    icon: SvgAssets.assetsSvgArrowLeft,
                    size: Size(163.w, 48.h),
                    backgroundColor: AppColors.buttonBackBKColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              50.heightSpace,
            ],
          ),
        ),
      ),
    );
  }
}
