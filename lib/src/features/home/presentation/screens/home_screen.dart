import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:invastro/src/core/shared/widgets/items_widgets/ad_item.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/constants/mock_data_for_loading.dart';
import '../../../../core/helpers/debouncer.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../../../../core/shared/widgets/fields_widgets/search_field.dart';
import '../widgets/home_filters_header.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final deBouncer = Debouncer(milliseconds: 300);
  final FocusNode focusNode = FocusNode();
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['الكل', 'إبحث عن فرصة', 'إبحث عن مستثمر'];
  bool _showSearchIcon = false;
  final ScrollController _scrollController = ScrollController();
  final Set<int> _likedAds = {};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final shouldShow = _scrollController.offset > 64.h;
      if (shouldShow != _showSearchIcon) {
        setState(() => _showSearchIcon = shouldShow);
      }
    });
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
        showSearchIcon: _showSearchIcon,
        dontShowBackButton: true,
      ),
      body: CustomScrollView(
        controller: _scrollController,

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
                    onSubmittedSearch: (val) => deBouncer.run(() {}),
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
            ).r.copyWith(bottom: 130.h),
            sliver: SliverList.builder(
              itemCount: MockDataForLoading.mockAds.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 40),
                  child: SlideAnimation(
                    verticalOffset: 20,
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: FadeInAnimation(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: AdItem(
                        type: index == 1 || index == 3
                            ? 'chance'
                            : 'not-chance',
                        expired: index == 1 || index == 3,
                        image: MockDataForLoading.mockAds[index]['image'],
                        onTab: () {},

                        hideDivider:
                            index == (MockDataForLoading.mockAds.length - 1),
                        heroTag:
                            '${MockDataForLoading.mockAds[index]['image']}-$index',
                        onLike: () {
                          setState(() {
                            if (_likedAds.contains(index)) {
                              _likedAds.remove(index);
                            } else {
                              _likedAds.add(index);
                            }
                          });
                        },
                        isLiked: _likedAds.contains(index),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
