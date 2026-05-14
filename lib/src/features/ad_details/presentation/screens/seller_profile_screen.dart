import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart'
    show AnimationConfiguration, SlideAnimation, FadeInAnimation;
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/images_assets.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/small_icon_button.dart';
import 'package:invastro/src/core/shared/widgets/custom_appbar.dart';
import 'package:invastro/src/core/shared/widgets/custom_asset_image.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:invastro/src/features/ad_details/presentation/screens/ad_details_screen.dart';
import 'package:invastro/src/features/chat/presentation/screens/chat_screen.dart';

import '../../../../core/constants/mock_data_for_loading.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/shared/widgets/items_widgets/ad_item.dart';

class SellerProfileScreen extends StatefulWidget {
  static const routeName = '/seller_profile_screen';

  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  final Set<int> _likedAds = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        icons: [AppbarIcons.logo, AppbarIcons.drawer],
        flexRight: 8,
      ),
      drawer: CustomDrawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 28).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                CustomAssetImage(
                  image: ImagesAssets.assetsImagesMockProfileImage,
                  width: 122,
                  height: 122,
                ),
                17.heightSpace,
                Text('محمد الدوسري', style: AppTextStyles.labelLarge),
                12.heightSpace,
                Text(
                  'mohamed000@gmail',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                    color: AppColors.labelSmallGreyTextColor,
                  ),
                ),
                24.heightSpace,
                Row(
                  children: [
                    45.widthSpace,
                    SmallIconButton(
                      icon: SvgAssets.assetsSvgChatDotsIcon,
                      height: 34.h,
                      width: 34.w,
                      onTab: () {
                        LocatorService.navigationService.currentState
                            ?.pushNamed(ChatScreen.routeName);
                      },
                    ),
                    Spacer(),
                    SmallIconButton(
                      icon: SvgAssets.assetsSvgReportCircle,
                      height: 34.h,
                      width: 34.w,
                      onTab: () {
                        DialogHelpers.showReportDialog();
                      },
                    ),
                    45.widthSpace,
                  ],
                ),
                10.heightSpace,
                Divider(height: 40.h, endIndent: 22.w, indent: 22.w),
                Align(
                  alignment: AlignmentGeometry.centerStart,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19.0).r,
                    child: Text(
                      'إعلانات',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 17, vertical: 24).r,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: const Duration(milliseconds: 10),
                      child: SlideAnimation(
                        verticalOffset: 10,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: AdItem(
                            type: index == 1 || index == 3
                                ? 'chance'
                                : 'not-chance',
                            expired: index == 1 || index == 3,
                            image: MockDataForLoading.mockAds[index]['image'],
                            onTab: () {
                              LocatorService.navigationService.currentState
                                  ?.pushNamed(
                                    AdDetailsScreen.routeName,
                                    arguments: {
                                      'hero':
                                          '${MockDataForLoading.mockAds[index]['image']}-$index-home',
                                      'type': index == 1 || index == 3
                                          ? 'chance'
                                          : 'not-chance',
                                      'image': MockDataForLoading
                                          .mockAds[index]['image'],
                                      'isExpired': index == 1 || index == 3,
                                      'images': <String>[
                                        MockDataForLoading
                                            .mockAds[index]['image'],
                                        ...MockDataForLoading.detailsImages,
                                      ],
                                    },
                                  );
                            },

                            hideDivider:
                                index ==
                                (MockDataForLoading.mockAds.length - 1),
                            heroTag:
                                '${MockDataForLoading.mockAds[index]['image']}-$index-home',
                            onLike: () {
                              setState(() {
                                if (_likedAds.contains(index)) {
                                  _likedAds.remove(index);
                                } else {
                                  _likedAds.add(index);
                                }
                              });
                            },
                            isLiked: _likedAds.contains(index),
                          ),
                        ),
                      ),
                    );
                  },

                  itemCount: MockDataForLoading.mockAds.length,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
