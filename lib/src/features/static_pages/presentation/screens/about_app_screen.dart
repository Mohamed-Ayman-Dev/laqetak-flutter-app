import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/widgets/app_logo.dart';
import 'package:provider/provider.dart';

import '../../../../core/shared/models/settings_model.dart';
import '../../../../core/shared/providers/app_settings.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../../../../core/shared/widgets/drawer_widgets/custom_drawer.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/text_styles.dart';

class AboutAppScreen extends StatefulWidget {
  static const String routeName = '/about_app';

  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  bool once = false;

  @override
  void didChangeDependencies() {
    if (!once) {
      // AuthController.getGeneralSettings();
      once = true;
    }
    super.didChangeDependencies();
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
                    child: RawScrollbar(
                      interactive: false,
                      thumbColor: AppColors.primaryColor,
                      thickness: 5,

                      radius: const Radius.circular(15),
                      thumbVisibility: true,
                      child: SizedBox(
                        height: 400.h,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22.0,
                            vertical: 22,
                          ).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.bodySmallGreyTextColor,
                                ),
                                'محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام  '
                                'محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام  '
                                'محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام  ',
                              ),
                            ],
                          ),
                          // child: provider.mySettings?.termsCondition == null
                          //     ? const StaticShimmer()
                          //     : Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           HtmlWidget(
                          //             provider.mySettings?.termsCondition ?? '',
                          //             textStyle: AppTextStyles.bodySmall.copyWith(
                          //                 fontSize: 15.sp,
                          //                 height: 1.6,
                          //                 fontFamily: 'Tajawal'), //f
                          //           ),
                          //         ],
                          //       ),
                        ),
                      ),
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
