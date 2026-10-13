import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laqetak/src/core/constants/svg_assets.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../core/themes/theme.dart';

class QuestionStaticItem extends StatefulWidget {
  final String question;
  final String answer;

  const QuestionStaticItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<QuestionStaticItem> createState() => _QuestionStaticItemState();
}

class _QuestionStaticItemState extends State<QuestionStaticItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CustomTheme.lightTheme.copyWith(splashColor: Colors.transparent),
      child: ExpansionTile(
        minTileHeight: 56.h,
        childrenPadding: const EdgeInsets.all(0),
        onExpansionChanged: (value) {
          setState(() {
            _isExpanded = value;
          });
        },
        trailing: SizedBox(
          width: 60.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              VerticalDivider(endIndent: 10.h, indent: 10.h),
              15.widthSpace,
              SvgPicture.asset(
                _isExpanded
                    ? SvgAssets.assetsSvgExpandArrowUp
                    : SvgAssets.assetsSvgExpandArrowdown,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
        ),
        collapsedBackgroundColor: Colors.white,
        collapsedShape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.questionBorderColor,
            width: 0.7,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          widget.question,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.labelTextColor,
          ),
        ),
        children: [
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20).r,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            width: double.infinity,
            child: Column(
              children: [
                16.heightSpace,
                Text(
                  widget.answer,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.bodySmallGreyTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
