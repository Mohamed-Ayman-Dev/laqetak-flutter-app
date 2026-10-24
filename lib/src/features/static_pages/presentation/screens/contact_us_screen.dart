import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/constants/app_feedback.dart';
import 'package:laqetak/src/core/constants/enums.dart';
import 'package:laqetak/src/core/constants/svg_assets.dart';
import 'package:laqetak/src/core/themes/colors.dart';
import 'package:laqetak/src/core/widgets/drawer_widgets/app_drawer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/shared/settings/presentation/cubit/settings_cubit.dart';
import '../../../../core/shared/settings/presentation/cubit/settings_state.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../core/widgets/buttons_widgets/app_elevated_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/fields_widgets/custom_note_field.dart';
import '../../../../core/widgets/fields_widgets/custom_textField.dart';
import '../widgets/social_widgets.dart';

class ContactUsScreen extends StatefulWidget {
  static const routeName = '/contact-us';

  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final Map<String, dynamic> _formData = {};

  Future<void> _send() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      DialogHelpers.showDemoDialog(
        message: S.of(context).demoContactUsMessage,
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  bool once = false;

  @override
  void didChangeDependencies() {
    if (!once) {
      if (LocatorService.authCubit.state.isAuth) {
        final user = LocatorService.authCubit.state.user;
        _nameController.text = user?.name ?? '';
        _phoneController.text = user?.phone ?? '';
        _emailController.text = user?.email ?? '';
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<SettingsCubit>().getSettings();
      });
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
      drawer: AppDrawer(),
      body: BlocListener<SettingsCubit, SettingsState>(
        listenWhen: (previous, current) =>
            current.hasError && !previous.hasError,
        listener: (context, state) =>
            AppFeedback.errorMessage(state.errorMessage),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.heightSpace,
                Text(
                  S.of(context).contactUs,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.titleTextColor,
                    fontSize: 16.sp,
                  ),
                ),
                30.heightSpace,
                Text(
                  S.of(context).name,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: AppColors.labelTextColor,
                  ),
                ),
                8.heightSpace,
                CustomTextField(
                  hintText: S.of(context).name,
                  controller: _nameController,
                  onSaved: (val) {
                    _formData['name'] = val;
                  },
                  keyboardType: TextInputType.name,

                  validator: (value) {
                    return ValidationHelper.validateName(
                      value,
                      emptyMessage: S.of(context).youMustEnterYourName,
                      invalidMessage: S.of(context).pleaseEnterAValidName,
                    );
                  },
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                ),
                24.heightSpace,
                Text(
                  S.current.mobileNumber,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: AppColors.labelTextColor,
                  ),
                ),
                8.heightSpace,
                CustomTextField(
                  onSaved: (val) {
                    _formData['phone'] = val;
                  },
                  validator: (value) {
                    return ValidationHelper.validatePhone(value, context);
                  },
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: _phoneController,
                  hintText: S.current.mobileNumber,
                ),
                24.heightSpace,
                Text(
                  S.current.emailAddress,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: AppColors.labelTextColor,
                  ),
                ),
                8.heightSpace,
                CustomTextField(
                  hintText: S.current.enterYourEmail,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
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
                  S.of(context).messageSubject,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: AppColors.labelTextColor,
                  ),
                ),
                8.heightSpace,
                CustomNoteField(
                  hint: S.of(context).writeYourMessage,
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
                AppElevatedButton(
                  text: S.current.send,
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
      ),
    );
  }
}
