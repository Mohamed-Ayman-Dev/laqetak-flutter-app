import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/extension/space_extensions_helper.dart';

import '../../../../core/constants/svg_assets.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/themes/theme.dart';
import '../../../../core/widgets/items_widgets/detail_item.dart';

class AdDetailsPoints extends StatelessWidget {
  final AdModel? ad;

  const AdDetailsPoints({super.key, this.ad});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        border: Border.all(
          color: AppColors.containerBorderColor.withOpacity(0.23),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              6.widthSpace,
              Expanded(
                child: DetailItem(
                  icon: SvgAssets.assetsSvgPinOutilned,
                  iconSize: 18,
                  text: ad?.city?.name ?? '',
                ),
              ),
              DetailItem(
                icon: SvgAssets.assetsSvgTimeFillIcon,
                iconSize: 18,
                text: ad?.publishedAt ?? '',
              ),
              6.widthSpace,
            ],
          ),
          Divider(height: 18.h, color: AppColors.detailsDividerColor),
          Row(
            children: [
              6.widthSpace,
              Expanded(
                child: DetailItem(
                  icon: SvgAssets.assetsSvgChance,
                  iconSize: 20,
                  text: ad?.category?.name ?? '',
                ),
              ),
            ],
          ),
          Divider(height: 18.h, color: AppColors.detailsDividerColor),
          Row(
            children: [
              6.widthSpace,
              Expanded(
                child: DetailItem(
                  icon: SvgAssets.assetsSvgCategoryIcon,
                  iconSize: 14,
                  text: ad?.sector?.name ?? '',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
