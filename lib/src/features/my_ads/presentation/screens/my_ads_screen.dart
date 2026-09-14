import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/helpers/dialog_helpers.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:invastro/src/core/widgets/custom_appbar.dart';
import 'package:invastro/src/features/my_ads/presentation/cubit/my_ads_cubit.dart';
import 'package:invastro/src/features/my_ads/presentation/cubit/my_ads_state.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/add_ad_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/constants/app_feedback.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../../../core/widgets/items_widgets/ad_item.dart';
import '../../../../core/widgets/lists_widgets/empty_list_placeholder_widget.dart';
import '../../../../core/widgets/lists_widgets/list_loading_end_widget.dart';
import '../../../../core/widgets/lists_widgets/smart_refresher_header.dart';
import '../../../../core/widgets/shimmers/items/ad_item_shimmer.dart';
import '../../../ad_details/presentation/screens/ad_details_screen.dart';

class MyAdsScreen extends StatefulWidget {
  static const routeName = '/my_ads_screen';

  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyAdsCubit>().getMyAds(refresh: true);
      _scrollController.addListener(_onListListener);
    });
    super.initState();
  }

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  bool _gettingData = false;

  Future<void> _refresh() async {
    final refreshController = _refreshController;
    await context.read<MyAdsCubit>().getMyAds(refresh: true);
    refreshController.refreshCompleted();
  }

  void _onListListener() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50.0 &&
        _gettingData == false) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 200), () async {
        _gettingData = true;
        await context.read<MyAdsCubit>().getMyAds(refresh: false);
        _gettingData = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(icons: [AppbarIcons.logo], flexRight: 9),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15).r,
        child: BlocListener<MyAdsCubit, MyAdsState>(
          listenWhen: (previous, current) =>
              current.hasListError && !previous.hasListError,
          listener: (context, state) {
            if (state.actionStatus == RequestStatus.loading) return;
            AppFeedback.errorMessage(state.errorMessage);
          },
          child: SmartRefresher(
            scrollController: _scrollController,
            controller: _refreshController,
            onRefresh: _refresh,
            header: const SmartRefresherHeader(),
            child: SingleChildScrollView(
              child: BlocSelector<MyAdsCubit, MyAdsState, PaginationList<AdModel>?>(
                selector: (state) => state.ads,
                builder: (context, listProvider) {
                  final ads = listProvider?.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).myAds,
                        style: AppTextStyles.labelMedium.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      16.heightSpace,
                      ads != null && ads.isEmpty
                          ? EmptyListPlaceholderWidget(
                              text: S.of(context).thereAreNoAdsYet,
                              paddingTop: 0,
                              paddingBottom: 100,
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  delay: const Duration(milliseconds: 10),
                                  child: SlideAnimation(
                                    verticalOffset: 10,
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: FadeInAnimation(
                                      duration: const Duration(
                                        milliseconds: 1000,
                                      ),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: ads == null
                                          ? AdItemShimmer()
                                          : AdItem(
                                              category:
                                                  ads[index].category?.name ??
                                                  '',
                                              expired:
                                                  ads[index].status == 'closed',
                                              image: ads[index].mainPhoto ?? '',
                                              onTab: () {
                                                LocatorService
                                                    .navigationService
                                                    .currentState
                                                    ?.pushNamed(
                                                      AdDetailsScreen.routeName,
                                                      arguments: {
                                                        'hero':
                                                            '${ads[index].mainPhoto}-$index-my-ads',
                                                        'isMyAd': true,
                                                        'ad': ads[index],
                                                      },
                                                    );
                                              },

                                              hideDivider:
                                                  index == (ads.length - 1),
                                              heroTag:
                                                  '${ads[index].mainPhoto}-$index-my-ads',
                                              customerName:
                                                  ads[index].customer?.name ??
                                                  '',
                                              location:
                                                  ads[index].city?.name ?? '',
                                              name: ads[index].title ?? '',
                                              price:
                                                  ads[index].investmentAmount ??
                                                  '',
                                              time:
                                                  ads[index].publishedAt ?? '',
                                              sector:
                                                  ads[index].sector?.name ?? '',

                                              onDelete: () {
                                                DialogHelpers.showYesNoDialog(
                                                  title: S
                                                      .of(context)
                                                      .confirmAction,
                                                  subtitle: S
                                                      .of(context)
                                                      .areYouSureYouWantToDeleteThisAd,
                                                  onButtonTap: () {
                                                    Navigator.of(context).pop();
                                                    context
                                                        .read<MyAdsCubit>()
                                                        .deleteAd(
                                                          ads[index].id ?? 0,
                                                        );
                                                  },
                                                );
                                              },
                                              onEdit: () async {
                                                AppFeedback.loadingMessage();
                                                await LocatorService.adsCubit
                                                    .getAdDetails(
                                                      ads[index].id ?? 0,
                                                    );
                                                EasyLoading.dismiss();
                                                final adDetails = LocatorService
                                                    .adsCubit
                                                    .state
                                                    .adDetails[ads[index].id];
                                                LocatorService
                                                    .navigationService
                                                    .currentState
                                                    ?.pushNamed(
                                                      AddAdScreen.routeName,
                                                      arguments:
                                                          adDetails ??
                                                          ads[index],
                                                    );
                                              },
                                              views:
                                                  ads[index].viewsCount
                                                      ?.toInt() ??
                                                  0,
                                              isMyAd: true,
                                            ),
                                    ),
                                  ),
                                );
                              },

                              itemCount: ads?.length ?? 6,
                              shrinkWrap: true,
                            ),
                      BlocSelector<MyAdsCubit, MyAdsState, bool>(
                        selector: (state) =>
                            state.listStatus == RequestStatus.loading,
                        builder: (context, loadingAds) {
                          return ListLoadingEndWidget(
                            lastPage: listProvider?.lastPage ?? 1,
                            currentPage: listProvider?.currentPage ?? 1,
                            isLoading: loadingAds,
                            listLessThan:
                                listProvider?.data != null &&
                                listProvider!.data!.length > 4,
                            noMoreText: S.of(context).thereAreNoMoreAds,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
