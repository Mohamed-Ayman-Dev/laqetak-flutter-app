import 'package:flutter/material.dart';
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
                link: socialLinks?.aboutUs ?? '',
                icon: 'assets/images/x_icon.svg',
              ),
              SocialButton(
                link: socialLinks?.aboutUs ?? '',
                icon: 'assets/images/insta_icon.svg',
              ),
              SocialButton(
                link: socialLinks?.aboutUs ?? '',
                icon: 'assets/images/tiktok_icon.svg',
              ),
              SocialButton(
                link: socialLinks?.aboutUs ?? '',
                icon: 'assets/images/snap_icon.svg',
              ),
            ],
          ),
        );
      },
    );
  }
}
