import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/themes/colors.dart';

class AttachmentPreview extends StatelessWidget {
  final List<String> filePaths;
  final VoidCallback onClear;
  final Function(int)? onRemoveAt;

  const AttachmentPreview({
    super.key,
    required this.filePaths,
    required this.onClear,
    this.onRemoveAt,
  });

  @override
  Widget build(BuildContext context) {
    if (filePaths.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10).r,
      decoration: BoxDecoration(
        color: AppColors.greyScaffoldBKColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)).r,
        border: Border(
          top: BorderSide(color: AppColors.dividerColor, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.attach_file,
                size: 16.sp,
                color: AppColors.primaryColor,
              ),
              4.widthSpace,
              Text(
                '${S.of(context).attachments} (${filePaths.length})',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              InkWell(
                onTap: onClear,
                child: Container(
                  padding: EdgeInsets.all(4).r,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, size: 16.sp, color: Colors.red),
                ),
              ),
            ],
          ),
          10.heightSpace,
          SizedBox(
            height: 80.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filePaths.length,
              separatorBuilder: (context, index) => 8.widthSpace,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Image.file(
                        File(filePaths[index]),
                        width: 90.w,
                        height: 80.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 90.w,
                            height: 80.h,
                            color: Colors.grey.shade300,
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          );
                        },
                      ),
                      if (onRemoveAt != null)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: InkWell(
                            onTap: () => onRemoveAt!(index),
                            child: Container(
                              padding: EdgeInsets.all(2).r,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
