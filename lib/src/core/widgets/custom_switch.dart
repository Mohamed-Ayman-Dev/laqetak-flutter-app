import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../themes/colors.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.9, // ضبط الحجم قريب من الـ Figma
      alignment: AlignmentDirectional.centerEnd,
      child: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: AppColors.secondaryColor,
        thumbColor: Colors.white,
      ),
    );
  }
}
