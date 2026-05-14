import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/small_icon_button.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/core/themes/text_styles.dart';

import '../../../../core/constants/svg_assets.dart';

class AdDetailsHeader extends StatefulWidget {
  final bool isMyAd;

  const AdDetailsHeader({super.key, this.isMyAd = false});

  @override
  State<AdDetailsHeader> createState() => _AdDetailsHeaderState();
}

class _AdDetailsHeaderState extends State<AdDetailsHeader> {
  void onLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  bool isLiked = false;

  Widget _buildLike() => InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () {
      HapticFeedback.mediumImpact();
      onLike();
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        switchInCurve: Curves.elasticOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: SvgPicture.asset(
          isLiked
              ? SvgAssets.assetsSvgFavFillIcon
              : SvgAssets.assetsSvgFavIconUnselected,
          key: ValueKey(isLiked),
          // ← required for AnimatedSwitcher to detect change
          width: 24.w,
          height: 24.h,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            'مشروع تجاري كامل',
            style: AppTextStyles.labelLarge.copyWith(fontSize: 15.sp),
          ),
        ),
        5.widthSpace,
        Text(
          '1200',
          style: AppTextStyles.labelSmall.copyWith(
            fontSize: 13.sp,
            color: AppColors.textGrey1Color,
          ),
        ),
        if (widget.isMyAd) ...[
          7.widthSpace,
          SvgPicture.asset(SvgAssets.assetsSvgView, height: 32.h, width: 32.w),
          7.widthSpace,
        ],

        SmallIconButton(
          icon: SvgAssets.assetsSvgShareIcon,
          onTab: () {},
          width: 20,
          height: 20,
        ),
        _buildLike(),
      ],
    );
  }
}
