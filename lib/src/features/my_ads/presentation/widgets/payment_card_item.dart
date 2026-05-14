import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/images_assets.dart';
import 'package:invastro/src/core/themes/colors.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/custom_radio_button.dart';
import '../../../../core/themes/text_styles.dart';

class PaymentCardItem extends StatelessWidget {
  const PaymentCardItem({
    super.key,
    required this.lastFourDigits,
    required this.isSelected,
    required this.onTap,
    this.cardType = CardType.mastercard,
  });

  final String lastFourDigits;
  final bool isSelected;
  final VoidCallback onTap;
  final CardType cardType;

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
            // ─── Radio Button ───
            CustomRadioButton(
              isSelected: isSelected,
              onChanged: (_) {
                onTap();
              },
            ),
            const Spacer(),

            // ─── Masked Card Number ───
            Text(
              '•••• •••• •••• $lastFourDigits',
              style: AppTextStyles.headlineMedium.copyWith(
                fontSize: 13.sp,
                color: AppColors.numberLabelTextColor,
                letterSpacing: 1.2,
              ),
            ),

            16.widthSpace,

            // ─── Card Logo ───
            _buildCardLogo(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardLogo() {
    return switch (cardType) {
      CardType.mastercard => Image.asset(
        ImagesAssets.assetsImagesMaster,
        width: 38.w,
        height: 28.h,
      ),
      CardType.visa => Image.asset(
        ImagesAssets.assetsImagesMaster,
        width: 38.w,
        height: 28.h,
      ),
    };
  }
}
