import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/widgets/app_logo.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/shared/controllers/settings_controller.dart';
import '../../../../core/shared/models/settings_model.dart';
import '../../../../core/shared/providers/app_settings.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../../../../core/shared/widgets/drawer_widgets/custom_drawer.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/text_styles.dart';
import '../widgets/static_shimmer.dart';

class AboutAppScreen extends StatefulWidget {
  static const String routeName = '/about_app';

  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SettingsController.getGeneralSettings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        icons: [AppbarIcons.drawer],
        title: 'عن المنصة',
        flexLeft: 100,
      ),
      drawer: CustomDrawer(),

      body: SafeArea(
        bottom: true,
        top: false,
        right: false,
        left: false,
        child: Selector<AppSettings, SettingsModel?>(
          selector: (context, provider) => provider.mySettings,
          builder: (context, mySettings, child) {
            return Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 20).r,
              child: Column(
                children: [
                  30.heightSpace,
                  AppLogo(height: 43, width: 239),
                  30.heightSpace,
                  Expanded(
                    child: Selector<AppSettings, SettingsModel?>(
                      selector: (context, provider) => provider.mySettings,
                      builder: (context, mySettings, child) {
                        return RawScrollbar(
                          interactive: false,
                          thumbColor: AppColors.primaryColor,
                          thickness: 5,

                          radius: const Radius.circular(15),
                          thumbVisibility: true,
                          child: SizedBox(
                            height: 400.h,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22.0,
                                vertical: 22,
                              ).r,
                              child: mySettings?.termsAndConditions == null
                                  ? Column(
                                      children: [
                                        const StaticShimmer(),
                                        const StaticShimmer(),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        HtmlWidget(
                                          mySettings?.aboutUs ?? '',
                                          textStyle: AppTextStyles.labelSmall
                                              .copyWith(
                                                color: AppColors
                                                    .bodySmallGreyTextColor,
                                                fontFamily: Constant.fontFamily,
                                              ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  30.heightSpace,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
