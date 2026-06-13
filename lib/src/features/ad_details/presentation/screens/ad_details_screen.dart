import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/helpers/dialog_helpers.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/custom_outline_button.dart';
import 'package:invastro/src/core/shared/widgets/custom_appbar.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:invastro/src/features/ad_details/presentation/widgets/ad_details_bottom.dart';
import 'package:invastro/src/features/ad_details/presentation/widgets/ad_details_desc.dart';
import 'package:invastro/src/features/ad_details/presentation/widgets/ad_details_header.dart';
import 'package:invastro/src/features/ad_details/presentation/widgets/ad_details_points.dart';
import 'package:invastro/src/features/ad_details/presentation/widgets/ad_details_seller.dart';
import 'package:invastro/src/features/ad_details/presentation/widgets/ad_image_gallery.dart';
import 'package:invastro/src/features/ad_details/presentation/widgets/shimmers/ad_image_gallery_shimmer.dart';
import 'package:invastro/src/features/home/presentation/controllers/ads_controller.dart';
import 'package:invastro/src/features/home/presentation/providers/ads.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/add_ad_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/shared/models/ad_model.dart';

class AdDetailsScreen extends StatefulWidget {
  static const routeName = '/ad_details_screen';

  const AdDetailsScreen({super.key});

  @override
  State<AdDetailsScreen> createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {
  bool isMyAd = false;
  String? adHero;
  bool once = false;
  AdModel? ad;

  @override
  void didChangeDependencies() {
    if (!once) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        adHero = args['hero'];
        ad = args['ad'];
        isMyAd = args['isMyAd'] ?? false;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AdsController.getAdDetails(ad?.id ?? 0);
      });
      once = true;
    }

    super.didChangeDependencies();
  }

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        icons: [AppbarIcons.logo, AppbarIcons.drawer],
        flexRight: 8,
      ),
      drawer: CustomDrawer(),
      body: Selector<Ads, AdModel?>(
        selector: (context, provider) => provider.myAdDetails[ad?.id],
        builder: (context, updatedAdDetail, child) {
          final adDetail = updatedAdDetail ?? ad;
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdDetailsHeader(isMyAd: isMyAd, ad: adDetail),
                    20.heightSpace,
                    adDetail?.photos == null
                        ? AdImageGalleryShimmer()
                        : AdImageGallery(
                            images:
                                adDetail?.photos
                                    ?.map((e) => e.url ?? '')
                                    .toList() ??
                                [],
                            type: adDetail?.category?.name ?? '',
                            hero: adHero ?? '',
                            isExpired: false,
                          ),
                    15.heightSpace,
                    AdDetailsPoints(ad: adDetail),
                    17.heightSpace,
                    Text('تفاصيل الإعلان', style: AppTextStyles.labelMedium),
                    11.heightSpace,
                    AdDetailsDesc(desc: adDetail?.description),
                    16.heightSpace,
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: CustomOutlineButton(
                        text: 'الإبلاغ عن الإعلان',
                        textStyle: AppTextStyles.buttonsTextStyle.copyWith(
                          color: AppColors.labelTextColor,
                          fontSize: 12.sp,
                        ),
                        size: Size(123.w, 36.h),
                        borderColor: AppColors.reportBorderColor,
                        onPressed: () {
                          DialogHelpers.showReportDialog(ad?.id ?? 0);
                        },
                      ),
                    ),
                    Text('تفاصيل المعلن', style: AppTextStyles.labelMedium),
                    12.heightSpace,
                    AdDetailsSeller(
                      customer: adDetail?.customer,
                      phone: adDetail?.contactPhone,
                      isMyAd: isMyAd,
                      hidePhone: adDetail?.hidePhone == 1,
                    ),
                    if (isMyAd) 22.heightSpace,
                    if (isMyAd)
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              text: 'تعديل الإعلان',
                              onPressed: () {
                                LocatorService.navigationService.currentState
                                    ?.pushNamed(
                                      AddAdScreen.routeName,
                                      arguments: true,
                                    );
                              },
                            ),
                          ),
                          11.widthSpace,
                          Expanded(
                            child: CustomOutlineButton(
                              text: 'إعلان منتهي',
                              borderRadius: 8,
                              borderColor: AppColors.reportBorderColor,
                              onPressed: () {
                                DialogHelpers.showSuccessDialog(title: 'title');
                              },
                            ),
                          ),
                        ],
                      ),
                    110.heightSpace,
                  ],
                ),
              ),
              AdDetailsBottom(price: adDetail?.investmentAmount),
            ],
          );
        },
      ),
    );
  }
}
