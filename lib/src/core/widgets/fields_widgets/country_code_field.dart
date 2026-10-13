import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laqetak/src/core/constants/svg_assets.dart';

import '../../extension/space_extensions_helper.dart';
import '../../themes/colors.dart';
import '../../themes/text_styles.dart';

class CountryCodeField extends StatefulWidget {
  final void Function(CountryCode? value) onChanged;
  final void Function(CountryCode? value) onInit;
  final FocusNode? focusNode;
  final TextStyle? textStyle;

  const CountryCodeField({
    super.key,
    required this.onChanged,
    required this.onInit,
    this.textStyle,
    this.focusNode,
  });

  @override
  State<CountryCodeField> createState() => _CountryCodeFieldState();
}

class _CountryCodeFieldState extends State<CountryCodeField> {
  late FocusNode _internalFocusNode;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = FocusNode();
    _effectiveFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {}); // Just rebuild to update border color
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused = _effectiveFocusNode.hasFocus;

    return Container(
      width: 70.w,

      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      // padding: EdgeInsets.symmetric(vertical: 10),
      child: CountryCodePicker(
        textStyle: widget.textStyle,
        showFlagMain: false,
        padding: EdgeInsets.zero,
        barrierColor: Colors.grey.withOpacity(0.3),
        boxDecoration: const BoxDecoration(shape: BoxShape.rectangle),
        searchStyle: AppTextStyles.inputTextStyle,
        dialogTextStyle: AppTextStyles.labelMedium,
        searchDecoration: InputDecoration(
          labelStyle: AppTextStyles.labelMedium.copyWith(color: Colors.black),
          iconColor: AppColors.fieldBorderColor,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: widget.onChanged,
        onInit: widget.onInit,
        initialSelection: '+966',
        // 👇 This only affects the main view, not the popup
        builder: (code) {
          return Directionality(
            textDirection: TextDirection.ltr, // 👈 Forces left-to-right layout
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                10.widthSpace,

                Text(
                  '${code?.dialCode}',
                  style:
                      widget.textStyle ??
                      AppTextStyles.labelSmall.copyWith(
                        color: AppColors.labelGreyTextColor,
                        letterSpacing: 0.6,
                      ),
                ),
                2.widthSpace,
                SvgPicture.asset(
                  SvgAssets.assetsSvgArrowDown,
                  width: 16.w,
                  height: 16.h,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
