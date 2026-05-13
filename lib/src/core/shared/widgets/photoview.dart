import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invastro/src/core/shared/models/app_photo.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoView extends StatefulWidget {
  static const routeName = '/photo-view';
  final List<AppPhoto> photoList;
  final String? heroTag;

  const PhotoView({super.key, this.photoList = const [], this.heroTag});

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  int _activeDot = 0;

  @override
  Widget build(BuildContext context) {
    PageController phController = PageController();
    final deviceSize = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final photoList = args['photoList'] as List<AppPhoto>? ?? widget.photoList;
    final heroTag = args['heroTag'] ?? widget.heroTag;
    List<Widget> getDots() {
      List<Widget> myList = [];
      photoList.asMap().forEach((index, _) {
        myList.add(
          AnimatedContainer(
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            duration: const Duration(milliseconds: 300),
            width: _activeDot == index ? 30.0 : 16.0,
            height: 7.0,
            decoration: BoxDecoration(
              color: _activeDot == index
                  ? Colors.grey
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        );
      });
      return myList;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DismissiblePage(
        direction: DismissiblePageDismissDirection.multi,
        isFullScreen: true,
        onDismissed: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: <Widget>[
            PhotoViewGallery.builder(
              itemCount: photoList.length,
              loadingBuilder: (_, ece) => Center(
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(),
              ),
              builder: (BuildContext ctx, int index) =>
                  PhotoViewGalleryPageOptions(
                    heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
                    initialScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    imageProvider: photoList[index].source == 'asset'
                        ? photoList[index].source == 'file'
                              ? FileImage(File(photoList[index].url!))
                              : AssetImage(photoList[index].url!)
                        : CachedNetworkImageProvider(photoList[index].url!)
                              as ImageProvider,
                    minScale: PhotoViewComputedScale.contained,
                  ),
              scrollDirection: Axis.horizontal,
              pageController: phController,
              onPageChanged: (pageIndex) {
                setState(() {
                  _activeDot = pageIndex;
                });
              },
            ),
            Positioned.directional(
              top: 30,
              end: 15,
              textDirection: Directionality.of(context),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.black),
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 35.0,
              child: SizedBox(
                width: deviceSize.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: getDots(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
