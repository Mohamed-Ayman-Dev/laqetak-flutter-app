import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/helpers/dialog_helpers.dart';
import 'package:invastro/src/core/shared/widgets/custom_appbar.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/add_ad_screen.dart';

import '../../../../core/constants/mock_data_for_loading.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/shared/widgets/items_widgets/ad_item.dart';
import '../../../ad_details/presentation/screens/ad_details_screen.dart';

class MyAdsScreen extends StatefulWidget {
  static const routeName = '/my_ads_screen';

  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  final Set<int> _likedAds = {0, 1, 2, 3, 4, 5};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(icons: [AppbarIcons.logo], flexRight: 9),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'إعلاناتي',
              style: AppTextStyles.labelMedium.copyWith(fontSize: 16.sp),
            ),
            16.heightSpace,
            Expanded(
              child: ListView.builder(
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
                          category: index == 1 || index == 3
                              ? 'chance'
                              : 'not-chance',
                          expired: index == 1 || index == 3,
                          onDelete: () {
                            DialogHelpers.showYesNoDialog(
                              title: 'تأكيد الإجراء',
                              subtitle: 'هل أنت متأكد من حذف هذا الاعلان؟',
                              onButtonTap: () {
                                DialogHelpers.showSuccessDialog(
                                  title: "تم حذف الاعلان بنجاح",
                                );
                              },
                            );
                          },
                          onEdit: () {
                            LocatorService.navigationService.currentState
                                ?.pushNamed(
                                  AddAdScreen.routeName,
                                  arguments: true,
                                );
                          },
                          views: 1200,
                          isMyAd: true,
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
                                    'isMyAd': true,
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
                              index == (MockDataForLoading.mockAds.length - 1),
                          heroTag:
                              '${MockDataForLoading.mockAds[index]['image']}-$index-my-ads',
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
            ),
          ],
        ),
      ),
    );
  }
}
