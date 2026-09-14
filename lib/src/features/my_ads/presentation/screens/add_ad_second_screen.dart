import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/core/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/widgets/fields_widgets/custom_note_field.dart';
import 'package:invastro/src/features/my_ads/presentation/widgets/ad_image_picker.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../core/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_switch.dart';
import '../../../../core/widgets/fields_widgets/custom_textField.dart';

class AddAdSecondScreen extends StatefulWidget {
  static const routeName = '/add-ad-second-screen';

  const AddAdSecondScreen({super.key});

  @override
  State<AddAdSecondScreen> createState() => _AddAdSecondScreenState();
}

class _AddAdSecondScreenState extends State<AddAdSecondScreen> {
  final _formKey = GlobalKey<FormState>();
  AdModel? ad;

  Map<String, dynamic> _formData = {'hide_phone': 0};
  bool once = false;
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (!once) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        ad = args['ad'];
        if (ad != null) {
          _descController.text = ad?.description ?? '';
          _phoneController.text = ad?.contactPhone ?? '';
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _formData['hide_phone'] = ad?.hidePhone ?? 0;
            });
          });
        } else {
          _phoneController.text = LocatorService.authCubit.state.user?.phone ?? '';
        }

        _formData = args['data'];
      }
      once = true;
    }
    super.didChangeDependencies();
  }

  Future<void> _send() async {
    final newPhotos = _formData['photos[]'] as List<XFile>? ?? [];
    final removedIds = _formData['photos_to_remove[]'] as List<num>? ?? [];
    final existingCount = (ad?.photos?.length ?? 0) - removedIds.length;
    final totalPhotos = newPhotos.length + existingCount;
    // if (totalPhotos == 0) {
    //   AppFeedback.showToast(
    //     S.of(context).pleaseSelectAtLeastOneImage,
    //     isError: true,
    //   );
    //   return;
    // }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool isUpdate = ad != null;

      if (isUpdate) {
        _formData['ad_id'] = ad?.id;
        if ((_formData['contact_phone'] == ad?.contactPhone) ||
            (_formData['contact_phone'] == LocatorService.authCubit.state.user?.phone)) {
          LocatorService.myAdsCubit.editAd(_formData, checkOtp: false);
        } else {
          LocatorService.myAdsCubit.sendAdOtp(_formData, edit: true);
        }
      } else {
        _formData['ad_id'] = ad?.id;
        if ((_formData['contact_phone'] == ad?.contactPhone) ||
            (_formData['contact_phone'] == LocatorService.authCubit.state.user?.phone)) {
          LocatorService.myAdsCubit.addAd(_formData);
        } else {
          LocatorService.myAdsCubit.sendAdOtp(_formData, edit: false);
        }
      }
    }
  }

  @override
  void dispose() {
    _descController.dispose();
    _phoneController.dispose();
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
      body: SafeArea(
        top: false,
        bottom: true,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 15, right: 17).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.heightSpace,
                Text(
                  S.of(context).addYourAd,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.titleTextColor,
                    fontSize: 16.sp,
                  ),
                ),
                25.heightSpace,
                Text(S.of(context).adImages, style: AppTextStyles.labelSmall),
                8.heightSpace,
                // في الـ widget
                AdImagePicker(
                  initialPhotos: ad?.photos ?? [],
                  onChanged: ({required newPhotos, required photosToRemove}) {
                    _formData['photos[]'] = newPhotos;
                    _formData['photos_to_remove[]'] = photosToRemove;
                  },
                ),
                17.heightSpace,
                Text(S.of(context).adDetails, style: AppTextStyles.labelSmall),
                8.heightSpace,
                CustomNoteField(
                  hint: S.of(context).writeAdDetails,
                  keyboardType: TextInputType.text,
                  controller: _descController,
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
                Text(
                  S.of(context).contactNumber,
                  style: AppTextStyles.labelSmall,
                ),
                8.heightSpace,
                CustomTextField(
                  onSaved: (val) {
                    _formData['contact_phone'] = val;
                  },
                  controller: _phoneController,

                  validator: (value) {
                    return ValidationHelper.validatePhone(value, context);
                  },
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  hintText: S.of(context).mobileNumber,
                ),
                15.heightSpace,
                Row(
                  children: [
                    CustomSwitch(
                      value: _formData['hide_phone'] == 1,
                      onChanged: (val) =>
                          setState(() => _formData['hide_phone'] = val ? 1 : 0),
                    ),
                    Text(S.of(context).hidePhoneNumber),
                  ],
                ),
                10.heightSpace,
                Row(
                  children: [
                    CustomElevatedButton(
                      text: S.current.next,
                      icon: SvgAssets.assetsSvgArrowRight,
                      size: Size(163.w, 48.h),
                      onPressed: () {
                        _send();
                      },
                    ),
                    12.widthSpace,
                    CustomElevatedButton(
                      text: S.of(context).previous,
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
      ),
    );
  }
}
