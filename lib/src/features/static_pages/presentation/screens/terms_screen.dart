import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:provider/provider.dart';

import '../../../../core/shared/providers/app_settings.dart';

class TermsScreen extends StatefulWidget {
  static const String routeName = 'terms_screen';

  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool once = false;

  @override
  void didChangeDependencies() {
    if (!once) {
      // SettingsController.getGeneralSettings();
      // StaticPagesController.getTerms();
      once = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 37, vertical: 50).r,
        padding: const EdgeInsets.only(bottom: 20).r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [],
        ),
        height: 650.h,
        child: Consumer<AppSettings>(
          builder: (context, provider, child) {
            return Scrollbar(
              interactive: false,
              thickness: 5,
              radius: const Radius.circular(15),
              thumbVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 22,
                ).r,
                child: Text(
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.bodySmallGreyTextColor,
                  ),
                  'محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى ',
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
            );
          },
        ),
      ),
    );
  }
}
