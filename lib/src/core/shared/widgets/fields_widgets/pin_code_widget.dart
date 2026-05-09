import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../themes/colors.dart';
import '../../../themes/text_styles.dart';

class PinCodeWidget extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final bool isNotValid;
  final String? Function(String?)? validator;

  const PinCodeWidget({
    super.key,
    this.onChanged,
    this.validator,
    this.isNotValid = false,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        obscureText: false,
        autoDisposeControllers: true,
        autoDismissKeyboard: true,
        autoFocus: true,
        onSaved: onSaved,
        hintStyle: AppTextStyles.hintTextStyle.copyWith(
          color: AppColors.labelTextColor,
        ),
        obscuringCharacter: '*',
        hintCharacter: '-',
        autovalidateMode: AutovalidateMode.disabled,
        keyboardType: TextInputType.number,
        useHapticFeedback: true,
        cursorColor: AppColors.cursorColor,
        textStyle: AppTextStyles.inputTextStyle,
        pinTheme: PinTheme(
          activeColor: isNotValid
              ? AppColors.errorTextColor
              : AppColors.primaryColor,
          shape: PinCodeFieldShape.box,
          selectedColor: isNotValid
              ? AppColors.errorTextColor
              : AppColors.primaryColor,
          inactiveColor: isNotValid
              ? AppColors.errorTextColor
              : AppColors.fieldBorderColor,
          borderRadius: BorderRadius.circular(16),
          fieldHeight: 77.h,
          borderWidth: 1,
          inactiveBorderWidth: 1,
          activeBorderWidth: 1.5,
          selectedBorderWidth: 1,
          fieldWidth: 78.w,
          selectedFillColor: AppColors.primaryColor,
          inactiveFillColor: AppColors.fieldBorderColor,
          activeFillColor: AppColors.primaryColor,
          errorBorderColor: AppColors.errorTextColor,
          errorBorderWidth: 1,
        ),
        onChanged: onChanged,
        validator: validator,
        errorTextMargin: const EdgeInsets.only(top: 50, bottom: 0).r,
      ),
    );
  }
}
