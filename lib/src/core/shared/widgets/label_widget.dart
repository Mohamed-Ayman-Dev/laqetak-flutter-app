import 'package:flutter/material.dart';

import '../../extension/space_extensions_helper.dart';
import '../../themes/text_styles.dart';

class LabelWidget extends StatelessWidget {
  final String text;
  final double? space;

  const LabelWidget({super.key, required this.text, this.space});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: AppTextStyles.labelSmall),
        space?.heightSpace ?? 8.heightSpace,
      ],
    );
  }
}
