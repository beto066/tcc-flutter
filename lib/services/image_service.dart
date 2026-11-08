import 'package:path/path.dart' as p;
import 'package:tccflutter/exceptions/localized_app_exception.dart';
import 'package:tccflutter/models/app_image.dart';
import 'package:tccflutter/services/image_storage_stub.dart'
    if (dart.library.io) 'package:tccflutter/services/image_storage_io.dart'
    if (dart.library.html) 'package:tccflutter/services/image_storage_web.dart'
    as platform;

class ImageService {
  static final ImageService _instance = ImageService._internal();

  ImageService._internal();

  factory ImageService() => _instance;

  final _storage = platform.createImageStorage();

  Future<AppImage> saveImage(
    AppImage image,
    String filePath,
    String imageName,
  ) {
    final normalizedName = imageName.replaceAll(RegExp(r'^/+'), '');
    final relativePath = p.join(
      _normalizePath(filePath),
      '$normalizedName.png',
    );
    return _storage.save(image.bytes, relativePath);
  }

  Future<AppImage?> getImage(String filePath, String imageName) {
    final normalizedName = imageName.replaceAll(RegExp(r'^/+'), '');
    final relativePath = p.join(
      _normalizePath(filePath),
      '$normalizedName.png',
    );
    return _storage.get(relativePath);
  }

  Future<List<AppImage>> getImagesByPath(String path) =>
      _storage.getAll(_normalizePath(path));

  Future<void> deleteImage(AppImage image) => _storage.delete(image);

  Future<void> deleteDirectory(String path) =>
      _storage.deleteDirectory(_normalizePath(path));

  Future<AppImage> replaceImage(AppImage existing, AppImage replacement) {
    final relativePath = existing.relativePath;
    if (relativePath == null) {
      throw LocalizedStateError(AppErrorCode.imageStoragePathMissing);
    }
    return _storage.save(replacement.bytes, relativePath);
  }

  String _normalizePath(String path) =>
      p.normalize(path.replaceAll(RegExp(r'^/+'), ''));
}
