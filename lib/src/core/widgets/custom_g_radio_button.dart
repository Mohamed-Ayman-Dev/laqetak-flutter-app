import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/text_styles.dart';
import 'custom_Text.dart';
import 'custom_radio_button.dart';

class CustomGRadioButton extends StatelessWidget {
  const CustomGRadioButton({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int groupValue;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => onChanged(value),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 20, right: 35).r,
        alignment: Alignment.center,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7).r,
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(label, style: AppTextStyles.langLabel),
            const Spacer(),
            CustomRadioButton(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
