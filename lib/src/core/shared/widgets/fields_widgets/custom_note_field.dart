import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../themes/colors.dart';
import '../../../themes/text_styles.dart';

class CustomNoteField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final Color? color;
  final int? maxLines;
  final TextInputType keyboardType;
  final void Function(String? value)? onSaved;
  final String? Function(String? value)? validator;

  const CustomNoteField({
    super.key,
    this.controller,
    this.keyboardType = TextInputType.name,
    this.onSaved,
    this.hint,
    this.color,
    this.maxLines,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: AppTextStyles.bodyLarge.copyWith(color: Colors.black),
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
      maxLines: maxLines ?? 4,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color ?? AppColors.fieldBorderColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color ?? AppColors.fieldBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.fieldBorderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintText: hint ?? S.of(context).writeYourMessage,
        hintStyle: AppTextStyles.hintTextStyle,
        fillColor: color ?? Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
      ),
    );
  }
}
