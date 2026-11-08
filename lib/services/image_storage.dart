import 'dart:typed_data';

import 'package:tccflutter/models/app_image.dart';

abstract interface class ImageStorage {
  Future<AppImage> save(Uint8List bytes, String relativePath);

  Future<AppImage?> get(String relativePath);

  Future<List<AppImage>> getAll(String relativeDirectory);

  Future<void> delete(AppImage image);

  Future<void> deleteDirectory(String relativeDirectory);
}
