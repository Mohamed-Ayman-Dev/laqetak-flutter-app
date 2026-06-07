import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/core/themes/text_styles.dart';

class AdDetailsBottom extends StatefulWidget {
  final String? price;

  const AdDetailsBottom({super.key, this.price});

  @override
  State<AdDetailsBottom> createState() => _AdDetailsBottomState();
}

class _AdDetailsBottomState extends State<AdDetailsBottom>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bottomSheetController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _bottomSheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _bottomSheetController,
            curve: Curves.easeOutCubic,
          ),
        );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _bottomSheetController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    // تأخير بسيط عشان الصفحة تتبني الأول
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bottomSheetController.forward();
    });
  }

  @override
  void dispose() {
    _bottomSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: AppColors.sellerNumberBKColor,
          ),
          padding: EdgeInsets.fromLTRB(36, 30, 30, 30).r,
          child: Row(
            children: [
              Text(
                'رأس المال',
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 13.sp,
                  color: AppColors.labelBlackTextColor,
                ),
              ),
              Spacer(),
              Text(
                widget.price ?? '',
                style: AppTextStyles.headlineMedium.copyWith(
                  fontSize: 24.sp,
                  color: AppColors.priceBlackTextColor,
                ),
              ),
              10.widthSpace,
              SvgPicture.asset(
                SvgAssets.assetsSvgSarIcon,
                color: AppColors.primaryColor,
                height: 17.h,
                width: 17.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
