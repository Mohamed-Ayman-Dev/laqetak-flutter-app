import 'package:flutter/material.dart';

import '../themes/colors.dart';

extension ShowMessenger on BuildContext {
  dynamic clearMaterialBanners() =>
      ScaffoldMessenger.of(this).clearMaterialBanners();

  hideCurrentMaterialBanner() =>
      ScaffoldMessenger.of(this).hideCurrentMaterialBanner();

  ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>
  showMaterial(MaterialBanner materialBanner) =>
      ScaffoldMessenger.of(this).showMaterialBanner(materialBanner);

  ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>
  showSessionExpiredMaterialBanner() =>
      ScaffoldMessenger.of(this).showMaterialBanner(_sessionExpired(this));
}

MaterialBanner _sessionExpired(BuildContext context) => const MaterialBanner(
  content: Padding(
    padding: EdgeInsets.all(16),
    child: Row(
      spacing: 16,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.symmetric(vertical: 8),
          child: Icon(Icons.warning, color: AppColors.primaryColor),
        ),
        Flexible(
          child: Text(
            'Your session has been expired, please login again',
            style: TextStyle(color: AppColors.labelTextColor),
          ),
        ),
      ],
    ),
  ),
  leadingPadding: EdgeInsets.all(0),
  shadowColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
  padding: EdgeInsets.all(0),
  margin: EdgeInsets.all(0),
  actions: [SizedBox.shrink()],
  backgroundColor: Colors.white,
  elevation: 1,
);
