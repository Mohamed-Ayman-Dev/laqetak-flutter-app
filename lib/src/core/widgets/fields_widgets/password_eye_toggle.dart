import 'package:flutter/material.dart';
import 'package:laqetak/src/core/constants/images_assets.dart';

import '../../themes/colors.dart';

class EyeToggleIcon extends StatelessWidget {
  const EyeToggleIcon({
    super.key,
    required this.isHidden,
    required this.onToggle,
  });

  final bool isHidden;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onToggle,
      icon: ImageIcon(
        isHidden
            ? const AssetImage(ImagesAssets.assetsImagesEyeHiddenIcon)
            : const AssetImage(ImagesAssets.assetsImagesEyeOnIcon),
        size: 20,
        color: isHidden ? AppColors.fieldBorderColor : AppColors.primaryColor,
      ),
    );
  }
}
