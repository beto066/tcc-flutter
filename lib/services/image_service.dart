import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageService {
  static final ImageService _instance = ImageService._internal();

  ImageService._internal();

  factory ImageService() {
    return _instance;
  }

    Future<File> saveImage(File image, String filePath, String imageName) async {
    final directory = await getApplicationDocumentsDirectory();

    var extension = p.extension(image.path);

    var completeFilePath = '${directory.path}$filePath';
    var completePath = '$completeFilePath$imageName.$extension';

    final dir = Directory(completeFilePath);

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final destination = File(completePath);

    final newImage = await image.copy(completePath);

    return newImage;
  }
}