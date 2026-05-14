// ─── Image Picker Widget ───────────────────────────────
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/themes/colors.dart';

class AdImagePicker extends StatefulWidget {
  const AdImagePicker({super.key, required this.onImagesChanged});

  final void Function(List<XFile>) onImagesChanged;

  @override
  State<AdImagePicker> createState() => _AdImagePickerState();
}

class _AdImagePickerState extends State<AdImagePicker> {
  static const int _maxImages = 4;
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];
  int _selectedIndex = 0;

  Future<void> _pickImages() async {
    final remaining = _maxImages - _images.length;
    if (remaining <= 0) return;

    final picked = await _picker.pickMultiImage(imageQuality: 80);
    if (picked.isEmpty) return;

    setState(() {
      _images.addAll(picked.take(remaining));
      _selectedIndex = _images.length - 1;
    });
    widget.onImagesChanged(_images);
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      if (_selectedIndex >= _images.length) {
        _selectedIndex = (_images.length - 1).clamp(0, _maxImages);
      }
    });
    widget.onImagesChanged(_images);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildMainPreview(), 12.heightSpace, _buildThumbnailRow()],
    );
  }

  // ─── Main Preview ───
  Widget _buildMainPreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10).r,
      child: Stack(
        children: [
          // Image or placeholder
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _images.isEmpty
                ? _buildEmptyPreview()
                : Image.file(
                    File(_images[_selectedIndex].path),
                    key: ValueKey(_images[_selectedIndex].path),
                    width: double.infinity,
                    height: 180.h,
                    fit: BoxFit.cover,
                  ),
          ),

          // Delete button (top-left)
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

  // ─── Thumbnail Row ───
  // ─── Thumbnail Row ───
  Widget _buildThumbnailRow() {
    return SizedBox(
      height: 53.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _maxImages + 1,
        // 5 placeholders + 1 add button = دايمًا ثابت
        separatorBuilder: (_, __) => 8.widthSpace,
        itemBuilder: (context, index) {
          // index 0 (آخر واحد بسبب reverse) = add button
          if (index == 0) return _buildAddThumbnail();

          // باقي الـ slots (1 → 5)
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
              child: Image.file(File(_images[index].path), fit: BoxFit.cover),
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
