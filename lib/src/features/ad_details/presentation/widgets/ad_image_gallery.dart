import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/widgets/photoview.dart';
import 'package:invastro/src/core/themes/colors.dart';

import '../../../../core/shared/models/photo_model.dart';
import '../../../../core/shared/widgets/labels_widgets/ad_expired_label.dart';
import '../../../../core/shared/widgets/labels_widgets/ad_label.dart';

class AdImageGallery extends StatefulWidget {
  final String type;
  final bool isExpired;
  final String hero;
  final List<String> images;

  const AdImageGallery({
    super.key,
    this.isExpired = false,
    required this.images,
    required this.type,
    required this.hero,
  });

  @override
  State<AdImageGallery> createState() => _AdImageGalleryState();
}

class _AdImageGalleryState extends State<AdImageGallery> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Main Image ──────────────────────────────────────────────────
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            context.pushTransparentRoute(
              PhotoView(
                heroTag: widget.hero,
                photoList: widget.images
                    .map((e) => PhotoModel(url: e, source: 'asset'))
                    .toList(),
              ),
            );
          },
          child: Hero(
            tag: widget.hero,

            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: SizedBox(
                      key: ValueKey(_selectedIndex),
                      width: double.infinity,
                      height: 237.h,
                      child: _AdImage(url: widget.images[_selectedIndex]),
                    ),
                  ),
                ),
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 22.w,
                  child: AdLabel(
                    labelText: widget.type,
                    padding: EdgeInsets.fromLTRB(42, 9, 42, 9).r,
                    fontSize: 14,
                  ),
                ),
                if (widget.isExpired)
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    bottom: 5.r,
                    start: 8.w,
                    child: AdExpiredLabel(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5).r,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
        ),

        11.heightSpace,
        // ── Thumbnails ──────────────────────────────────────────────────
        SizedBox(
          height: 74.h,
          child: ListView.separated(
            reverse: true,
            // RTL
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            separatorBuilder: (_, __) => 10.widthSpace,
            itemBuilder: (_, i) {
              final isSelected = _selectedIndex == i;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 106.w,
                  height: 74.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: _AdImage(url: widget.images[i]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── helper: handles both asset & network ──────────────────────────────────

class _AdImage extends StatelessWidget {
  const _AdImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
    return Image.asset(url, fit: BoxFit.cover);
  }
}
