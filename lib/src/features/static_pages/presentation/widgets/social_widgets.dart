import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/features/static_pages/presentation/widgets/social_button.dart';

import '../../../../core/shared/settings/data/models/settings_model.dart';
import '../../../../core/shared/settings/presentation/cubit/settings_cubit.dart';
import '../../../../core/shared/settings/presentation/cubit/settings_state.dart';

class SocialWidgets extends StatelessWidget {
  const SocialWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsState, SettingsModel?>(
      selector: (state) => state.settings,
      builder: (context, socialLinks) {
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
