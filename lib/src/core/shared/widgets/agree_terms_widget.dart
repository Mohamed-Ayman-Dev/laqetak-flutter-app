import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/l10n.dart';
import '../../extension/space_extensions_helper.dart';
import '../../themes/text_styles.dart';
import 'custom_checkbox.dart';

class AgreeTermsWidget extends StatelessWidget {
  final void Function() onTermsPressed;
  final void Function() onTextPressed;

  final bool isChecked;
  final String? text;

  const AgreeTermsWidget({
    super.key,
    required this.onTermsPressed,
    required this.isChecked,
    this.text,
    required this.onTextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTermsPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCheckbox(
              isChecked: isChecked,
              onTap: (val) {
                onTermsPressed();
              },
            ),
            14.widthSpace,
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 12.sp),
                  children: [
                    // TextSpan(
                    //   text: S.of(context).iAgreeTo,
                    //   style: AppTextStyles.labelSmall.copyWith(fontSize: 12.sp),
                    // ),
                    TextSpan(
                      text: text ?? S.current.termsConditions,
                      recognizer: TapGestureRecognizer()..onTap = onTextPressed,
                      style: AppTextStyles.labelSmall,
                    ),
                    // TextSpan(
                    //   text: S.of(context).platformSpecific,
                    //   style: AppTextStyles.labelSmall.copyWith(fontSize: 12.sp),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
