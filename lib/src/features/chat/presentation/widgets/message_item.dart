import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/extension/format_date_time_on_date_time.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/models/photo_model.dart';
import '../../../../core/shared/widgets/photoview.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/text_styles.dart';
import '../../data/models/message_file_model.dart';

class MessageItem extends StatelessWidget {
  final String message;
  final List<MessageFileModel>? images;
  final String? seenAt;
  final String createdAt;

  final String? heroImage;
  final bool isTemp;
  final MessageStatus? status;
  final VoidCallback? onRetry;
  final bool isMine;

  const MessageItem({
    super.key,
    required this.message,
    required this.heroImage,
    this.images,
    required this.isMine,
    this.seenAt,
    required this.createdAt,
    required this.isTemp,
    this.status,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 260.w,
                  minWidth: 50.w,
                  minHeight: 34.h,
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8).r,
                decoration: BoxDecoration(
                  color: isMine
                      ? AppColors.myMessageBKColor
                      : AppColors.otherMessageBKColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(isMine ? 0 : 12),
                    topLeft: Radius.circular(isMine ? 12 : 0),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (message.isNotEmpty)
                      Text(
                        message,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.labelTextColor,
                        ),
                      ),
                    if (images != null && images!.isNotEmpty) 8.heightSpace,
                    if (images != null && images!.isNotEmpty)
                      _buildImagesSection(context),
                    // if (image != null) 8.heightSpace,
                    // if (image != null)
                    //   Hero(
                    //     tag: heroImage!,
                    //     child: Image.asset(
                    //       image!,
                    //       width: 140.w,
                    //       height: 137.h,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                  ],
                ),
              ),
              if (status == MessageStatus.sending)
                Padding(
                  padding: EdgeInsets.only(top: 4).r,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 12.w,
                        height: 12.h,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                      4.widthSpace,
                      Text(
                        S.of(context).sending,
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 8.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              if (status == MessageStatus.failed && onRetry != null)
                Padding(
                  padding: EdgeInsets.only(top: 4).r,
                  child: GestureDetector(
                    onTap: onRetry,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 12.sp,
                          color: Colors.red,
                        ),
                        4.widthSpace,
                        Text(
                          S.of(context).tapToRetry,
                          style: AppTextStyles.labelSmall.copyWith(
                            fontSize: 8.sp,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (status == MessageStatus.sent)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      12.widthSpace,
                      if (isMine)
                        SvgPicture.asset(
                          SvgAssets.assetsSvgReadedMessageIcon,
                          height: 15.h,
                          width: 15.w,
                          color: seenAt == null
                              ? Colors.grey
                              : AppColors.primaryColor,
                        ),
                      if (isMine) 7.widthSpace,
                      Text(
                        (!isMine || seenAt == null)
                            ? DateTime.parse(createdAt).timeAgo
                            : 'تم القراءة -  $seenAt',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 8.sp,
                          color: AppColors.bodySmallGreyTextColor,
                        ),
                      ),
                      12.widthSpace,
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImagesSection(BuildContext context) {
    if (images == null || images!.isEmpty) {
      return const SizedBox.shrink();
    }

    final count = images!.length;

    if (count == 1) {
      return _buildSingleImage(context, images![0], 0);
    }

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count > 4 ? 4 : count,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        childAspectRatio: 80 / 100,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return _buildSingleImage(context, images![index], index);
      },
    );
  }

  Widget _buildSingleImage(
    BuildContext context,
    MessageFileModel image,
    int index,
  ) {
    final imageUrl = image.preview ?? image.original ?? '';
    if (image.isFile) {
      print(image.preview);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          final photoList = images!
              .map<PhotoModel>(
                (e) => PhotoModel(
                  source: isTemp || e.isFile ? 'file' : 'network',
                  url: e.original ?? e.preview ?? '',
                ),
              )
              .toList();
          context.pushTransparentRoute(
            PhotoView(heroTag: "heroImage-$index", photoList: photoList),
          );
        },
        child: isTemp || image.isFile
            ? Image.file(
                File(imageUrl),
                width: 140.w,
                height: 137.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildErrorPlaceholder();
                },
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                width: 140.w,
                height: 137.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 140.w,
                  height: 137.h,
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) {
                  return _buildErrorPlaceholder();
                },
              ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: 140.w,
      height: 137.h,
      color: Colors.grey.shade300,
      child: const Icon(Icons.broken_image, color: Colors.grey),
    );
  }
}
