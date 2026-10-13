import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laqetak/src/core/extension/space_extensions_helper.dart';
import 'package:laqetak/src/core/themes/text_styles.dart';
import 'package:laqetak/src/core/widgets/buttons_widgets/small_icon_button.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/config/app_env.dart';
import '../../../../core/constants/svg_assets.dart';
import '../../../../core/helpers/bottom_helpers.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/themes/colors.dart';
import '../../../home/presentation/cubit/ads_cubit.dart';
import '../../../home/presentation/cubit/ads_state.dart';

class AdDetailsHeader extends StatefulWidget {
  final bool isMyAd;
  final AdModel? ad;

  const AdDetailsHeader({super.key, this.isMyAd = false, this.ad});

  @override
  State<AdDetailsHeader> createState() => _AdDetailsHeaderState();
}

class _AdDetailsHeaderState extends State<AdDetailsHeader> {
  Widget _buildLike(AdModel? ad) => InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () {
      if (isAuth) {
        HapticFeedback.heavyImpact();
        context.read<AdsCubit>().toggleFavorite(ad ?? AdModel());
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
          (ad?.isFavorite ?? false)
              ? SvgAssets.assetsSvgFavFillIcon
              : SvgAssets.assetsSvgFavIconUnselected,
          key: ValueKey(ad?.isFavorite),
          width: 24.w,
          height: 24.h,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AdsCubit, AdsState, AdModel?>(
      selector: (state) => state.adDetails[widget.ad?.id],
      builder: (context, myAdDetail) {
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
                        '${S.of(context).checkOutThisAd} ${AppEnv.siteUrl}/ad/${adDetail?.id ?? ''}',
                  ),
                );
              },
              width: 20,
              height: 20,
            ),
            _buildLike(adDetail),
          ],
        );
      },
    );
  }
}
