import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/small_icon_button.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:invastro/src/features/home/presentation/providers/ads.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/svg_assets.dart';
import '../../../../core/helpers/bottom_helpers.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/themes/colors.dart';
import '../../../home/presentation/controllers/ads_controller.dart';

class AdDetailsHeader extends StatefulWidget {
  final bool isMyAd;
  final AdModel? ad;

  const AdDetailsHeader({super.key, this.isMyAd = false, this.ad});

  @override
  State<AdDetailsHeader> createState() => _AdDetailsHeaderState();
}

class _AdDetailsHeaderState extends State<AdDetailsHeader> {
  Widget _buildLike() => InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () {
      if (isAuth) {
        HapticFeedback.heavyImpact();
        AdsController.addOrRemoveAdFromFavorites(ad: widget.ad ?? AdModel());
      } else {
        BottomHelpers.showGuestBottomSheet(context);
      }
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
          (widget.ad?.isFavorite ?? false)
              ? SvgAssets.assetsSvgFavFillIcon
              : SvgAssets.assetsSvgFavIconUnselected,
          // ← required for AnimatedSwitcher to detect change
          width: 24.w,
          height: 24.h,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Selector<Ads, AdModel?>(
      selector: (context, provider) => provider.myAdDetails[widget.ad?.id],
      shouldRebuild: (previous, next) => true,
      builder: (context, myAdDetail, child) {
        final adDetail = myAdDetail ?? widget.ad;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                adDetail?.title ?? '',
                style: AppTextStyles.labelLarge.copyWith(fontSize: 15.sp),
              ),
            ),
            5.widthSpace,
            if (widget.isMyAd)
              Text(
                ((adDetail?.viewsCount != null)
                    ? adDetail?.viewsCount.toString() ?? '0'
                    : '0'),
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 13.sp,
                  color: AppColors.textGrey1Color,
                ),
              ),
            if (widget.isMyAd) ...[
              5.widthSpace,
              SvgPicture.asset(
                SvgAssets.assetsSvgView,
                height: 32.h,
                width: 32.w,
              ),
              7.widthSpace,
            ],

            SmallIconButton(
              icon: SvgAssets.assetsSvgShareIcon,
              onTab: () {
                SharePlus.instance.share(
                  ShareParams(
                    text:
                        '${S.of(context).checkOutThisAd} https://invastro.dev4.wady.sa/ad/${adDetail?.id ?? ''}',
                  ),
                );
              },
              width: 20,
              height: 20,
            ),
            _buildLike(),
          ],
        );
      },
    );
  }
}
