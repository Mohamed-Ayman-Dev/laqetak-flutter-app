import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';
import '../../../themes/text_styles.dart';
import '../app_loading_indicator.dart';

class MyCustomDropdownFormField<T> extends StatelessWidget {
  const MyCustomDropdownFormField({
    super.key,
    this.items,
    this.value,
    this.onChanged,
    this.isLoading = false,
    this.validator,
    this.onSaved,
    this.hint,
    this.isRequired = false,
    this.enabled = true,
    this.color,
    this.icon,
    this.suffix,
    this.prefixIcon,
    this.hintStyle,
    this.contentPadding,
    this.borderRadius = 12,
    this.borderColor,
  });

  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final String? hint;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final void Function(T?)? onSaved;
  final bool isRequired;
  final Color? color;
  final Widget? icon;
  final Widget? suffix;

  final double borderRadius;
  final bool enabled;
  final EdgeInsets? contentPadding;
  final Color? borderColor;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final bool isLoading;

  // ← single source of truth for all borders
  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius).r,
    borderSide: BorderSide(color: borderColor ?? color, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      style: AppTextStyles.inputTextStyle.copyWith(color: Colors.black),
      padding: EdgeInsets.zero,
      initialValue: value,
      items: items,
      onChanged: enabled ? onChanged : null,
      onSaved: onSaved,
      validator: validator,
      hint: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          hint ?? '',
          style: hintStyle ?? AppTextStyles.hintTextStyle,
        ),
      ),
      icon: isLoading
          ? const AppLoadingIndicator()
          : const Icon(Icons.keyboard_arrow_down_rounded),
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints(minWidth: 3, minHeight: 3),
        prefixIcon: isRequired
            ? const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text('*', style: TextStyle(color: Colors.red)),
              )
            : prefixIcon,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 15, vertical: 13).r,
        fillColor: color,
        suffix: suffix,

        filled: color != null,
        hintStyle: AppTextStyles.hintTextStyle,
        border: _border(AppColors.fieldBorderColor),
        enabledBorder: _border(AppColors.fieldBorderColor),
        focusedBorder: _border(AppColors.primaryColor),
        errorBorder: _border(AppColors.errorTextColor),
        focusedErrorBorder: _border(AppColors.errorTextColor),
      ),
    );
  }
}
