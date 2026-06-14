import 'package:flutter/material.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SocialButton(
                link: socialLinks?.whatsapp ?? '',
                icon: SvgAssets.assetsSvgWhatsapp,
              ),
              SocialButton(
                link: socialLinks?.twitter ?? '',
                icon: SvgAssets.assetsSvgX,
              ),
              SocialButton(
                link: socialLinks?.instagram ?? '',
                icon: SvgAssets.assetsSvgInsta,
              ),
              SocialButton(
                link: socialLinks?.tiktok ?? '',
                icon: SvgAssets.assetsSvgTiktok,
              ),
              SocialButton(
                link: socialLinks?.snapchat ?? '',
                icon: SvgAssets.assetsSvgSnapchat,
              ),
            ],
          ),
        );
      },
    );
  }
}
