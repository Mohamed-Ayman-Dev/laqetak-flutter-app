import 'package:flutter/material.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/features/static_pages/presentation/widgets/social_button.dart';
import 'package:provider/provider.dart';

import '../../../../core/shared/models/settings_model.dart';
import '../../../../core/shared/providers/app_settings.dart';

class SocialWidgets extends StatelessWidget {
  const SocialWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AppSettings, SettingsModel?>(
      selector: (context, provider) => provider.mySettings,
      builder: (context, socialLinks, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (socialLinks?.whatsapp != null)
              SocialButton(
                link: socialLinks?.whatsapp ?? '',
                icon: SvgAssets.assetsSvgWhatsapp,
              ),
            5.widthSpace,
            if (socialLinks?.twitter != null)
              SocialButton(
                link: socialLinks?.twitter ?? '',
                icon: SvgAssets.assetsSvgX,
              ),
            5.widthSpace,

            if (socialLinks?.instagram != null)
              SocialButton(
                link: socialLinks?.instagram ?? '',
                icon: SvgAssets.assetsSvgInsta,
              ),
            5.widthSpace,

            if (socialLinks?.tiktok != null)
              SocialButton(
                link: socialLinks?.tiktok ?? '',
                icon: SvgAssets.assetsSvgTiktok,
              ),
            5.widthSpace,

            if (socialLinks?.snapchat != null)
              SocialButton(
                link: socialLinks?.snapchat ?? '',
                icon: SvgAssets.assetsSvgSnapchat,
              ),
          ],
        );
      },
    );
  }
}
