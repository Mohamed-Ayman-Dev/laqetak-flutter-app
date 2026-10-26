import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/widgets/buttons/app_filter_button.dart';

class FilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<String> filters;
  final int selectedIndex;
  final void Function(int) onFilterTap;

  FilterHeaderDelegate({
    required this.filters,
    required this.selectedIndex,
    required this.onFilterTap,
  });

  // ✅ Must match exactly what the child renders
  @override
  double get minExtent => 42.h + 16.h; // SizedBox height + vertical padding

  @override
  double get maxExtent => 42.h + 16.h;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      // ← vertical padding counted above
      child: SizedBox(
        height: 42.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          separatorBuilder: (_, __) => SizedBox(width: 9.w),
          itemBuilder: (context, index) {
            return AppFilterButton(
              title: filters[index],
              isSelected: selectedIndex == index,
              onTap: () => onFilterTap(index),
            );
          },
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(FilterHeaderDelegate oldDelegate) =>
      oldDelegate.selectedIndex != selectedIndex;
}
