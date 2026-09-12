import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/widgets/buttons_widgets/my_icon_button.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/home/presentation/providers/ads.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../notify_circle.dart';
import 'custom_textField.dart';

class SearchField extends StatelessWidget {
  final void Function(String?)? onChanged;
  final void Function()? onFilterSearch;
  final TextEditingController? searchController;
  final FocusNode? focusNode;
  final bool loadingAds;

  const SearchField({
    super.key,
    this.onChanged,
    this.searchController,
    this.onFilterSearch,
    this.focusNode,
    this.loadingAds = false,
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
                onSubmitted: onChanged,
                onChanged: onChanged,
                focusNode: focusNode,
                controller: searchController,
                hintText: S.of(context).search,
                borderRadius: 20,
                fillColor: AppColors.searchBKColor,
                suffixIcon: loadingAds
                    ? const CupertinoActivityIndicator()
                    : InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          onChanged!(searchController?.text);
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
          Stack(
            children: [
              MyIconButton(
                icon: SvgAssets.assetsSvgFilterIcon,
                onTap: onFilterSearch,
                borderRadius: 20,
                bkColor: AppColors.searchBKColor,
              ),
              Selector<Ads, Map?>(
                selector: (context, provider) => provider.filters,
                builder: (context, filters, child) {
                  return NotifyCircle(
                    showNotify:
                        filters != null &&
                        filters.values.any(
                          (e) =>
                              e != null && ((e is List) ? e.isNotEmpty : true),
                        ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
