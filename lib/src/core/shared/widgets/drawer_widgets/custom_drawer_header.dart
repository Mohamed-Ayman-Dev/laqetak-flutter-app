import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/shared/widgets/custom_image.dart';
import 'package:invastro/src/features/auth/data/models/user_model.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../features/auth/presentation/providers/auth.dart';
import '../../../extension/space_extensions_helper.dart';
import '../../../helpers/others_helper.dart';
import '../../../themes/colors.dart';
import '../../../themes/text_styles.dart';
import '../custom_Text.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: isArabic
              ? const EdgeInsets.only(right: 20.0).r
              : const EdgeInsets.only(left: 20.0).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              100.heightSpace,
              Selector<Auth, UserModel?>(
                selector: (context, provider) => provider.user,
                builder: (context, user, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'profile_image',
                        child: CustomImage(
                          imageUrl: user?.avatar ?? '',
                          width: 52,
                          height: 52,
                          borderRadius: 100,
                        ),
                      ),
                      13.widthSpace,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (user?.phone != null)
                            CustomText(
                              user?.phone ?? '',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.labelGreyTextColor,
                                fontSize: 11.sp,
                              ),
                            ),
                          if (user?.phone != null) 4.heightSpace,
                          SizedBox(
                            width: 150.w,
                            child: CustomText(
                              user?.name ?? S.of(context).invastroUser,
                              style: AppTextStyles.headlineMedium.copyWith(
                                color: AppColors.drawerHeaderTextColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              10.heightSpace,
            ],
          ),
        ),
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.only(left: 22.0, right: 22, top: 40).r,
              padding: EdgeInsets.all(6).r,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    offset: Offset(0, 1),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                SvgAssets.assetsSvgCloseDrawerIcon,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
