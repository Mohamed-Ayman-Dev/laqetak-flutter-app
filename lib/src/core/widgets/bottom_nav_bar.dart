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
import '../helpers/others_helper.dart';
import '../themes/colors.dart';
import '../themes/gradients.dart';
import '../themes/shadows.dart';
import '../shared/settings/presentation/cubit/settings_cubit.dart';
import '../shared/settings/presentation/cubit/settings_state.dart';
import 'badges/notify_circle.dart';

// ── Modern Floating Bottom Navigation Bar ──────────────────────────────────
/// A sleek, floating bottom navigation bar with a raised center FAB,
/// animated active indicator, and brand-consistent color scheme.
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.navItems});

  final List<Map<String, dynamic>> navItems;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsState, int>(
      selector: (state) => state.homeIndex,
      builder: (context, homeIndex) {
        return SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            height: 64.h,
            decoration: BoxDecoration(
              color: AppColors.navBarBackgroundColor,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: AppShadows.floatingNavBarShadow,
            ),
            child: Row(
              children: List.generate(navItems.length, (index) {
                final item = navItems[index];
                final bool isFab = item['name'] == 'add';
                final bool isSelected = homeIndex == index;

                if (isFab) {
                  return _CenterFab(item: item);
                }

                return _NavItem(
                  item: item,
                  index: index,
                  isSelected: isSelected,
                  onTap: () => context
                      .read<SettingsCubit>()
                      .changeHomeIndex(index),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

// ── Center FAB (Add Button) ────────────────────────────────────────────────
class _CenterFab extends StatelessWidget {
  const _CenterFab({required this.item});

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          !isAuth
              ? BottomHelpers.showGuestBottomSheet(context)
              : LocatorService.navigationService.currentState
                  ?.pushNamed(AddAdScreen.routeName);
        },
        child: Center(
          child: Transform.translate(
            offset: Offset(0, -20.h),
            child: Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.brandGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryColor.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                Icons.add_rounded,
                size: 28.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Regular Nav Item ───────────────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  final Map<String, dynamic> item;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ── Icon + Label + Indicator ──────────────────────────────
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with animated color transition
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: SvgPicture.asset(
                    item['activeIcon'] ?? '',
                    key: ValueKey('nav_icon_${index}_$isSelected'),
                    width: 22.w,
                    height: 22.h,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? AppColors.secondaryColor
                          : AppColors.iconUnSelectedColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                // Label
                Text(
                  item['name'],
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: isArabic ? 10.sp : 9.sp,
                    color: isSelected
                        ? AppColors.secondaryColor
                        : AppColors.iconUnSelectedColor,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w400,
                    letterSpacing: 0.1,
                  ),
                ),
                SizedBox(height: 4.h),
                // Active indicator dot
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  width: isSelected ? 5.w : 0,
                  height: isSelected ? 5.h : 0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
            // ── Notification badge ───────────────────────────────────
            if (index == 4 || index == 1)
              BlocSelector<AuthCubit, AuthState, UserModel?>(
                selector: (state) => state.user,
                builder: (context, user) {
                  final bool hasUnread = (index == 4)
                      ? (user?.notificationCount?.toInt() ?? 0) > 0
                      : (user?.messagesCount?.toInt() ?? 0) > 0;
                  return Positioned(
                    top: 8.h,
                    right: isArabic ? null : 16.w,
                    left: isArabic ? 16.w : null,
                    child: NotifyCircle(showNotify: hasUnread),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
