import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/constants/enums.dart';
import 'package:laqetak/src/core/di/locator_service.dart';
import 'package:laqetak/src/core/extension/space_extensions_helper.dart';
import 'package:laqetak/src/core/helpers/dialog_helpers.dart';
import 'package:laqetak/src/core/themes/colors.dart';
import 'package:laqetak/src/core/themes/text_styles.dart';
import 'package:laqetak/src/core/widgets/buttons_widgets/custom_elevated_button.dart';
import 'package:laqetak/src/core/widgets/buttons_widgets/custom_outline_button.dart';
import 'package:laqetak/src/core/widgets/custom_appbar.dart';
import 'package:laqetak/src/core/widgets/drawer_widgets/custom_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:laqetak/src/core/constants/app_feedback.dart';
import 'package:laqetak/src/features/ad_details/presentation/widgets/ad_details_bottom.dart';
import 'package:laqetak/src/features/ad_details/presentation/widgets/ad_details_desc.dart';
import 'package:laqetak/src/features/ad_details/presentation/widgets/ad_details_header.dart';
import 'package:laqetak/src/features/ad_details/presentation/widgets/ad_details_points.dart';
import 'package:laqetak/src/features/ad_details/presentation/widgets/ad_details_seller.dart';
import 'package:laqetak/src/features/ad_details/presentation/widgets/ad_image_gallery.dart';
import 'package:laqetak/src/features/ad_details/presentation/widgets/shimmers/ad_image_gallery_shimmer.dart';
import 'package:laqetak/src/features/home/presentation/cubit/ads_cubit.dart';
import 'package:laqetak/src/features/home/presentation/cubit/ads_state.dart';
import 'package:laqetak/src/features/my_ads/presentation/cubit/my_ads_cubit.dart';
import 'package:laqetak/src/features/my_ads/presentation/cubit/my_ads_state.dart';
import 'package:laqetak/src/features/my_ads/presentation/screens/add_ad_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/helpers/bottom_helpers.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/widgets/lists_widgets/smart_refresher_header.dart';

class AdDetailsScreen extends StatefulWidget {
  static const routeName = '/ad_details_screen';

  const AdDetailsScreen({super.key});

