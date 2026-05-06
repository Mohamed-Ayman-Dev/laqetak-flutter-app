import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Spacing on num {
  // For vertical spacing
  Widget get heightSpace => SizedBox(height: h.h);

  // For horizontal spacing
  Widget get widthSpace => SizedBox(width: w.w);
}
