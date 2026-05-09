

//
// class HomeLayoutScreen extends StatefulWidget {
//   static const routeName = '/home_layout_screen';
//
//   const HomeLayoutScreen({super.key});
//
//   @override
//   State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
// }
//
// class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
//   final List<Map<String, dynamic>> _icons = [
//     {'name': S.current.home, 'icon': 'assets/images/nav_home.png'},
//     {'name': S.current.myOrders, 'icon': 'assets/images/nav_shopping_cart.png'},
//     {'name': S.current.quotationRequest, 'icon': 'assets/images/eye_on.png'},
//     {'name': S.current.search, 'icon': 'assets/images/nav_search.png'},
//     {'name': S.current.profile, 'icon': 'assets/images/nav_user.png'},
//   ];
//   final List<Widget> screens = [
//     HomeScreen(),
//     OrdersScreen(),
//     SearchScreen(),
//     SearchScreen(),
//     ProfileScreen(),
//   ];
//   bool dialogShown = false;
//   bool once = false;
//
//   @override
//   void didChangeDependencies() {
//     if (!once) {
//       WidgetsBinding.instance.addPostFrameCallback((_) async {
//         if (isAuth) {
//           ///updating profile data
//           ///checking if its login or not if not using status code to return to login
//           AuthController.getProfile();
//         }
//         if (LocatorService.appSettings.mySettings?.currentStage == null) {
//           AuthController.getGeneralSettings();
//         }
//         LocatorService.notificationService.initializeFCM();
//         initPermission();
//         askNotificationPermission();
//         if (isAuth) {
//           final token = await AuthController.getDeviceToken();
//           if (token != null) {
//             AuthController.sendDeviceToken(token);
//           }
//         }
//       });
//
//       once = true;
//     }
//     super.didChangeDependencies();
//   }
//
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   Future<void> initPermission() async {
//     await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }
//
//   bool permissionChecked = false;
//
//   Future<void> askNotificationPermission() async {
//     if (permissionChecked) return;
//     permissionChecked = true; // Mark as checked
//
//     final PermissionStatus currentStatus = await Permission.notification.status;
//     if (currentStatus.isGranted) {
//       return;
//     }
//     if (currentStatus.isDenied || currentStatus.isPermanentlyDenied) {
//       final PermissionStatus newStatus = await Permission.notification
//           .request();
//       if (newStatus.isGranted) {
//         initPermission();
//       } else if (newStatus.isDenied) {
//         if (mounted) {
//           EasyLoading.showToast(
//             S
//                 .of(context)
//                 .pleaseAllowNotificationsPermissionToGetUpdatesInSettings,
//             dismissOnTap: true,
//             toastPosition: EasyLoadingToastPosition.bottom,
//             duration: const Duration(seconds: 3),
//           );
//         }
//       } else if (newStatus.isPermanentlyDenied) {
//         // if (mounted) {
//         //   EasyLoading.showToast(
//         //     S
//         //         .of(context)
//         //         .pleaseAllowNotificationsPermissionToGetUpdatesInSettings,
//         //     dismissOnTap: true,
//         //     toastPosition: EasyLoadingToastPosition.bottom,
//         //     duration: const Duration(seconds: 3),
//         //   );
//         // }
//         // Remove `openAppSettings();` so the app doesn’t navigate automatically
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isTablet = MediaQuery.of(context).size.width > 600;
//
//     return Scaffold(
//       extendBody: true,
//       drawer: const CustomDrawer(),
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(
//           kToolbarHeight + (isTablet ? 50.h : 15.h),
//         ),
//         child: Selector<AppSettings, int>(
//           selector: (context, provider) => provider.homeIndex,
//           builder: (context, homeIndex, child) {
//             return homeIndex == 3
//                 ? 60.heightSpace
//                 : CustomAppbar(
//                     paddingLeft: homeIndex == 1 || homeIndex == 4,
//                     paddingLeftWidth: (homeIndex == 1 || homeIndex == 4)
//                         ? 158
//                         : 90,
//                     title: homeIndex == 1
//                         ? S.current.myOrders
//                         : homeIndex == 4
//                         ? S.current.profile
//                         : null,
//                     icons: homeIndex == 1 || homeIndex == 4
//                         ? [AppbarIcons.drawer]
//                         : [
//                             AppbarIcons.logo,
//                             AppbarIcons.notifications,
//                             AppbarIcons.drawer,
//                           ],
//                     dontShowBackButton: true,
//                   );
//           },
//         ),
//       ),
//       body: Selector<AppSettings, int>(
//         selector: (context, provider) => provider.homeIndex,
//         builder: (context, homeIndex, child) {
//           return WillPopScope(
//             onWillPop: () async {
//               if (homeIndex == 0) {
//                 bool? shouldClose = await AlertUtils.showYesOrNoDialog(
//                   title: S.of(context).closeApp,
//                   onYes: () {
//                     LocatorService.navigationService.currentState?.pop(true);
//                   },
//                   description: S.of(context).areYouSureYouWantToCloseTheApp,
//                   buttonText: S.of(context).yes,
//                 );
//                 return Future.value(shouldClose ?? false);
//               } else {
//                 LocatorService.appSettings.changeHomeIndex(0);
//                 return Future.value(false);
//               }
//             },
//             child: screens[homeIndex],
//           );
//         },
//       ),
//       floatingActionButton: (MediaQuery.of(context).viewInsets.bottom > 0)
//           ? null
//           : Transform.translate(
//               offset: Offset(0, 0), // اضبطها لو حابب ترفع/تنزل الزر شوية
//               child: Container(
//                 width: 57.w,
//                 height: 57.h,
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.primaryColor.withOpacity(0.3),
//                       blurRadius: 12,
//                     ),
//                   ],
//                   shape: BoxShape.circle,
//                   color: AppColors.primaryColor,
//                 ),
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     LocatorService.navigationService.currentState?.pushNamed(
//                       RequestProductScreen.routeName,
//                     );
//                   },
//                   shape: const CircleBorder(),
//                   backgroundColor: AppColors.primaryColor,
//                   elevation: 0,
//
//                   focusColor: AppColors.primaryColor,
//                   splashColor: AppColors.primaryColor,
//                   child: SvgPicture.asset(
//                     'assets/images/add.svg',
//                     width: 24.w,
//                     height: 24.h,
//                   ),
//                 ),
//               ),
//             ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: SafeArea(
//         child: Stack(
//           alignment: AlignmentGeometry.bottomCenter,
//           children: [
//             WaveBottomShell(
//               height: 75.h,
//               // أو 82.h حسب تصميمك
//               cornerRadius: 22,
//               strokeColor: AppColors.borderColor,
//               strokeWidth: 0.7,
//               waveWidth: 140.w,
//               // عرض الموجة (حوالي مكان زر +)
//               waveHeight: 37.h,
//               // ارتفاع/عمق الانتفاخ لأعلى (ناعم)
//               child: Selector<AppSettings, int>(
//                 selector: (context, provider) => provider.homeIndex,
//                 builder: (context, homeIndex, child) {
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: List.generate(_icons.length, (index) {
//                       bool isSelected = homeIndex == index;
//                       return GestureDetector(
//                         behavior: HitTestBehavior.translucent,
//                         onTap: () {
//                           if (_icons[index]['name'] !=
//                               S.current.quotationRequest) {
//                             LocatorService.appSettings.changeHomeIndex(index);
//                           }
//                         },
//                         child: AnimatedScale(
//                           scale: isSelected ? 1.1 : 1.0,
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeOutBack,
//                           child: AnimatedSwitcher(
//                             duration: const Duration(milliseconds: 250),
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 15.0,
//                                   ).r,
//                                   child: Image.asset(
//                                     _icons[index]['icon'],
//                                     key: ValueKey<bool>(isSelected),
//                                     color:
//                                         _icons[index]['name'] ==
//                                             S.current.quotationRequest
//                                         ? Colors.transparent
//                                         : isSelected
//                                         ? AppColors.primaryColor
//                                         : AppColors.iconUnSelectedColor,
//                                     width: 24.w,
//                                     height: 24.h,
//                                   ),
//                                 ),
//                                 6.heightSpace,
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                     left:
//                                         _icons[index]['name'] ==
//                                             S.current.quotationRequest
//                                         ? isArabic
//                                               ? 20
//                                               : 0
//                                         : 12,
//                                     right:
//                                         _icons[index]['name'] ==
//                                             S.current.quotationRequest
//                                         ? isArabic
//                                               ? 12
//                                               : 0
//                                         : 15,
//                                   ).r,
//                                   child: Text(
//                                     textAlign: TextAlign.center,
//                                     _icons[index]['name'],
//                                     style: AppTextStyles.labelLarge.copyWith(
//                                       fontSize: isArabic ? 13.sp : 12.sp,
//                                       color: isSelected
//                                           ? AppColors.primaryColor
//                                           : AppColors.iconUnSelectedColor,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   );
//                 },
//               ),
//             ),
//             Container(
//               height: 13.h,
//               width: double.infinity,
//               color: Colors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
