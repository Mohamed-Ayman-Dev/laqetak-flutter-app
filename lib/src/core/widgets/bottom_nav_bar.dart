import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laqetak/src/core/helpers/bottom_helpers.dart';
import 'package:laqetak/src/features/auth/data/models/user_model.dart';
import 'package:laqetak/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:laqetak/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:laqetak/src/features/my_ads/presentation/screens/add_ad_screen.dart';

import '../di/locator_service.dart';
import '../extension/space_extensions_helper.dart';
import '../helpers/others_helper.dart';
import '../themes/colors.dart';
import '../themes/text_styles.dart';
import '../shared/settings/presentation/cubit/settings_cubit.dart';
import '../shared/settings/presentation/cubit/settings_state.dart';
import 'notify_circle.dart';

// ── Bottom Navigation Bar Widget ────────────────────────────────────────────
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.navItems});

  final List<Map<String, dynamic>> navItems;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 68.h, // Figma: 87px total; SafeArea handles the rest
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFF3F2F8), width: 1)),
        ),
        padding: EdgeInsets.only(bottom: 5).r,
        child: BlocSelector<SettingsCubit, SettingsState, int>(
          selector: (state) => state.homeIndex,
          builder: (context, homeIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(navItems.length, (index) {
                final item = navItems[index];
                final bool isFab = item['name'] == 'add';
                final bool isSelected = homeIndex == index;

                // ── Center FAB ────────────────────────────────────────
                if (isFab) {
                  return GestureDetector(
                    onTap: () {
                      !isAuth
                          ? BottomHelpers.showGuestBottomSheet(context)
                          : LocatorService.navigationService.currentState
                                ?.pushNamed(AddAdScreen.routeName);
                    },
                    child: SizedBox(
                      width: 71.w,
                      child: Center(
                        child: Container(
                          width: 52.w,
                          height: 52.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                          child: Icon(
                            Icons.add_outlined,
                            size: 26.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                // ── Regular nav item ──────────────────────────────────
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () =>
                      context.read<SettingsCubit>().changeHomeIndex(index),
                  child: SizedBox(
                    width: 71.w,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: isSelected ? 1.05 : 1.0),
                      // scaleFactor: 0.3
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      builder: (context, scale, child) => 
                          Transform.scale(scale: scale, child: child),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                isSelected
                                    ? item['activeIcon']
                                    : item['inactiveIcon'],
                                width: 24.w,
                                height: 24.h,
                              ),
                              4.heightSpace,
                              Text(
                                item['name'],
                                textAlign: TextAlign.center,
                                style: AppTextStyles.labelLarge.copyWith(
                                  fontSize: isArabic ? 11.sp : 10.sp,
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.iconUnSelectedColor,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          if (index == 4 || index == 1)
                            BlocSelector<AuthCubit, AuthState, UserModel?>(
                              selector: (state) => state.user,
                              builder: (context, user) {
                                bool unReadNotifications =
                                    user != null &&
                                        user.notificationCount != null &&
                                        user.notificationCount!.toInt() > 0
                                    ? true
                                    : false;
                                bool unReadMessages =
                                    user != null &&
                                        user.messagesCount != null &&
                                        user.messagesCount!.toInt() > 0
                                    ? true
                                    : false;
                                return Positioned(
                                  top: 10.h,
                                  left: 24.w,
                                  child: NotifyCircle(
                                    showNotify: index == 4
                                        ? unReadNotifications
                                        : unReadMessages,
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
