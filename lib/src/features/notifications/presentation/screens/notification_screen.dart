import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/my_icon_button.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/notifications/presentation/widgets/notification_item.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/helpers/dialog_helpers.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = '/notifications_screen';

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBKColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 25, bottom: 100).r,
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
                    child: Slidable(
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        extentRatio: 1 / 5,
                        children: [
                          CustomSlidableAction(
                            borderRadius: BorderRadius.circular(10),
                            onPressed: (_) {},
                            // ← delete logic here
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            child: Row(
                              children: [
                                10.widthSpace,
                                MyIconButton(
                                  width: 40,
                                  height: 40,
                                  onTap: () {
                                    DialogHelpers.showYesNoDialog(
                                      title: 'تأكيد الإجراء',
                                      subtitle:
                                          'هل أنت متأكد من حذف هذا التنبيه؟',
                                      onButtonTap: () {
                                        DialogHelpers.showSuccessDialog(
                                          title: "تم حذف التنبيه بنجاح",
                                        );
                                      },
                                    );
                                  },
                                  bkColor: AppColors.deleteIconButtonBKColor,
                                  icon: SvgAssets.assetsSvgDeleteIcon,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
