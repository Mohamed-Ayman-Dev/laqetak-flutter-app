import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/features/chat/presentation/widgets/chat_header_widget.dart';

import '../../features/home/presentation/screens/home_layout_screen.dart';
import '../constants/enums.dart';
import '../di/locator_service.dart';
import '../helpers/others_helper.dart';
import '../themes/text_styles.dart';
import '../shared/models/customer_model.dart';
import 'app_logo.dart';
import 'buttons_widgets/my_icon_button.dart';
import 'custom_direction_widget.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? connectionStatus;
  final String? orderStatus;
  final List<AppbarIcons> icons;
  final bool dontShowBackButton;
  final double? toolbarHeight;
  final double? paddingAround;

  final Color? backgroundColor;
  final Color? titleColor;
  final int flexLeft;
  final bool showSearchIcon; // ✅ أضفه
  final CustomerModel? chatReceiver;
  final int flexRight;
  final void Function()? onSearch;
  final bool ishHomeLayoutDrawer;

  const CustomAppbar({
    super.key,
    this.orderStatus,
    this.showSearchIcon = false,
    this.chatReceiver,

    this.paddingAround,
    this.title,
    required this.icons,
    this.backgroundColor,
    this.titleColor,
    this.dontShowBackButton = false,
    this.toolbarHeight,
    this.flexLeft = 1,
    this.flexRight = 1,
    this.connectionStatus,
    this.onSearch,
    this.ishHomeLayoutDrawer = false,
  });

  @override
  Widget build(BuildContext context) {
    bool canPop =
        !dontShowBackButton &&
        LocatorService.navigationService.currentState!.canPop();
    return AppBar(
      toolbarHeight: toolbarHeight?.h ?? 200.h,
      leadingWidth: 0.w,
      titleSpacing: 10.w,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icons.contains(AppbarIcons.drawer))
            Hero(
              tag: 'appbar-drawer',
              child: MyIconButton(
                icon: SvgAssets.assetsSvgDrawerIcon,
                onTap: () {
                  ishHomeLayoutDrawer
                      ? HomeLayoutScreen.scaffoldKey.currentState?.openDrawer()
                      : Scaffold.of(context).openDrawer();
                },
              ),
            ),
          if (icons.contains(AppbarIcons.chat))
            ChatHeaderWidget(chatReceiver: chatReceiver),
          Spacer(flex: flexRight),

          if (title != null)
            Padding(
              padding: EdgeInsets.only(
                left: isArabic
                    ? icons.isEmpty
                          ? MediaQuery.of(context).size.width * 0.1
                          : 0.0
                    : paddingAround?.w ?? 90.w,
                right: isArabic
                    ? 90.w
                    : icons.isEmpty
                    ? MediaQuery.of(context).size.width * 0.1
                    : 0.0,
              ),
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: AppTextStyles.titleMedium,
              ),
            ),
          if (icons.contains(AppbarIcons.logo)) AppLogo(width: 125, height: 23),
          Spacer(flex: flexLeft),
          AnimatedOpacity(
            opacity: showSearchIcon ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            child: AnimatedSlide(
              offset: showSearchIcon
                  ? Offset.zero
                  : const Offset(0.4, 0), // بيجي من الشمال
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              child: IgnorePointer(
                ignoring: !showSearchIcon, // ✅ مش بيتضغط لما مش ظاهر
                child: MyIconButton(
                  icon: SvgAssets.assetsSvgSearchIcon,
                  onTap: onSearch,
                ),
              ),
            ),
          ),

          if (canPop)
            CustomDirectionWidget(
              child: Hero(
                tag: 'appbar-back',
                child: MyIconButton(
                  icon: SvgAssets.assetsSvgArrowLeft,
                  onTap: () {
                    LocatorService.navigationService.currentState!.pop();
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (15.h));
}
