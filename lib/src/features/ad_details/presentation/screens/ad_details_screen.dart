import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/small_icon_button.dart';
import 'package:invastro/src/core/shared/widgets/custom_appbar.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:invastro/src/features/ad_details/presentation/widgets/ad_image_gallery.dart';

import '../../../../core/constants/svg_assets.dart';

class AdDetailsScreen extends StatefulWidget {
  static const routeName = '/ad_details_screen';

  const AdDetailsScreen({super.key});

  @override
  State<AdDetailsScreen> createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {
  String? adType;

  String? adImage;

  String? adHero;

  bool isExpired = false;
  bool once = false;

  List<String> images = [];

  @override
  void didChangeDependencies() {
    if (!once) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        images = args['images'];
        adType = args['type'];
        adImage = args['image'];
        adHero = args['hero'];
        isExpired = args['isExpired'] ?? false;
      }
      once = true;
    }

    super.didChangeDependencies();
  }

  bool isLiked = false;

  void onLike() {
    setState(() {
      isLiked = !isLiked;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        icons: [AppbarIcons.logo, AppbarIcons.drawer],
        flexRight: 8,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 25).r,
        child: Column(
          children: [
            // AdDetailsHeader(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'مشروع تجاري كامل',
                    style: AppTextStyles.labelLarge.copyWith(fontSize: 15.sp),
                  ),
                ),
                5.widthSpace,
                SmallIconButton(
                  icon: SvgAssets.assetsSvgShareIcon,
                  onTab: () {},
                  width: 20,
                  height: 20,
                ),
                _buildLike(),
              ],
            ),
            22.heightSpace,
            AdImageGallery(
              images: images,
              type: adType ?? '',
              hero: adHero ?? '',
              image: adImage ?? '',
              isExpired: isExpired,
            ),
            15.heightSpace,
          ],
        ),
      ),
    );
  }
}
