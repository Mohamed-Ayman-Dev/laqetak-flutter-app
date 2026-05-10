import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/widgets/custom_Text.dart';

import '../../../themes/colors.dart';
import '../../../themes/text_styles.dart';

class TermsContent extends StatefulWidget {
  final String? termsText;
  final String? title;

  const TermsContent({super.key, this.termsText, this.title});

  @override
  State<TermsContent> createState() => _TermsContentState();
}

class _TermsContentState extends State<TermsContent> {
  final ScrollController _scrollController = ScrollController();
  bool _showFab = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final atBottom =
          _scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 10;
      if (atBottom != !_showFab) {
        setState(() => _showFab = !atBottom);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
        left: 16,
        top: 55,
        bottom: 22,
      ).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            widget.title ?? 'الشروط والأحكام',
            style: AppTextStyles.headlineMedium.copyWith(fontSize: 16.sp),
          ),
          10.heightSpace,
          RawScrollbar(
            controller: _scrollController,
            interactive: false,
            thumbColor: AppColors.primaryColor,
            thickness: 5,
            radius: const Radius.circular(15),
            thumbVisibility: true,
            child: SizedBox(
              height: 400.h,
              child: SingleChildScrollView(
                controller: _scrollController,
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
                      widget.termsText ??
                          'محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلىمحتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلىمحتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلىمحتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلىمحتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلىمحتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى ',
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
          39.heightSpace,
          AnimatedOpacity(
            opacity: _showFab ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12).r,
              child: GestureDetector(
                onTap: _scrollDown,
                child: Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.13),
                        offset: const Offset(0, 4),
                        blurRadius: 20.7,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(12).r,
                  child: SvgPicture.asset(
                    SvgAssets.assetsSvgArrowDownOutlined,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
