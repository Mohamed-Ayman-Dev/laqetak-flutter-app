import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/widgets/custom_image.dart';
import 'package:invastro/src/core/shared/widgets/labels_widgets/ad_expired_label.dart';
import 'package:invastro/src/core/shared/widgets/labels_widgets/ad_label.dart';
import 'package:invastro/src/core/themes/text_styles.dart';

class AdItem extends StatelessWidget {
  final String image;
  final String heroTag;
  final bool isLiked;
  final void Function() onLike;
  final bool hideDivider;
  final void Function() onTab;
  final String type;
  final bool expired;

  const AdItem({
    super.key,
    required this.image,
    required this.heroTag,
    this.isLiked = false,
    required this.onTab,
    this.hideDivider = false,
    this.expired = false,

    required this.type,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      splashColor: Colors.transparent,

      child: Column(
        children: [
          Row(
            children: [
              _buildImage(),
              20.widthSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'مشروع تجاري كامل',
                            style: AppTextStyles.labelMedium,
                          ),
                        ),
                        2.widthSpace,
                        _buildLike(),
                      ],
                    ),
                    9.heightSpace,
                    _buildDetailItem(
                      icon: SvgAssets.assetsSvgUserFilledIcon,
                      text: 'محمد الدوسري',
                    ),
                    4.heightSpace,
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              _buildDetailItem(
                                icon: SvgAssets.assetsSvgPinFillIcon,
                                iconSize: 18,
                                text: 'الرياض',
                              ),
                              4.heightSpace,

                              _buildDetailItem(
                                icon: SvgAssets.assetsSvgCategoryIcon,
                                iconSize: 14,
                                text: 'عقاري',
                              ),
                            ],
                          ),
                        ),
                        5.widthSpace,
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailItem(
                                icon: SvgAssets.assetsSvgTimeFillIcon,
                                text: '1 ساعة',
                              ),
                              4.heightSpace,

                              Row(
                                children: [
                                  Text(
                                    '50,000',
                                    style: AppTextStyles.labelMedium.copyWith(
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  7.widthSpace,
                                  SvgPicture.asset(
                                    SvgAssets.assetsSvgSarIcon,
                                    width: 12.w,
                                    height: 12.h,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!hideDivider) Divider(height: 24.h, thickness: 1),
        ],
      ),
    );
  }

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

  Widget _buildImage() => Stack(
    alignment: Alignment.topCenter,
    children: [
      Hero(
        tag: heroTag,
        child: CustomImage(imageUrl: '', placeholder: image),
      ),
      AdLabel(labelText: type == 'chance' ? 'فرصة' : 'مستثمر'),
      if (expired) Positioned(top: 82.h, left: 72.w, child: AdExpiredLabel()),
    ],
  );

  Widget _buildDetailItem({
    required String icon,
    required String text,
    double? iconSize,
    int flex = 1,
  }) => Row(
    children: [
      SvgPicture.asset(
        icon,
        height: iconSize?.h ?? 16.h,
        width: iconSize?.w ?? 16.w,
      ),
      3.widthSpace,
      Expanded(
        flex: flex,
        child: Text(text, style: AppTextStyles.bodySmall),
      ),
    ],
  );
}
