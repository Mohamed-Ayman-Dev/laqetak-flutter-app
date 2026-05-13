import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';

import '../../../di/locator_service.dart';
import '../../../extension/space_extensions_helper.dart';
import '../../../helpers/others_helper.dart';
import '../../../themes/text_styles.dart';
import '../custom_Text.dart';
import '../custom_g_radio_button.dart';

class LanguageBottom extends StatefulWidget {
  final bool showSplash;

  const LanguageBottom({super.key, required this.showSplash});

  @override
  State<LanguageBottom> createState() => _LanguageBottomState();
}

class _LanguageBottomState extends State<LanguageBottom> {
  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize the selected index based on the current locale.
  //   String langName = Intl.getCurrentLocale() == 'ar' ? 'العربية' : 'English';
  //   selectedIndex = (langName == 'العربية' ? 1 : 0);
  // }

  List<String> languages = ['English', 'العربية'];
  int selectedIndex = 0;
  int groupValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      groupValue = value;
    });
  }

  @override
  void initState() {
    if (isArabic) {
      groupValue = 0;
    } else {
      groupValue = 1;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const AlignmentDirectional(-0.9, -0.9),
      children: [
        Container(
          height: 200.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 0).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    10.widthSpace,

                    const Spacer(),
                    CustomText(
                      "إختر اللغة",
                      style: AppTextStyles.titleMedium.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        LocatorService.navigationService.currentState?.pop();
                      },
                      child: SvgPicture.asset(
                        SvgAssets.assetsSvgCloseDrawerIcon,
                        color: Colors.black,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                  ],
                ),
              ),
              32.heightSpace,
              CustomGRadioButton(
                label: 'العربية',
                value: 0,
                padding: EdgeInsets.zero,
                groupValue: groupValue,
                onChanged: _handleRadioValueChange,
              ),
              10.heightSpace,
              CustomGRadioButton(
                label: 'English',
                value: 1,
                padding: EdgeInsets.zero,

                groupValue: groupValue,
                onChanged: _handleRadioValueChange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
