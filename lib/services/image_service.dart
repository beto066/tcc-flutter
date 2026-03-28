import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ImageService {
  static final ImageService _instance = ImageService._internal();

  ImageService._internal();

  factory ImageService() {
    return _instance;
  }

  Future<File> saveImage(File image, String path) async {
    final directory = await getApplicationDocumentsDirectory();

    final newImage = await image.copy(path);

    return newImage;
  }
}