import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/my_icon_button.dart';
import 'package:invastro/src/core/themes/colors.dart';

import '../fields_widgets/custom_textField.dart';

class SearchField extends StatelessWidget {
  final void Function(String?)? onSubmittedSearch;
  final void Function(Map<String, dynamic>)? onFilterSearch;
  final TextEditingController? searchController;
  final FocusNode? focusNode;

  const SearchField({
    super.key,
    this.onSubmittedSearch,
    this.searchController,
    this.onFilterSearch,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: Row(
        children: [
          Expanded(
            child: Hero(
              tag: 'appbar-search',
              child: CustomTextField(
                borderColor: Colors.transparent,
                onSubmitted: onSubmittedSearch,
                onChanged: onSubmittedSearch,
                focusNode: focusNode,
                controller: searchController,
                hintText: "البحث",
                borderRadius: 20,
                fillColor: AppColors.searchBKColor,
                suffixIcon: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    onSubmittedSearch!(searchController?.text);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14.0).r,
                    child: SvgPicture.asset(
                      SvgAssets.assetsSvgSearchIcon,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                ),
                // suffix: InkWell(
                //   splashColor: Colors.transparent,
                //   onTap: () {
                //     BottomUtils.showFilterBottomSheet(
                //       context,
                //       onFilterSearch: onFilterSearch,
                //     );
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.all(17.0).r,
                //     child: SvgPicture.asset(
                //       'assets/images/filter-vertical.svg',
                //       height: 20.h,
                //       width: 20.w,
                //     ),
                //   ),
                // ),
              ),
            ),
          ),
          6.widthSpace,
          MyIconButton(
            icon: SvgAssets.assetsSvgFilterIcon,
            onTap: () {},
            borderRadius: 20,
            bkColor: AppColors.searchBKColor,
          ),
        ],
      ),
    );
  }
}
