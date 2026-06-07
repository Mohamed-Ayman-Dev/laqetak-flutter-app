import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/widgets/items_widgets/detail_item.dart';
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
  final String category;
  final bool expired;
  final bool isMyAd;
  final String? name;
  final String? location;
  final String? sector;

  final String? price;
  final String? time;
  final String? customerName;
  final void Function()? onDelete;
  final void Function()? onEdit;
  final int? views;

  const AdItem({
    super.key,
    required this.image,
    required this.heroTag,
    this.isLiked = false,
    this.sector,
    required this.onTab,
    this.hideDivider = false,
    this.expired = false,
    this.name,
    this.location,
    this.price,
    this.time,
    this.customerName,
    this.isMyAd = false,
    this.onDelete,
    this.onEdit,
    this.views,
    required this.category,
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
                            name ?? '',
                            style: AppTextStyles.labelMedium,
                          ),
                        ),
                        2.widthSpace,
                        isMyAd
                            ? _buildButton(
                                onTap: () {
                                  onEdit!();
                                },
                                icon: SvgAssets.assetsSvgEditIcon,
                              )
                            : _buildLike(),
                        if (isMyAd)
                          _buildButton(
                            onTap: () {
                              onDelete!();
                            },
                            icon: SvgAssets.assetsSvgDeleteIcon,
                          ),
                      ],
                    ),
                    9.heightSpace,
                    Row(
                      children: [
                        DetailItem(
                          icon: SvgAssets.assetsSvgUserFilledIcon,
                          text: customerName ?? ';',
                          maxLines: 2,
                        ),
                        if (isMyAd)
                          DetailItem(
                            icon: SvgAssets.assetsSvgView,
                            iconSize: 21,
                            text: (views ?? 0).toString(),
                            maxLines: 2,
                          ),
                        if (isMyAd) 37.widthSpace,
                      ],
                    ),
                    4.heightSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailItem(
                                icon: SvgAssets.assetsSvgPinFillIcon,
                                iconSize: 18,
                                maxLines: 2,
                                text: location ?? '',
                              ),
                              4.heightSpace,

                              DetailItem(
                                icon: SvgAssets.assetsSvgCategoryIcon,
                                iconSize: 14,
                                text: sector ?? '',
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        5.widthSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 70.w,
                              child: DetailItem(
                                icon: SvgAssets.assetsSvgTimeFillIcon,
                                text: time ?? '',
                                maxLines: 2,
                              ),
                            ),
                            4.heightSpace,

                            Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                SizedBox(
                                  width: 70.w,

                                  child: Text(
                                    price ?? '',
                                    style: AppTextStyles.labelMedium.copyWith(
                                      fontSize: 15.sp,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                SvgPicture.asset(
                                  SvgAssets.assetsSvgSarIcon,
                                  width: 12.w,
                                  height: 12.h,
                                ),
                              ],
                            ),
                          ],
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

  Widget _buildButton({required VoidCallback onTap, required String icon}) =>
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(3.0).r,
          child: SvgPicture.asset(icon, width: 24.w, height: 24.h),
        ),
      );

  Widget _buildImage() => Stack(
    alignment: Alignment.topCenter,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          height: 108.h,
          width: 133.w,
        ),
      ),
      AdLabel(labelText: category ?? ''),
      if (expired) Positioned(top: 82.h, left: 72.w, child: AdExpiredLabel()),
    ],
  );
}
