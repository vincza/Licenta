import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MediaService {
  Future<File?> pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final ImageCropper _imageCropper = ImageCropper();
      File? _croopedImage = await _imageCropper.cropImage(
        sourcePath: image.path,
        androidUiSettings: const AndroidUiSettings(
          initAspectRatio: CropAspectRatioPreset.ratio4x3,
          cropFrameColor: Colors.black,
          lockAspectRatio: true,
          activeControlsWidgetColor: Colors.black,
          hideBottomControls: true,
          backgroundColor: Colors.black,
          showCropGrid: false,
          statusBarColor: Colors.black,
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
        ),
      );
      if (_croopedImage != null) {
        return _croopedImage;
      }
    }
    return null;
  }
}
