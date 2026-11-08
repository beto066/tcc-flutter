import 'dart:typed_data';

import 'package:tccflutter/exceptions/localized_app_exception.dart';
import 'package:tccflutter/models/app_image.dart';
import 'package:tccflutter/services/image_storage.dart';

ImageStorage createImageStorage() => _UnsupportedImageStorage();

class _UnsupportedImageStorage implements ImageStorage {
  Never _unsupported() =>
      throw LocalizedUnsupportedError(AppErrorCode.imageStorageUnsupported);

  @override
  Future<AppImage> save(Uint8List bytes, String relativePath) async =>
      _unsupported();

  @override
  Future<AppImage?> get(String relativePath) async => _unsupported();

  @override
  Future<List<AppImage>> getAll(String relativeDirectory) async =>
      _unsupported();

  @override
  Future<void> delete(AppImage image) async => _unsupported();

  @override
  Future<void> deleteDirectory(String relativeDirectory) async =>
      _unsupported();
}
