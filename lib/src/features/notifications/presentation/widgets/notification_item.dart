import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/widgets/buttons_widgets/custom_elevated_button.dart';
import 'package:invastro/src/core/widgets/buttons_widgets/custom_outline_button.dart';
import 'package:invastro/src/core/themes/text_styles.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/svg_assets.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/contact_request_model.dart';
import '../../../../core/widgets/notify_circle.dart';
import '../../../../core/themes/colors.dart';
import '../../../ad_details/presentation/screens/ad_details_screen.dart';
import '../controllers/notifications_controller.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String desc;
  final int index;
  final String date;
  final bool isSeen;
  final String? rawData;
  final bool messageCount;

  const NotificationItem({
    super.key,
    required this.title,
    required this.desc,
    required this.index,
    required this.date,
    required this.rawData,
    this.isSeen = false,
    this.messageCount = false,
  });

  @override
  Widget build(BuildContext context) {
    ContactRequestModel? request;
    if (rawData != null && rawData is String && rawData!.isNotEmpty) {
      if (rawData!.contains('contact_request_id')) {
        request = ContactRequestModel.fromJson(rawData);
      }
    }
    return GestureDetector(
      onTap: () {
        if (request?.adId != null) {
          LocatorService.navigationService.currentState?.pushNamed(
            AdDetailsScreen.routeName,
            arguments: {
              'hero': '$index-$desc-$rawData-notifications',
              'ad': AdModel(id: request?.adId),
            },
          );
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15.0).r,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15).r,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildIcon(),
            10.widthSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(title, style: AppTextStyles.labelLarge),
                      ),
                      2.widthSpace,
                      Text(
                        date,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10.sp,
                          color: AppColors.dateTextColor,
                        ),
                      ),
                    ],
                  ),
                  5.heightSpace,
                  Text(
                    desc,
                    style: AppTextStyles.bodySmall.copyWith(fontSize: 10.sp),
                  ),
                  if (request?.requestedById != null &&
                      request?.status != 'approved' &&
                      request?.status != 'rejected')
                    5.heightSpace,

                  if (request?.requestedById != null &&
                      request?.status != 'approved' &&
                      request?.status != 'rejected')
                    Row(
                      children: [
                        CustomElevatedButton(
                          text: S.of(context).accept,
                          size: Size(100.w, 35.h),
                          borderRadius: 35,

                          textStyle: AppTextStyles.buttonsTextStyle.copyWith(
                            fontSize: 12.sp,
                          ),
                          onPressed: () {
                            NotificationsController.respondShowNumberRequest(
                              status: 'approved',
                              requestId: request!.contactRequestId!,
                            );
                          },
                        ),
                        10.widthSpace,
                        CustomOutlineButton(
                          text: S.of(context).reject,
                          size: Size(100.w, 35.h),
                          textStyle: AppTextStyles.buttonsTextStyle.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            NotificationsController.respondShowNumberRequest(
                              status: 'rejected',
                              requestId: request!.contactRequestId!,
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIcon() {
    return Stack(
      alignment: const Alignment(0.9, -1.4),
      children: [
        Container(
          padding: EdgeInsets.all(10).r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.notificationBorderColor),
          ),
          child: Stack(
            alignment: const Alignment(0.9, -1),
            children: [
              SvgPicture.asset(
                SvgAssets.assetsSvgNotificationIconUnselected,
                color: AppColors.notificationBorderColor,
                height: 24.h,
                width: 24.w,
              ),
              NotifyCircle(showNotify: !isSeen),
            ],
          ),
        ),
        // if (messageCount) UnreadMessagesCounter(),
      ],
    );
  }
}
