import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laqetak/src/core/constants/svg_assets.dart';
import 'package:laqetak/src/core/helpers/others_helper.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/themes/colors.dart';

class ChatBottomField extends StatelessWidget {
  final Function() onSend;
  final Function() onAttachment;
  final TextEditingController controller;

  const ChatBottomField({
    super.key,
    required this.onSend,
    required this.onAttachment,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.chatFieldBorderColor)),
      ),
      padding: EdgeInsets.only(top: 16, right: 12, left: 12, bottom: 30).r,
      child: Row(
        children: [
          isArabic ? _buildAttachmentButton() : _buildSendButton(),
          Expanded(
            child: CustomTextField(
              hintText: S.of(context).writeAMessage,
              borderRadius: 80,
              controller: controller,
              borderColor: AppColors.chatFieldBorderColor,
            ),
          ),
          isArabic ? _buildSendButton() : _buildAttachmentButton(),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return InkWell(
      onTap: onAttachment,
      child: Padding(
        padding: const EdgeInsets.all(8.0).r,
        child: SvgPicture.asset(
          SvgAssets.assetsSvgFileIcon,
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }

  Widget _buildAttachmentButton() {
    return InkWell(
      onTap: onSend,
      child: Padding(
        padding: const EdgeInsets.all(8.0).r,
        child: SvgPicture.asset(
          SvgAssets.assetsSvgSendIcon,
          width: 36.w,
          height: 36.h,
        ),
      ),
    );
  }
}
