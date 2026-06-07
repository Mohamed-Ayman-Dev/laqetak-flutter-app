import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/shared/models/photo_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoView extends StatefulWidget {
  static const routeName = '/photo-view';
  final List<PhotoModel> photoList;
  final String? heroTag;

  const PhotoView({super.key, this.photoList = const [], this.heroTag});

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  int _activeIndex = 0;
  late final PageController _pageController;
  late final ScrollController _thumbScrollController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _thumbScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _thumbScrollController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _activeIndex = index);
    _scrollThumbIntoView(index);
  }

  void _onThumbTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollThumbIntoView(int index) {
    const thumbWidth = 52.0 + 8.0; // width + gap
    final offset =
        (index * thumbWidth) -
        (_thumbScrollController.position.viewportDimension / 2) +
        (thumbWidth / 2);
    _thumbScrollController.animateTo(
      offset.clamp(0.0, _thumbScrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final photoList =
        args['photoList'] as List<PhotoModel>? ?? widget.photoList;
    final heroTag = args['heroTag'] ?? widget.heroTag;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DismissiblePage(
        direction: DismissiblePageDismissDirection.multi,
        isFullScreen: true,
        onDismissed: () => Navigator.pop(context),
        child: Stack(
          children: [
            // ── Main gallery ──────────────────────────────────────────────
            PhotoViewGallery.builder(
              itemCount: photoList.length,
              pageController: _pageController,
              scrollDirection: Axis.horizontal,
              loadingBuilder: (_, __) => Center(
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(),
              ),
              builder: (context, index) => PhotoViewGalleryPageOptions(
                heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                imageProvider: _resolveImageProvider(photoList[index]),
              ),
              onPageChanged: _onPageChanged,
            ),

            // ── Top bar (counter + close) ─────────────────────────────────
            Positioned.directional(
              textDirection: Directionality.of(context),
              top: 0,
              start: 0,
              end: 0,
              child: _TopBar(
                current: _activeIndex,
                total: photoList.length,
                onClose: () => Navigator.pop(context),
              ),
            ),

            // ── Thumbnail strip ───────────────────────────────────────────
            Positioned(
              left: 0,
              right: 0,
              bottom: 150,
              child: _ThumbnailStrip(
                photoList: photoList,
                activeIndex: _activeIndex,
                scrollController: _thumbScrollController,
                onTap: _onThumbTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _resolveImageProvider(PhotoModel photo) {
    final url = photo.url ?? '';

    // source == 'file' → local file path
    if (photo.source == 'file') return FileImage(File(url));

    // source == 'asset' AND url doesn't look like a network URL → real asset
    if (photo.source == 'asset' && !url.startsWith('http')) {
      return AssetImage(url);
    }

    // everything else (network URL, or source == 'asset' with http url) → network
    return CachedNetworkImageProvider(url);
  }
}

class _TopBar extends StatelessWidget {
  final int current;
  final int total;
  final VoidCallback onClose;

  const _TopBar({
    required this.current,
    required this.total,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black54, Colors.transparent],
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 16,
        right: 16,
        bottom: 20,
      ),
      child: Row(
        children: [
          Text(
            '${current + 1} / $total',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onClose,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 0.5,
                ),
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThumbnailStrip extends StatelessWidget {
  final List<PhotoModel> photoList;
  final int activeIndex;
  final ScrollController scrollController;
  final ValueChanged<int> onTap;

  const _ThumbnailStrip({
    required this.photoList,
    required this.activeIndex,
    required this.scrollController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.black.withOpacity(0.75),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: photoList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isActive = index == activeIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 70,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isActive ? Colors.white : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Opacity(
                  opacity: isActive ? 1.0 : 0.5,
                  child: CachedNetworkImage(
                    imageUrl: photoList[index].url ?? '',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: Colors.white12),
                    errorWidget: (_, __, ___) =>
                        Container(color: Colors.white10),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//
// class PhotoView extends StatefulWidget {
//   static const routeName = '/photo-view';
//   final List<PhotoModel> photoList;
//   final String? heroTag;
//
//   const PhotoView({super.key, this.photoList = const [], this.heroTag});
//
//   @override
//   State<PhotoView> createState() => _PhotoViewState();
// }
//
// class _PhotoViewState extends State<PhotoView> {
//   int _activeDot = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     PageController phController = PageController();
//     final deviceSize = MediaQuery.of(context).size;
//     final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
//     final photoList =
//         args['photoList'] as List<PhotoModel>? ?? widget.photoList;
//     final heroTag = args['heroTag'] ?? widget.heroTag;
//     List<Widget> getDots() {
//       List<Widget> myList = [];
//       photoList.asMap().forEach((index, _) {
//         myList.add(
//           AnimatedContainer(
//             margin: const EdgeInsets.symmetric(horizontal: 2.0),
//             duration: const Duration(milliseconds: 300),
//             width: _activeDot == index ? 30.0 : 16.0,
//             height: 7.0,
//             decoration: BoxDecoration(
//               color: _activeDot == index
//                   ? Colors.grey
//                   : Theme.of(context).primaryColor,
//               borderRadius: BorderRadius.circular(6.0),
//             ),
//           ),
//         );
//       });
//       return myList;
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: DismissiblePage(
//         direction: DismissiblePageDismissDirection.multi,
//         isFullScreen: true,
//         onDismissed: () {
//           Navigator.pop(context);
//         },
//         child: Stack(
//           children: <Widget>[
//             PhotoViewGallery.builder(
//               itemCount: photoList.length,
//               loadingBuilder: (_, ece) => Center(
//                 child: Platform.isIOS
//                     ? const CupertinoActivityIndicator()
//                     : const CircularProgressIndicator(),
//               ),
//               builder: (BuildContext ctx, int index) =>
//                   PhotoViewGalleryPageOptions(
//                     heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
//                     initialScale: PhotoViewComputedScale.contained,
//                     maxScale: PhotoViewComputedScale.covered * 2,
//                     imageProvider: photoList[index].source == 'asset'
//                         ? photoList[index].source == 'file'
//                         ? FileImage(File(photoList[index].url!))
//                         : CachedNetworkImageProvider(
//                       photoList[index].url!,
//                     )
//                         : CachedNetworkImageProvider(photoList[index].url!)
//                     as ImageProvider,
//                     minScale: PhotoViewComputedScale.contained,
//                   ),
//               scrollDirection: Axis.horizontal,
//               pageController: phController,
//               onPageChanged: (pageIndex) {
//                 setState(() {
//                   _activeDot = pageIndex;
//                 });
//               },
//             ),
//             Positioned.directional(
//               top: 30,
//               end: 15,
//               textDirection: Directionality.of(context),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 borderRadius: BorderRadius.circular(18),
//                 child: Container(
//                   width: 36,
//                   height: 36,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.5),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.close, color: Colors.black),
//                 ),
//               ),
//             ),
//             Positioned(
//               right: 0,
//               left: 0,
//               bottom: 35.0,
//               child: SizedBox(
//                 width: deviceSize.width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: getDots(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
