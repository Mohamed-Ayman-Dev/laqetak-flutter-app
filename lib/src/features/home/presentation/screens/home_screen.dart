import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:laqetak/src/core/di/locator_service.dart';
import 'package:laqetak/src/core/widgets/cards/ad_item.dart';
import 'package:laqetak/src/core/widgets/lists/empty_list_placeholder_widget.dart';
import 'package:laqetak/src/core/widgets/lists/list_sliver_loading_end_widget.dart';
import 'package:laqetak/src/core/widgets/shimmers/ad_item_shimmer.dart';
import 'package:laqetak/src/features/ad_details/presentation/screens/ad_details_screen.dart';
import 'package:laqetak/src/features/home/presentation/cubit/ads_cubit.dart';
import 'package:laqetak/src/features/home/presentation/cubit/ads_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app_feedback.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/helpers/bottom_helpers.dart';
import '../../../../core/helpers/debouncer.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/fields/search_field.dart';
import '../../../../core/widgets/lists/smart_refresher_header.dart';
import '../widgets/home_filters_header.dart';
import 'filter_screen.dart';

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
  int? _selectedFilterIndex;

  bool _showSearchIcon = false;
  Map<String, dynamic> _filtersData = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdsCubit>().getAds(
        refresh: true,
        filters: _filtersData,
        typeId: _selectedFilterIndex,
        search: searchController.text,
      );
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
    await context.read<AdsCubit>().getAds(
      refresh: true,
      filters: _filtersData,
      typeId: _selectedFilterIndex,
      search: searchController.text,
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
        await context.read<AdsCubit>().getAds(
          refresh: false,
          typeId: _selectedFilterIndex,
          filters: _filtersData,

          search: searchController.text,
        );
        _gettingData = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    searchController.dispose();
    _debounce?.cancel();

    super.dispose();
  }

  void unfocus() {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> filters = [
      S.of(context).all,
      S.of(context).searchForOpportunity,
      S.of(context).searchForInvestor,
    ];
    return BlocListener<AdsCubit, AdsState>(
      listenWhen: (previous, current) =>
          current.adsStatus == RequestStatus.error &&
          previous.adsStatus != RequestStatus.error,
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent != true) return;
        AppFeedback.errorMessage(state.errorMessage);
      },
      child: GestureDetector(
        onTap: () {
          unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
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
                        child: BlocSelector<AdsCubit, AdsState, bool>(
                          selector: (state) => state.loadingSearch,
                          builder: (context, loadingAds) {
                            return SearchField(
                              searchController: searchController,
                              focusNode: focusNode,
                              loadingAds: loadingAds,
                              onChanged: (val) {
                                _searchDeBouncer.run(() {
                                  context.read<AdsCubit>().getAds(
                                    refresh: true,
                                    showLoadingSearch: true,
                                    filters: _filtersData,
                                    search: searchController.text,
                                    typeId: _selectedFilterIndex,
                                  );
                                });
                              },
                              onFilterSearch: () async {
                                final filters =
                                    await LocatorService
                                            .navigationService
                                            .currentState
                                            ?.pushNamed(
                                              FilterScreen.routeName,
                                              arguments: _filtersData,
                                            )
                                        as Map<String, dynamic>?;

                                if (filters == null) return;
                                _filtersData = filters;
                                context.read<AdsCubit>().getAds(
                                  refresh: true,
                                  showLoadingSearch: true,
                                  filters: _filtersData,
                                  search: searchController.text,
                                  typeId: _selectedFilterIndex,
                                );
                              },
                            );
                          },
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
                    filters: filters,
                    selectedIndex: _selectedFilterIndex ?? 0,
                    onFilterTap: (index) {
                      unfocus();

                      setState(() {
                        if (index == 0) {
                          _selectedFilterIndex = null;
                        } else {
                          _selectedFilterIndex = index;
                        }
                      });
                      context.read<AdsCubit>().getAds(
                        refresh: true,
                        filters: _filtersData,

                        search: searchController.text,
                        typeId: _selectedFilterIndex,
                      );
                    },
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 10.h)),

                // ── Ads List ────────────────────────────────────────
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ).r.copyWith(bottom: 30.h),
                  sliver: BlocSelector<AdsCubit, AdsState, List<AdModel>?>(
                    selector: (state) => state.ads?.data,
                    builder: (context, ads) {
                      return ads != null && ads.isEmpty
                          ? SliverToBoxAdapter(
                              child: EmptyListPlaceholderWidget(
                                text: S.of(context).thereAreNoAdsYet,
                                paddingTop: 200,
                              ),
                            )
                          : SliverList.builder(
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
                                                unfocus();

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

                                              hideDivider:
                                                  index == (ads.length - 1),
                                              heroTag:
                                                  '${ads[index].mainPhoto}-$index-home',
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
                                              onLike: () {
                                                unfocus();

                                                if (isAuth) {
                                                  HapticFeedback.heavyImpact();
                                                  context
                                                      .read<AdsCubit>()
                                                      .toggleFavorite(
                                                        ads[index],
                                                      );
                                                } else {
                                                  BottomHelpers.showGuestBottomSheet(
                                                    context,
                                                  );
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
                            );
                    },
                  ),
                ),
                BlocSelector<AdsCubit, AdsState, PaginationList<AdModel>?>(
                  selector: (state) => state.ads,
                  builder: (context, listProvider) {
                    return BlocSelector<AdsCubit, AdsState, bool>(
                      selector: (state) =>
                          state.adsStatus == RequestStatus.loading,
                      builder: (context, loadingAds) {
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
        ),
      ),
    );
  }
}
