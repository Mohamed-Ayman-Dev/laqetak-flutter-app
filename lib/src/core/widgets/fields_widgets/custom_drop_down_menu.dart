import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/themes/theme.dart';

import '../../../../generated/l10n.dart';
import '../../themes/text_styles.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  final List<T>? items;
  final T? value;
  final String Function(T)? itemAsString;
  final String? hint;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final void Function(T?)? onSaved;
  final bool isRequired;
  final Color? color;
  final Widget? icon;
  final bool enabled;
  final EdgeInsets? contentPadding;
  final Color? borderColor;
  final Widget? perfixIcon;
  final TextStyle? hintStyle;
  final double borderRadius;

  final bool isLoading;

  const CustomDropdownFormField({
    super.key,
    this.items,
    this.value,
    this.itemAsString,
    this.onChanged,
    this.isLoading = false,
    this.enabled = true,
    this.contentPadding,
    this.borderRadius = 12,
    this.borderColor,
    this.validator,
    this.onSaved,
    this.hint,
    this.isRequired = false,
    this.color,
    this.icon,
    this.perfixIcon,
    this.hintStyle,
  });

  // ← single source of truth for all borders
  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius).r,
    borderSide: BorderSide(color: borderColor ?? color, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    bool dropEnabled = (items != null && items!.isNotEmpty) && enabled != false;
    return Theme(
      data: CustomTheme.lightTheme.copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: DropdownSearch<T>(
        items: items ?? [],
        enabled: dropEnabled,
        // 👈 مرره هنا
        selectedItem: value,

        itemAsString: itemAsString,

        onChanged: onChanged,

        validator: validator,
        popupProps: PopupProps.menu(
          showSearchBox: true,

          fit: FlexFit.loose,

          searchDelay: Duration.zero,

          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: S.of(context).search,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ).r,

              border: _border(AppColors.inputBorderColor),
              enabledBorder: _border(AppColors.inputBorderColor),
              focusedBorder: _border(AppColors.primaryColor),
              errorBorder: _border(AppColors.errorTextColor),
              focusedErrorBorder: _border(AppColors.errorTextColor),
            ),
          ),
          itemBuilder: (context, item, isSelected) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ).r,
              child: Text(
                itemAsString?.call(item) ?? item.toString(),
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          },
        ),

        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(
              minWidth: 3.w,
              minHeight: 3.h,
            ),
            prefixIcon: isRequired
                ? Padding(
                    padding: EdgeInsets.only(right: 10.0).r,
                    child: Text('*', style: TextStyle(color: AppColors.errorColor)),
                  )
                : null,
            enabled: dropEnabled,

            prefix: perfixIcon,
            hintText: hint,
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(horizontal: 15, vertical: 13).r,
            fillColor: color,
            filled: color != null,
            hintStyle: AppTextStyles.hintTextStyle,
            border: _border(AppColors.inputBorderColor),
            enabledBorder: _border(AppColors.inputBorderColor),
            focusedBorder: _border(AppColors.primaryColor),
            disabledBorder: _border(AppColors.inputBorderColor),
            errorBorder: _border(AppColors.errorTextColor),
            focusedErrorBorder: _border(AppColors.errorTextColor),
          ),
        ),
        dropdownButtonProps: DropdownButtonProps(
          icon: isLoading
              ? Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : SizedBox(
                        height: 15.h,
                        width: 15.w,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
              : Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: !dropEnabled ? AppColors.disabledTextColor : null,
                ),
        ),
      ),
    );
  }
}
