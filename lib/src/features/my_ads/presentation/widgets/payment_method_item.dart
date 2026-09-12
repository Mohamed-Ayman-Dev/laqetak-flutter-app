import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/themes/colors.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/widgets/custom_radio_button.dart';
import '../../../../core/themes/text_styles.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.cardType = PaymentMethods.cash,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final PaymentMethods cardType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15).r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12).r,
          border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF04060F).withOpacity(0.05),
              offset: const Offset(0, 4),
              blurRadius: 60,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // ─── Card Logo ───
            _buildCardLogo(),
            16.widthSpace,
            // ─── Masked Card Title ───
            Text(
              title,
              style: AppTextStyles.headlineMedium.copyWith(
                fontSize: 13.sp,
                color: AppColors.numberLabelTextColor,
                letterSpacing: 1.2,
              ),
            ),
            const Spacer(),

            // ─── Radio Button ───
            CustomRadioButton(
              isSelected: isSelected,
              onChanged: (_) {
                onTap();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardLogo() {
    return switch (cardType) {
      PaymentMethods.cash => SvgPicture.asset(
        SvgAssets.assetsSvgCash,
        color: AppColors.primaryColor,
        width: 38.w,
        height: 28.h,
      ),
      // PaymentMethods.card => Image.asset(
      //   ImagesAssets.assetsImagesCard,
      //   width: 38.w,
      //   fit: BoxFit.cover,
      //   height: 28.h,
      // ),
      PaymentMethods.card => SizedBox(height: 28.h),
    };
  }
}
