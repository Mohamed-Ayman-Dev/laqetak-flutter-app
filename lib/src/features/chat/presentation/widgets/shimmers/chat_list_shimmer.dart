import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extension/space_extensions_helper.dart';
import 'message_item_shimmer.dart';

class ChatListShimmer extends StatelessWidget {
  const ChatListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(18, 33, 18, 18).r,
        reverse: true,

        itemBuilder: (context, index) =>
            MessageItemShimmer(isMine: index % 2 == 0),
        separatorBuilder: (context, index) => 16.heightSpace,
        itemCount: 9,
      ),
    );
  }
}
