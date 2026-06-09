import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/shared/models/customer_model.dart';

import '../../../../core/constants/svg_assets.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/shared/widgets/buttons_widgets/small_icon_button.dart';
import '../../../../core/shared/widgets/custom_image.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../chat/presentation/screens/chat_screen.dart';

class CustomerHeader extends StatelessWidget {
  final CustomerModel? customer;

  const CustomerHeader({super.key, this.customer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImage(
          imageUrl: customer?.avatar ?? '',
          width: 122,
          height: 122,
          borderRadius: 100,
        ),
        17.heightSpace,
        Text(customer?.name ?? '', style: AppTextStyles.labelLarge),
        12.heightSpace,
        Text(
          customer?.email ?? '',
          style: AppTextStyles.labelMedium.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            color: AppColors.labelSmallGreyTextColor,
          ),
        ),
        24.heightSpace,
        Row(
          children: [
            45.widthSpace,
            SmallIconButton(
              icon: SvgAssets.assetsSvgChatDotsIcon,
              height: 34.h,
              width: 34.w,
              onTab: () {
                LocatorService.navigationService.currentState?.pushNamed(
                  ChatScreen.routeName,
                  arguments: {'receiver': customer},
                );
              },
            ),
            Spacer(),
            SmallIconButton(
              icon: SvgAssets.assetsSvgReportCircle,
              height: 34.h,
              width: 34.w,
              onTab: () {
                DialogHelpers.showReportDialog(
                  customer?.id ?? 0,
                  isCustomerReport: true,
                );
              },
            ),
            45.widthSpace,
          ],
        ),
      ],
    );
  }
}
