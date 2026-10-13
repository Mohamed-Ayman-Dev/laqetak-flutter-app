// ─── Image Picker Widget ───────────────────────────────
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laqetak/src/core/constants/svg_assets.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/models/photo_model.dart';
import '../../../../core/themes/colors.dart';
import 'ad_image_item.dart';

class AdImagePicker extends StatefulWidget {
  const AdImagePicker({
    super.key,
    required this.onChanged,
    this.initialPhotos = const [],
  });

  final List<PhotoModel> initialPhotos;
  final void Function({
    required List<XFile> newPhotos,
    required List<num> photosToRemove,
  })
  onChanged;

  @override
  State<AdImagePicker> createState() => _AdImagePickerState();
}

class _AdImagePickerState extends State<AdImagePicker> {
  static const int _maxImages = 4;
  final ImagePicker _picker = ImagePicker();

  late final List<AdImageItem> _images;
  final List<num> _removedIds = []; // IDs اللي اتمسحت
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _images = widget.initialPhotos
        .map<AdImageItem>((p) => AdImageItemNetwork(p))
        .toList();
  }

  void _notify() {
    widget.onChanged(
      newPhotos: _images
          .whereType<AdImageItemLocal>()
          .map((e) => e.file)
          .toList(),
      photosToRemove: List.unmodifiable(_removedIds),
    );
  }

  Future<void> _pickImages() async {
    final remaining = _maxImages - _images.length;
    if (remaining <= 0) return;

    final picked = await _picker.pickMultiImage(imageQuality: 80);
    if (picked.isEmpty) return;

    setState(() {
      _images.addAll(picked.take(remaining).map((f) => AdImageItemLocal(f)));
      _selectedIndex = _images.length - 1;
    });
    _notify();
  }

  void _removeImage(int index) {
    final item = _images[index];

    // لو network → حفظ الـ ID للحذف
    if (item is AdImageItemNetwork && item.photo.id != null) {
      _removedIds.add(item.photo.id!);
    }

    setState(() {
      _images.removeAt(index);
      _selectedIndex = (_images.isEmpty
          ? 0
          : (_selectedIndex >= _images.length
                ? _images.length - 1
                : _selectedIndex));
    });
    _notify();
  }

  // ─── Build ───

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildMainPreview(), 12.heightSpace, _buildThumbnailRow()],
    );
  }

  Widget _buildMainPreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10).r,
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _images.isEmpty
                ? _buildEmptyPreview()
                : _buildItemImage(_images[_selectedIndex], height: 180.h),
          ),
          if (_images.isNotEmpty)
            Positioned(
              bottom: 12.h,
              left: 12.w,
              child: _DeleteButton(
                onTap: () => _removeImage(_selectedIndex),
                isMain: true,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItemImage(AdImageItem item, {required double height}) {
    return switch (item) {
      AdImageItemLocal(:final file) => Image.file(
        File(file.path),
        key: ValueKey('local_${file.path}'),
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
      ),
      AdImageItemNetwork(:final photo) => CachedNetworkImage(
        key: ValueKey('network_${photo.id}'),
        imageUrl: photo.url ?? '',
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
      ),
    };
  }

  Widget _buildThumbnailRow() {
    return SizedBox(
      height: 53.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _maxImages + 1,
        separatorBuilder: (_, __) => 8.widthSpace,
        itemBuilder: (context, index) {
          if (index == 0) return _buildAddThumbnail();
          final imageIndex = index - 1;
          if (imageIndex < _images.length) {
            return _buildImageThumbnail(
              imageIndex,
              imageIndex == _selectedIndex,
            );
          }
          return _buildEmptyThumbnail();
        },
      ),
    );
  }

  Widget _buildImageThumbnail(int index, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 61.w,
        height: 53.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9).r,
              child: switch (_images[index]) {
                AdImageItemLocal(:final file) => Image.file(
                  File(file.path),
                  fit: BoxFit.cover,
                ),
                AdImageItemNetwork(:final photo) => CachedNetworkImage(
                  imageUrl: photo.url ?? '',
                  fit: BoxFit.cover,
                ),
              },
            ),
            Positioned(
              bottom: 4.h,
              right: 4.w,
              child: _DeleteButton(size: 22, onTap: () => _removeImage(index)),
            ),
          ],
        ),
      ),
    );
  }

  // باقي الـ widgets زي ما هي (_buildEmptyPreview, _buildEmptyThumbnail, _buildAddThumbnail)

  Widget _buildAddThumbnail() {
    return GestureDetector(
      onTap: _pickImages,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: const [3, 3],
          strokeWidth: 1,
          color: AppColors.dottedBorderColor,
          radius: Radius.circular(10.r),
          padding: EdgeInsets.all(1).r,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 61.w,
          height: 53.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10).r),
          child: Center(
            child: Center(
              child: SvgPicture.asset(
                SvgAssets.assetsSvgAddRound,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyPreview() {
    return GestureDetector(
      onTap: _pickImages,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: const [3, 3],
          strokeWidth: 1,
          color: AppColors.dottedBorderColor,
          radius: Radius.circular(10.r),
          padding: EdgeInsets.all(1).r,
        ),
        child: Container(
          key: const ValueKey('empty'),
          width: double.infinity,
          height: 129.h,
          decoration: BoxDecoration(
            color: AppColors.uploadImageBKColor,
            borderRadius: BorderRadius.circular(10).r,
          ),
          child: Center(
            child: SvgPicture.asset(
              SvgAssets.assetsSvgUploadImage,
              width: 43.w,
              height: 43.h,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Empty Placeholder Thumbnail ───
Widget _buildEmptyThumbnail() {
  return DottedBorder(
    options: RoundedRectDottedBorderOptions(
      dashPattern: const [3, 3],
      strokeWidth: 1,
      color: AppColors.dottedBorderColor,
      radius: Radius.circular(10.r),
      padding: EdgeInsets.all(1).r,
    ),
    child: Container(
      width: 61.w,
      height: 53.h,
      decoration: BoxDecoration(
        color: AppColors.uploadImageBKColor,
        borderRadius: BorderRadius.circular(10).r,
      ),
      child: Center(
        child: SvgPicture.asset(
          SvgAssets.assetsSvgUploadImage,
          width: 24.w,
          height: 24.h,
        ),
      ),
    ),
  );
}
// ─── Reusable Delete Button ────────────────────────────

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({
    required this.onTap,
    this.size = 36,
    this.isMain = false,
  });

  final VoidCallback onTap;
  final double size;
  final bool isMain;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.w,
        height: size.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8).r,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: isMain
              ? SvgPicture.asset(
                  SvgAssets.assetsSvgDeleteIcon,
                  height: 24.h,
                  width: 24.w,
                )
              : SvgPicture.asset(
                  SvgAssets.assetsSvgTrashBold,
                  height: 14.h,
                  width: 14.w,
                ),
        ),
      ),
    );
  }
}
