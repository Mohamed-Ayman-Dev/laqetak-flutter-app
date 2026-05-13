import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:invastro/src/core/constants/images_assets.dart';
import 'package:invastro/src/features/chat/presentation/widgets/conversation_item.dart';

import '../../../../core/di/locator_service.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/themes/colors.dart';
import 'chat_screen.dart';

class ConversationsScreen extends StatelessWidget {
  static const routeName = '/conversations_screen';

  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imagesMock = [
      ImagesAssets.assetsImagesMockPersonImage,
      ImagesAssets.assetsImagesMockPersonImage2,
      ImagesAssets.assetsImagesMockPersonImage3,
      ImagesAssets.assetsImagesMockPersonImage4,
      ImagesAssets.assetsImagesMockPersonImage5,
      ImagesAssets.assetsImagesMockPersonImage6,
      ImagesAssets.assetsImagesMockPersonImage6,
      ImagesAssets.assetsImagesMockPersonImage,
      ImagesAssets.assetsImagesMockPersonImage,
      ImagesAssets.assetsImagesMockPersonImage3,
    ];

    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBKColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 30, bottom: 100).r,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                position: index,
                delay: const Duration(milliseconds: 10),
                child: SlideAnimation(
                  verticalOffset: 10,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: ConversationItem(
                      title: index == 0
                          ? 'العنوان الخاص بالرسالة'
                          : 'العنوان الخاص بالرسالة',
                      onTab: () {
                        LocatorService.navigationService.currentState
                            ?.pushNamed(ChatScreen.routeName);
                      },
                      desc:
                          'محتوى تجريبي يمكن استبداله فيما بعد بالمحتوى الفعلي المتفق عليه مع فريق ادارة ووضع محتوى التطبيق',
                      date: 'منذ 1 ساعة',
                      image: imagesMock[index],
                      messageCount: index == 0 || index == 2 || index == 4,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => 22.heightSpace,
              itemCount: imagesMock.length,
            ),
          ],
        ),
      ),
    );
  }
}
