import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/notifications/presentation/widgets/notification_item.dart';

import '../../../../core/extension/space_extensions_helper.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = '/notifications_screen';

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.notificationScaffoldBKColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 25, bottom: 100).r,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                position: index,
                delay: const Duration(milliseconds: 30),
                child: SlideAnimation(
                  verticalOffset: 20,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: NotificationItem(
                      title: index == 0
                          ? 'تجاوز سرعة'
                          : 'العنوان الخاص بالإشعار',
                      desc: index == 0
                          ? 'محتوى تجريبي يمكن استبداله فيما بعد بالمحتوى الفعلي المتفق عليه مع فريق ادارة ووضع محتوى التطبيق'
                          : 'محتوى تجريبي يمكن استبداله فيما بعد بالمحتوى الفعلي المتفق عليه مع فريق ادارة ووضع محتوى التطبيق',
                      date: 'منذ 1 ساعة',
                      messageCount: index == 0 || index == 2,
                      isSeen: index != 4 && index != 6,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => 15.heightSpace,
              itemCount: 7,
            ),
          ],
        ),
      ),
    );
  }
}
