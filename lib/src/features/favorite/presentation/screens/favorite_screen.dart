import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/models/pagination_list.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/widgets/items_widgets/ad_item.dart';
import '../../../../core/shared/widgets/lists_widgets/empty_list_placeholder_widget.dart';
import '../../../../core/shared/widgets/lists_widgets/list_loading_end_widget.dart';
import '../../../../core/shared/widgets/lists_widgets/smart_refresher_header.dart';
import '../../../../core/shared/widgets/login_first_widget.dart';
import '../../../../core/shared/widgets/shimmers/items/ad_item_shimmer.dart';
import '../../../ad_details/presentation/screens/ad_details_screen.dart';
import '../../../home/presentation/controllers/ads_controller.dart';
import '../../../home/presentation/providers/ads.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite_screen';

  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isAuth) {
        AdsController.getFavAds(refresh: true);
        _scrollController.addListener(_onFavListener);
      }
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
    if (isAuth) {
      await AdsController.getFavAds(refresh: true);
    }
    refreshController.refreshCompleted();
  }

  void _onFavListener() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50.0 &&
        _gettingData == false) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 200), () async {
        _gettingData = true;
        await AdsController.getFavAds(refresh: false);
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
      body: SafeArea(
        bottom: true,
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15).r,
          child: !isAuth
              ? const LoginFirstWidget()
              : SmartRefresher(
                  scrollController: _scrollController,
                  controller: _refreshController,
                  onRefresh: _refresh,
                  header: const SmartRefresherHeader(),
                  child: SingleChildScrollView(
                    child: Selector<Ads, PaginationList<AdModel>?>(
                      selector: (context, provider) => provider.myFavAds,
                      shouldRebuild: (previous, next) => true,
                      builder: (context, listProvider, child) {
                        final ads = listProvider?.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).favoriteAds,
                              style: AppTextStyles.labelMedium.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                            16.heightSpace,
                            ads != null && ads.isEmpty
                                ? EmptyListPlaceholderWidget(
                                    text: S
                                        .of(context)
                                        .thereAreNoFavoriteAdsYet,
                                    paddingTop: 230,
                                  )
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),

                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration.staggeredList(
                                        position: index,
                                        delay: const Duration(milliseconds: 10),
                                        child: SlideAnimation(
                                          verticalOffset: 10,
                                          duration: const Duration(
                                            milliseconds: 800,
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
                                                                  '${ads[index].mainPhoto}-$index-home',
                                                              'ad': ads[index],
                                                            },
                                                          );
                                                    },

                                                    hideDivider:
                                                        index ==
                                                        (ads.length - 1),
                                                    heroTag:
                                                        '${ads[index].mainPhoto}-$index-home',
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
                                                      if (isAuth) {
                                                        HapticFeedback.heavyImpact();
                                                        AdsController.addOrRemoveAdFromFavorites(
                                                          ad: ads[index],
                                                        );
                                                      } else {
                                                        ///guest bottom sheet
                                                        ///
                                                      }
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
                            Selector<Ads, bool>(
                              selector: (context, provider) =>
                                  provider.adsLoadingModel.loadingFavAds,
                              shouldRebuild: (old, newData) => old != newData,
                              builder: (context, loadingAds, child) {
                                return ListLoadingEndWidget(
                                  lastPage: listProvider?.lastPage ?? 1,
                                  currentPage: listProvider?.currentPage ?? 1,
                                  isLoading: loadingAds,
                                  paddingTop: 30,
                                  paddingBottom: 30,
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
