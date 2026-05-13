import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/images_assets.dart';
import 'package:invastro/src/core/themes/theme.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../widgets/chat_bottom_field.dart';
import '../widgets/chat_time.dart';
import '../widgets/message_item.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat_screen';

  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBKColor,
      appBar: CustomAppbar(
        icons: [AppbarIcons.chat],
        backgroundColor: Colors.white,
      ),

      body: Column(
        children: [
          10.heightSpace,

          Align(alignment: Alignment.center, child: ChatTime()),
          10.heightSpace,

          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(18, 33, 18, 18).r,
              itemBuilder: (context, index) => MessageItem(
                message: index == 0
                    ? 'مرحباً، عبد الله'
                    : index == 1
                    ? 'مرحباً، ا. استاذ أحمد عبد الرحمن'
                    : index == 2
                    ? 'هل الإعلان الخاص بالعقار ماذال متوفر'
                    : index == 4
                    ? 'نعم ياصديقي ماذال متوفر'
                    : "شكرا لك ",
                isUser: index == 1 || index == 4 ? false : true,
                image: index == 3 ? ImagesAssets.assetsImagesMockAd4 : null,
              ),
              separatorBuilder: (context, index) => 16.heightSpace,
              itemCount: 10,
            ),
          ),
          ChatBottomField(
            onSend: () {},
            onAttachment: () {},
            controller: TextEditingController(),
          ),
        ],
      ),
    );
  }
}
