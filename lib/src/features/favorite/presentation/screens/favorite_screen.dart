import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/themes/text_styles.dart';

import '../../../../core/constants/mock_data_for_loading.dart';
import '../../../../core/shared/widgets/items_widgets/ad_item.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite_screen';

  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final Set<int> _likedAds = {0, 1, 2, 3, 4, 5};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الإعلانات المفضلة',
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
                          type: index == 1 || index == 3
                              ? 'chance'
                              : 'not-chance',
                          expired: index == 1 || index == 3,
                          image: MockDataForLoading.mockAds[index]['image'],
                          onTab: () {},

                          hideDivider:
                              index == (MockDataForLoading.mockAds.length - 1),
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
            ),
          ],
        ),
      ),
    );
  }
}
