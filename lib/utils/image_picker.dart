import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as im;

Future<File?> handleTakePhoto(BuildContext context) async {
  final pickedFile = await ImagePicker().pickImage(
    source: ImageSource.camera,
  );
  if (pickedFile != null) {
    final croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: pickedFile.path,
      maxWidth: 243 * 2,
      maxHeight: 153 * 2,
      aspectRatio: const CropAspectRatio(
        ratioX: 243,
        ratioY: 153,
      ),
    );
    if (croppedFile != null) {
      return await compressImage(File(croppedFile.path));
    }
  }
  return null;
}

Future<File?> handleChoosePhoto(BuildContext context) async {
  final pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  if (pickedFile != null) {
    final croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: pickedFile.path,
      maxWidth: 243 * 2,
      maxHeight: 153 * 2,
      aspectRatio: const CropAspectRatio(
        ratioX: 243,
        ratioY: 153,
      ),
    );
    if (croppedFile != null) {
      return await compressImage(File(croppedFile.path));
    }
  }
  return null;
}

Future<File?> compressImage(File file) async {
  final fileName = const Uuid().v4();
  final tempDir = await getTemporaryDirectory();
  final path = tempDir.path;
  final image = im.decodeImage(file.readAsBytesSync());
  if (image != null) {
    File compressedImage = await File('$path/$fileName.jpg')
        .writeAsBytes(im.encodeJpg(image, quality: 90));
    return compressedImage;
  }
  return null;
}
