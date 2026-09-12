import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';
import '../custom_Text.dart';

class ListSliverLoadingEndWidget extends StatelessWidget {
  final int? lastPage;
  final int? currentPage;
  final bool isLoading;
  final bool listLessThan;
  final String title;

  const ListSliverLoadingEndWidget({
    super.key,
    this.lastPage,
    this.currentPage,
    required this.isLoading,
    required this.listLessThan,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 120).r,
      sliver: (lastPage == currentPage && !isLoading && listLessThan)
          ? SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: CustomText(
                      title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : (isLoading && listLessThan)
          ? SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 0).r,
                    child: SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Platform.isIOS
                          ? CupertinoActivityIndicator(
                              color: AppColors.primaryColor,
                            )
                          : CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primaryColor,
                            ),
                    ),
                  ),
                ],
              ),
            )
          : SliverToBoxAdapter(child: Container()),
    );
  }
}
