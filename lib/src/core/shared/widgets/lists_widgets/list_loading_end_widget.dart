import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';
import '../custom_Text.dart';

class ListLoadingEndWidget extends StatelessWidget {
  final int lastPage;
  final int currentPage;
  final bool isLoading;
  final bool listLessThan;
  final String noMoreText;
  final double? paddingBottom;
  final double? paddingTop;

  const ListLoadingEndWidget({
    super.key,
    required this.lastPage,
    required this.currentPage,
    required this.isLoading,
    required this.listLessThan,
    required this.noMoreText,
    this.paddingBottom,
    this.paddingTop,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: (lastPage == currentPage && !isLoading && listLessThan)
          ? Padding(
              padding: EdgeInsets.only(
                bottom: paddingBottom ?? 100.0,
                top: paddingTop ?? 0.0,
              ).r,
              child: CustomText(
                noMoreText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            )
          : (isLoading && listLessThan)
          ? Padding(
              padding: EdgeInsets.only(
                bottom: paddingBottom ?? 150,
                top: paddingTop ?? 0.0,
              ),
              child: SizedBox(
                height: 20,
                width: 20,
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator(
                        color: AppColors.primaryColor,
                      )
                    : const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      ),
              ),
            )
          : Container(),
    );
  }
}
