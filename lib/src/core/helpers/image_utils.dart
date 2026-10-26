import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart'
    show
        CropAspectRatio,
        ImageCropper,
        CroppedFile,
        AndroidUiSettings,
        IOSUiSettings;
import 'package:image_picker/image_picker.dart';
import 'package:laqetak/src/core/widgets/images/photo_view.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../generated/l10n.dart';
import '../di/locator_service.dart';
import '../shared/models/photo_model.dart';
import '../themes/colors.dart';
import '../widgets/custom_text.dart';

class ImageUtils {
  static void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: CustomText(S.of(context).permissionRequired),
        content: CustomText(
          S.of(context).pleaseAllowAccessToTheGalleryInSettings,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: CustomText(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () async {
              await openAppSettings();
              Navigator.pop(context);
            },
            child: CustomText(S.of(context).openSettings),
          ),
        ],
      ),
    );
  }

  ///how to use:
  /// Utils.openPhoto(
  ///   photos: [AppPhoto(source: 'assets', url: 'assets/images/image.png')],
  ///  heroTag: 'message-${messageId}-$i'
  ///  )
  ///or
  /// context.pushTransparentRoute(PhotoViewScreen(
  ///   heroTag: (widget.heroTag != null)
  ///    ? widget.heroTag!
  ///      : 'product-${p.basename(urlImage)}-$index',
  ///   photoList: widget.images!
  ///       .map<AppPhoto>((e) => AppPhoto(source: 'assets', url: e))
  ///       .toList(),
  ///     ));

  static void openPhoto({String? heroTag, List<PhotoModel>? photos}) async {
    final context = LocatorService.navigationService.currentState!.context;
    await context.pushTransparentRoute(
      PhotoView(heroTag: heroTag, photoList: photos ?? []),
    );
  }

  static Future<XFile?> _cropImage(
    XFile pickedFile, {
    CropAspectRatio? aspectRatio,
  }) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: aspectRatio,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: S.current.adjustImage,
          lockAspectRatio: aspectRatio == null ? false : true,
          hideBottomControls: false,
        ),
        IOSUiSettings(
          title: S.current.adjustImage,
          aspectRatioLockEnabled: aspectRatio == null ? false : true,
          resetAspectRatioEnabled: aspectRatio == null ? true : false,
        ),
      ],
    );

    if (croppedFile != null) {
      return XFile(croppedFile.path);
    }
    return null;
  }

  static Future<XFile?> openPickingOptions(
    BuildContext context, {
    int imageQuality = 70,
  }) async {
    return await showModalBottomSheet<XFile?>(
      context: context,
      builder: (context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  final PermissionStatus cameraStatus = await Permission.camera
                      .request();
                  if (cameraStatus.isPermanentlyDenied) {
                    _showSettingsDialog(
                      context,
                    ); // Show dialog to open settings
                  } else {
                    XFile? myFile = await _getImageFromCamera(
                      imageQuality: imageQuality,
                    );
                    if (myFile != null && context.mounted) {
                      LocatorService.navigationService.currentState!.pop(
                        myFile,
                      );
                    }
                  }
                },
                icon: const Icon(
                  Icons.camera_alt,
                  color: AppColors.primaryColor,
                ),
                iconSize: 28.0,
                tooltip: 'Camera',
              ),
              IconButton(
                onPressed: () async {
                  XFile? myFile = await getImageFromGallery(
                    imageQuality: imageQuality,
                  );
                  if (myFile != null && context.mounted) {
                    LocatorService.navigationService.currentState!.pop(myFile);
                  }
                },
                icon: const Icon(
                  Icons.photo_library,
                  color: AppColors.primaryColor,
                ),
                iconSize: 28.0,
                tooltip: 'Gallery',
              ),
            ],
          ),
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(26.0),
          topLeft: Radius.circular(26.0),
        ),
      ),
    );
  }

  static Future<XFile?> _getImageFromCamera({int imageQuality = 70}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
    );
    if (pickedFile != null) {
      return await _cropImage(pickedFile);
    }
    return null;
  }

  static Future<XFile?> getImageFromGallery({int imageQuality = 70}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );

    if (pickedFile != null) {
      return await _cropImage(pickedFile);
    }
    return null;
  }

}