  @override
  State<AdDetailsScreen> createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {
  bool isMyAd = false;
  String? adHero;
  bool once = false;
  AdModel? ad;

  @override
  void didChangeDependencies() {
    if (!once) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        adHero = args['hero'];
        ad = args['ad'];
        isMyAd = args['isMyAd'] ?? false;
        if (isMyAd != true) {
          isMyAd =
              (LocatorService.authCubit.state.user?.id == ad?.customer?.id);
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AdsCubit>().getAdDetails(ad?.id ?? 0);
      });
      once = true;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  Future<void> _refresh() async {
    final refreshController = _refreshController;
    await context.read<AdsCubit>().getAdDetails(ad?.id ?? 0);
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AdsCubit, AdsState>(
          listenWhen: (previous, current) =>
              current.adDetailsStatus == RequestStatus.error &&
              previous.adDetailsStatus != RequestStatus.error,
          listener: (context, state) {
            if (ModalRoute.of(context)?.isCurrent != true) return;
            AppFeedback.errorMessage(state.errorMessage);
          },
        ),
        BlocListener<MyAdsCubit, MyAdsState>(
          listenWhen: (previous, current) =>
              previous.actionStatus != current.actionStatus &&
              current.lastMutation == MyAdsMutation.close,
          listener: _onCloseAd,
        ),
      ],
      child: Scaffold(
        appBar: CustomAppbar(
          icons: [AppbarIcons.logo, AppbarIcons.drawer],
          flexRight: 8,
        ),
        drawer: CustomDrawer(),
        body: SafeArea(
          bottom: true,
          top: false,
          child: BlocSelector<AdsCubit, AdsState, AdModel?>(
            selector: (state) => state.adDetails[ad?.id],
            builder: (context, updatedAdDetail) {
              final adDetail = updatedAdDetail ?? ad;
              final isExpired = adDetail?.status == 'closed';
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _refresh,
                    header: const SmartRefresherHeader(),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 20,
                      ).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AdDetailsHeader(isMyAd: isMyAd, ad: adDetail),
                          20.heightSpace,
                          adDetail?.photos == null
                              ? AdImageGalleryShimmer()
                              : AdImageGallery(
                                  images:
                                      adDetail?.photos
                                          ?.map((e) => e.url ?? '')
                                          .toList() ??
                                      [],
                                  type: adDetail?.category?.name ?? '',
                                  hero: adHero ?? '',
                                  isExpired: isExpired,
                                ),
                          15.heightSpace,
                          AdDetailsPoints(ad: adDetail),
                          17.heightSpace,
                          Text(
                            S.of(context).adDetails,
                            style: AppTextStyles.labelMedium,
                          ),
                          11.heightSpace,
                          AdDetailsDesc(desc: adDetail?.description),
                          16.heightSpace,
                          if (!isMyAd)
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: CustomOutlineButton(
                                text: S.of(context).reportAd,
                                textStyle: AppTextStyles.buttonsTextStyle
                                    .copyWith(
                                      color: AppColors.labelTextColor,
                                      fontSize: 12.sp,
                                    ),
                                size: Size(123.w, 36.h),
                                borderColor: AppColors.reportBorderColor,
                                onPressed: () {
                                  isAuth
                                      ? DialogHelpers.showReportDialog(
                                          ad?.id ?? 0,
                                        )
                                      : BottomHelpers.showGuestBottomSheet(
                                          context,
                                        );
                                },
                              ),
                            ),
                          Text(
                            S.of(context).advertiserDetails,
                            style: AppTextStyles.labelMedium,
                          ),
                          12.heightSpace,
                          AdDetailsSeller(
                            customer: adDetail?.customer,
                            phone: adDetail?.contactPhone,
                            isMyAd: isMyAd,
                            ad: adDetail,
                            isExpired: isExpired,
                            hidePhone: adDetail?.hidePhone == 1,
                          ),
                          if (isMyAd && !isExpired) 22.heightSpace,
                          if (isMyAd && !isExpired)
                            Row(
                              children: [
                                Expanded(
                                  child: CustomElevatedButton(
                                    text: S.of(context).editAd,
                                    onPressed: () {
                                      LocatorService
                                          .navigationService
                                          .currentState
                                          ?.pushNamed(
                                            AddAdScreen.routeName,
                                            arguments: adDetail,
                                          );
                                    },
                                  ),
                                ),
                                11.widthSpace,
                                Expanded(
                                  child: CustomOutlineButton(
                                    text: S.of(context).expiredAd,
                                    borderRadius: 8,
                                    borderColor: AppColors.reportBorderColor,
                                    onPressed: () {
                                      DialogHelpers.showYesNoDialog(
                                        title: S.of(context).confirmAction,
                                        subtitle: S
                                            .of(context)
                                            .areYouSureYouWantToEndThisAd,
                                        onButtonTap: () {
                                          Navigator.of(context).pop();
                                          context.read<MyAdsCubit>().closeAd(
                                            adDetail?.id ?? 0,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          110.heightSpace,
                        ],
                      ),
                    ),
                  ),
                  AdDetailsBottom(price: adDetail?.investmentAmount),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _onCloseAd(BuildContext context, MyAdsState myAdsState) {
    if (ModalRoute.of(context)?.isCurrent != true) return;
    switch (myAdsState.actionStatus) {
      case RequestStatus.loading:
        AppFeedback.loadingMessage();
      case RequestStatus.success:
        EasyLoading.dismiss();
        final id = myAdsState.lastAdId;
        if (id != null) {
          LocatorService.adsCubit.getAdDetails(id);
        }
        LocatorService.adsCubit.getAds(refresh: true);
        DialogHelpers.showSuccessDialog(title: S.current.adEndedSuccessfully);
      case RequestStatus.error:
        AppFeedback.errorMessage(myAdsState.errorMessage);
      case RequestStatus.initial:
        break;
    }
  }
}
