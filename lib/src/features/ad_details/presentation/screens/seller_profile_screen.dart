import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart'
    show AnimationConfiguration, SlideAnimation, FadeInAnimation;
import 'package:invastro/src/core/constants/app_feedback.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:invastro/src/core/widgets/custom_appbar.dart';
import 'package:invastro/src/core/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/widgets/lists_widgets/list_loading_end_widget.dart';
import 'package:invastro/src/features/ad_details/presentation/cubit/ad_details_cubit.dart';
import 'package:invastro/src/features/ad_details/presentation/cubit/ad_details_state.dart';
import 'package:invastro/src/features/ad_details/presentation/screens/ad_details_screen.dart';
import 'package:invastro/src/features/ad_details/presentation/widgets/customer_header.dart';
import 'package:invastro/src/features/ad_details/presentation/widgets/shimmers/customer_header_shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/customer_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../../../core/widgets/items_widgets/ad_item.dart';
import '../../../../core/widgets/lists_widgets/empty_list_placeholder_widget.dart';
import '../../../../core/widgets/lists_widgets/smart_refresher_header.dart';
import '../../../../core/widgets/shimmers/items/ad_item_shimmer.dart';

class SellerProfileScreen extends StatefulWidget {
  static const routeName = '/seller_profile_screen';

  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  final Set<int> _likedAds = {};
  CustomerModel? _customer;
  bool once = false;

  @override
  void didChangeDependencies() {
    if (!once) {
      final argsCustomer =
          ModalRoute.of(context)?.settings.arguments as CustomerModel?;
      if (argsCustomer != null) {
        _customer = argsCustomer;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.read<AdDetailsCubit>().getCustomerAds(
          refresh: true,
          id: _customer?.id ?? 0,
        );
      });
      once = true;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        _onStoresListener();
      });
    });
  }

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  bool _gettingData = false;

  Future<void> _refresh() async {
    final refreshController = _refreshController;
    await context.read<AdDetailsCubit>().getCustomerAds(
      refresh: true,
      id: _customer?.id ?? 0,
    );
    refreshController.refreshCompleted();
  }

  void _onStoresListener() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50.0 &&
        _gettingData == false) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 200), () async {
        _gettingData = true;
        await context.read<AdDetailsCubit>().getCustomerAds(
          refresh: false,
          id: _customer?.id ?? 0,
        );
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
    final customerId = _customer?.id ?? 0;
    return Scaffold(
      appBar: CustomAppbar(
        icons: [AppbarIcons.logo, AppbarIcons.drawer],
        flexRight: 8,
      ),
      drawer: CustomDrawer(),
      body: BlocListener<AdDetailsCubit, AdDetailsState>(
        listenWhen: (previous, current) =>
            current.hasCustomerAdsError(customerId) &&
            !previous.hasCustomerAdsError(customerId),
        listener: (context, state) {
          AppFeedback.errorMessage(state.errorMessage);
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SmartRefresher(
              scrollController: _scrollController,
              controller: _refreshController,
              onRefresh: _refresh,
              header: const SmartRefresherHeader(),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 28).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_customer == null)
                      CustomerHeaderShimmer()
                    else
                      CustomerHeader(customer: _customer),
                    10.heightSpace,
                    Divider(height: 40.h, endIndent: 22.w, indent: 22.w),
                    Align(
                      alignment: AlignmentGeometry.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19.0).r,
                        child: Text(
                          S.of(context).ads,
                          style: AppTextStyles.labelMedium.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                    BlocSelector<
                      AdDetailsCubit,
                      AdDetailsState,
                      PaginationList<AdModel>?
                    >(
                      selector: (state) => state.customerAds[customerId],
                      builder: (context, listProvider) {
                        List<AdModel>? ads = listProvider?.data;
                        return ads != null && ads.isEmpty
                            ? EmptyListPlaceholderWidget(
                                text: S.of(context).thereAreNoAdsYet,
                                paddingTop: 200,
                              )
                            : Column(
                                children: [
                                  ListView.builder(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 17,
                                      vertical: 24,
                                    ).r,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration.staggeredList(
                                        position: index,
                                        delay: const Duration(milliseconds: 10),
                                        child: SlideAnimation(
                                          verticalOffset: 20,
                                          duration: const Duration(
                                            milliseconds: 500,
                                          ),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          child: FadeInAnimation(
                                            duration: const Duration(
                                              milliseconds: 1000,
                                            ),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            child: ads == null
                                                ? AdItemShimmer()
                                                : AdItem(
                                                    category:
                                                        ads[index]
                                                            .category
                                                            ?.name ??
                                                        '',
                                                    expired:
                                                        ads[index].status ==
                                                        'closed',
                                                    image:
                                                        ads[index].mainPhoto ??
                                                        '',
                                                    onTab: () {
                                                      LocatorService
                                                          .navigationService
                                                          .currentState
                                                          ?.pushNamed(
                                                            AdDetailsScreen
                                                                .routeName,
                                                            arguments: {
                                                              'hero':
                                                                  '${ads[index].mainPhoto}-$index-customer',
                                                              'ad': ads[index],
                                                            },
                                                          );
                                                    },
                                                    hideDivider:
                                                        index ==
                                                        (ads.length - 1),
                                                    heroTag:
                                                        '${ads[index].mainPhoto}-$index-customer',
                                                    customerName:
                                                        ads[index]
                                                            .customer
                                                            ?.name ??
                                                        '',
                                                    location:
                                                        ads[index].city?.name ??
                                                        '',
                                                    name:
                                                        ads[index].title ?? '',
                                                    price:
                                                        ads[index]
                                                            .investmentAmount ??
                                                        '',
                                                    time:
                                                        ads[index]
                                                            .publishedAt ??
                                                        '',
                                                    sector:
                                                        ads[index]
                                                            .sector
                                                            ?.name ??
                                                        '',
                                                    onLike: () {
                                                      setState(() {
                                                        if (_likedAds.contains(
                                                          index,
                                                        )) {
                                                          _likedAds.remove(
                                                            index,
                                                          );
                                                        } else {
                                                          _likedAds.add(index);
                                                        }
                                                      });
                                                    },
                                                    isLiked:
                                                        ads[index].isFavorite ??
                                                        false,
                                                  ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: ads?.length ?? 6,
                                    shrinkWrap: true,
                                  ),
                                  BlocSelector<
                                    AdDetailsCubit,
                                    AdDetailsState,
                                    bool
                                  >(
                                    selector: (state) =>
                                        state.customerAdsStatus[customerId] ==
                                        RequestStatus.loading,
                                    builder: (context, loadingAds) {
                                      return ListLoadingEndWidget(
                                        lastPage: listProvider?.lastPage ?? 1,
                                        currentPage:
                                            listProvider?.currentPage ?? 1,
                                        isLoading: loadingAds,
                                        listLessThan:
                                            listProvider?.data != null &&
                                            listProvider!.data!.length > 4,
                                        noMoreText: S
                                            .of(context)
                                            .thereAreNoMoreAds,
                                      );
                                    },
                                  ),
                                ],
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
