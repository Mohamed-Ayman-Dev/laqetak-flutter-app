import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../themes/colors.dart';
import '../../themes/text_styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.textDirection,
    this.textAlign,
    this.textStyle,
    this.hintStyle,
    this.inputFormatters,
    this.maxLines = 1,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.borderRadius = 16,
    this.fillColor,
    this.borderColor,
    this.focusBorderColor,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.prefixIconImage,
    this.prefixIconColor,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  // Content
  final String? hintText;
  final String? labelText;
  final String? initialValue;

  // Keyboard
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  // Text display
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool obscureText;

  // State
  final bool readOnly;
  final bool enabled;

  // Styling
  final double borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final EdgeInsetsGeometry? contentPadding;

  // Icons — caller builds the widget, full control
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixIconImage;
  final Color? prefixIconColor;

  // Callbacks
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmitted;
  final void Function()? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.borderRadius).r,
    borderSide: BorderSide(color: color, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    final activeBorderColor = widget.focusBorderColor ?? AppColors.primaryColor;
    final defaultBorderColor = widget.borderColor ?? AppColors.fieldBorderColor;

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      style: widget.textStyle ?? AppTextStyles.inputTextStyle,
      textAlign: widget.textAlign ?? TextAlign.start,
      textDirection: widget.textDirection,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      cursorColor: AppColors.primaryColor,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: widget.hintStyle ?? AppTextStyles.hintTextStyle,
        labelStyle: AppTextStyles.hintTextStyle,
        filled: true,
        fillColor: widget.fillColor ?? Colors.white,
        contentPadding:
            widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14).r,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        border: _border(defaultBorderColor),
        enabledBorder: _border(defaultBorderColor),
        disabledBorder: _border(defaultBorderColor),
        focusedBorder: _border(
          widget.readOnly ? Colors.transparent : activeBorderColor,
        ),
        errorBorder: _border(AppColors.errorTextColor),
        focusedErrorBorder: _border(AppColors.errorTextColor),
      ),
    );
  }

  Widget? get _prefixIcon {
    if (widget.prefixIcon != null) return widget.prefixIcon;
    if (widget.prefixIconImage == null) return null;

    return Padding(
      padding: const EdgeInsets.all(12).r,
      child: SvgPicture.asset(
        widget.prefixIconImage!,
        colorFilter: ColorFilter.mode(
          _isFocused
              ? AppColors.primaryColor
              : widget.prefixIconColor ?? AppColors.thirdColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
