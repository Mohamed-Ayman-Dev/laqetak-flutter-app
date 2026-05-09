import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';
import '../../../themes/text_styles.dart';

class MyCustomDropdownFormField<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final String? hint;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final void Function(T?)? onSaved;
  final bool isRequired;
  final Color? color;
  final Widget? icon;
  final Widget? perfixIcon;
  final TextStyle? hintStyle;

  final bool isLoading;

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
    this.color,
    this.icon,
    this.perfixIcon,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      style: AppTextStyles.dropDownTextStyle,

      padding: EdgeInsets.zero,
      hint: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          hint ?? '',
          style: hintStyle ?? AppTextStyles.hintTextStyle,
        ),
      ),
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints(minWidth: 3, minHeight: 3),
        prefixIcon: isRequired
            ? const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text('*', style: TextStyle(color: Colors.red)),
              )
            : null,
        prefix: perfixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 13,
        ).r,
        fillColor: color,
        filled: color != null ? true : null,
        hintStyle: AppTextStyles.hintTextStyle,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.errorTextColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.errorTextColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.fieldBorderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.fieldBorderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      items: items,
      onChanged: onChanged,
      value: value,
      icon: isLoading
          ? Platform.isIOS
                ? const CupertinoActivityIndicator(
                    color: AppColors.primaryColor,
                  )
                : const SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
          : const Icon(Icons.keyboard_arrow_down_rounded),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
