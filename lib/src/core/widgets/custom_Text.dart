import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final TextStyle? style;
  final String text;
  final bool? softWrap;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  const CustomText(this.text,
      {super.key,
      this.style,
      this.textAlign,
      this.softWrap,
      this.maxLines,
      this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        softWrap: softWrap,
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.ellipsis,
        style: style);
  }
}
