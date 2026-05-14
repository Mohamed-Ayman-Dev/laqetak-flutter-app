import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/models/app_photo.dart';
import '../../../../core/shared/widgets/photoview.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/text_styles.dart';

class MessageItem extends StatelessWidget {
  final String message;
  final String? image;
  final String? heroImage;

  final bool isUser;

  const MessageItem({
    super.key,
    required this.message,
    required this.heroImage,
    this.image,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: () => context.pushTransparentRoute(
              PhotoView(
                heroTag: heroImage,
                photoList: [
                  image,
                ].map((e) => AppPhoto(url: e, source: 'asset')).toList(),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 260.w,
                    minWidth: 50.w,
                    minHeight: 34.h,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8).r,
                  decoration: BoxDecoration(
                    color: isUser
                        ? AppColors.myMessageBKColor
                        : AppColors.otherMessageBKColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(isUser ? 0 : 12),
                      topLeft: Radius.circular(isUser ? 12 : 0),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.labelTextColor,
                        ),
                      ),
                      if (image != null) 8.heightSpace,
                      if (image != null)
                        Hero(
                          tag: heroImage!,
                          child: Image.asset(
                            image!,
                            width: 140.w,
                            height: 137.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isUser)
                        SvgPicture.asset(
                          SvgAssets.assetsSvgReadedMessageIcon,
                          height: 15.h,
                          width: 15.w,
                        ),
                      if (!isUser) 7.widthSpace,
                      Text(
                        isUser ? '10:15 ص' : 'تم القراءة -  10:20 ص',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 8.sp,
                          color: AppColors.bodySmallGreyTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
