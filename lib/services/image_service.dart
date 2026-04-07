import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ImageService {
  static final ImageService _instance = ImageService._internal();

  ImageService._internal();

  factory ImageService() {
    return _instance;
  }

    Future<File> saveImage(File image, String filePath, String imageName) async {
    final directory = await getApplicationDocumentsDirectory();

    var completeFilePath = '${directory.path}$filePath';
    var completePath = '$completeFilePath$imageName.png';

    final dir = Directory(completeFilePath);

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final destination = File(completePath);

    final newImage = await image.copy(completePath);

    return newImage;
  }

  Future<File?> getImage(String filePath, String imageName) async {
    final directory = await getApplicationDocumentsDirectory();

    var completeFilePath = '${directory.path}$filePath';
    var completePath = '$completeFilePath$imageName.png';

    var file = File(completePath);

    if (await file.exists()) {
      return file;
    }

    return null;
  }
}