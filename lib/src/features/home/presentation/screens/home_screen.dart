import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/shared/models/pagination_list.dart';
import 'package:invastro/src/core/shared/widgets/items_widgets/ad_item.dart';
import 'package:invastro/src/core/shared/widgets/lists_widgets/list_sliver_loading_end_widget.dart';
import 'package:invastro/src/core/shared/widgets/shimmers/items/ad_item_shimmer.dart';
import 'package:invastro/src/features/ad_details/presentation/screens/ad_details_screen.dart';
import 'package:invastro/src/features/home/presentation/controllers/ads_controller.dart';
import 'package:invastro/src/features/home/presentation/providers/ads.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/helpers/debouncer.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../../../../core/shared/widgets/fields_widgets/search_field.dart';
import '../../../../core/shared/widgets/lists_widgets/smart_refresher_header.dart';
import '../widgets/home_filters_header.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final _searchDeBouncer = Debouncer(milliseconds: 300);
  final FocusNode focusNode = FocusNode();
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['الكل', 'إبحث عن فرصة', 'إبحث عن مستثمر'];
  bool _showSearchIcon = false;
  final Set<int> _likedAds = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocatorService.auth.clearNotificationsCount();
      AdsController.getAds(refresh: true);
      _scrollController.addListener(() {
        final shouldShow = _scrollController.offset > 64.h;
        if (shouldShow != _showSearchIcon) {
          setState(() => _showSearchIcon = shouldShow);
        }
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
    await AdsController.getAds(refresh: true);
    refreshController.refreshCompleted();
  }

  void _onStoresListener() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50.0 &&
        _gettingData == false) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 200), () async {
        _gettingData = true;
        await AdsController.getAds(refresh: false);
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
      appBar: CustomAppbar(
        icons: [AppbarIcons.drawer, AppbarIcons.logo],
        onSearch: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
          focusNode.requestFocus();
        },
        ishHomeLayoutDrawer: true,

        showSearchIcon: _showSearchIcon,
        dontShowBackButton: true,
      ),

      // drawer: const CustomDrawer(),
      body: SmartRefresher(
        scrollController: _scrollController,
        controller: _refreshController,
        onRefresh: _refresh,
        header: const SmartRefresherHeader(),
        child: CustomScrollView(
          slivers: [
            // ── Search — يختفي/يظهر بـ animation ──────────────
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              floating: true,
              //  يرجع لما تسكرول لفوق
              snap: true,
              // يكمل الـ animation مش نص
              expandedHeight: 64.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ).copyWith(bottom: 8.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SearchField(
                      searchController: searchController,
                      focusNode: focusNode,
                      onSubmittedSearch: (val) => _searchDeBouncer.run(() {}),
                      onFilterSearch: (form) {},
                    ),
                  ),
                ),
                collapseMode: CollapseMode.pin,
              ),
            ),

            // ── Filters — ثابتة دايماً ──────────────────────────
            SliverPersistentHeader(
              pinned: true,
              delegate: FilterHeaderDelegate(
                filters: _filters,
                selectedIndex: _selectedFilterIndex,
                onFilterTap: (index) {
                  setState(() => _selectedFilterIndex = index);
                },
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            // ── Ads List ────────────────────────────────────────
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ).r.copyWith(bottom: 30.h),
              sliver: Selector<Ads, List<AdModel>?>(
                selector: (context, provider) => provider.myAds?.data,
                shouldRebuild: (previous, next) => true,
                builder: (context, ads, child) {
                  return SliverList.builder(
                    itemCount: ads?.length ?? 6,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: const Duration(milliseconds: 10),
                        child: SlideAnimation(
                          verticalOffset: 20,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: ads == null
                                ? AdItemShimmer()
                                : AdItem(
                                    category: ads[index].category?.name ?? '',
                                    expired: index == 1 || index == 3,
                                    image: ads[index].mainPhoto ?? '',
                                    onTab: () {
                                      LocatorService
                                          .navigationService
                                          .currentState
                                          ?.pushNamed(
                                            AdDetailsScreen.routeName,
                                            arguments: {
                                              'hero':
                                                  '${ads[index].mainPhoto}-$index-home',
                                              'ad': ads[index],
                                            },
                                          );
                                    },

                                    hideDivider: index == (ads.length - 1),
                                    heroTag:
                                        '${ads[index].mainPhoto}-$index-home',
                                    customerName:
                                        ads[index].customer?.name ?? '',
                                    location: ads[index].customer?.name ?? '',
                                    name: ads[index].title ?? '',
                                    price: ads[index].investmentAmount ?? '',
                                    time: ads[index].publishedAt ?? '',
                                    sector: ads[index].sector?.name ?? '',
                                    onLike: () {
                                      setState(() {
                                        if (_likedAds.contains(index)) {
                                          _likedAds.remove(index);
                                        } else {
                                          _likedAds.add(index);
                                        }
                                      });
                                    },

                                    isLiked: ads[index].isFavorite ?? false,
                                  ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Selector<Ads, PaginationList<AdModel>?>(
              selector: (context, provider) => provider.myAds,
              shouldRebuild: (previous, next) => true,

              builder: (context, listProvider, child) {
                return Selector<Ads, bool>(
                  selector: (context, provider) =>
                      provider.adsLoadingModel.loadingAds,
                  builder: (context, loadingAds, child) {
                    return ListSliverLoadingEndWidget(
                      lastPage: listProvider?.lastPage ?? 1,
                      currentPage: listProvider?.currentPage ?? 1,
                      isLoading: loadingAds,
                      listLessThan:
                          listProvider?.data != null &&
                          listProvider!.data!.length > 4,
                      title: S.of(context).thereAreNoMoreAds,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
