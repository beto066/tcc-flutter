import 'dart:convert';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/exceptions/localized_app_exception.dart';
import 'package:tccflutter/models/app_image.dart';
import 'package:tccflutter/services/image_storage.dart';

ImageStorage createImageStorage() => _WebImageStorage();

class _WebImageStorage implements ImageStorage {
  static const _imagePrefix = 'local_image:';
  static const _directoryPrefix = 'local_image_directory:';

  @override
  Future<AppImage> save(Uint8List bytes, String relativePath) async {
    final prefs = await SharedPreferences.getInstance();
    final directory = p.dirname(relativePath);
    final name = p.basename(relativePath);

    await prefs.setString('$_imagePrefix$relativePath', base64Encode(bytes));

    final names = prefs.getStringList('$_directoryPrefix$directory') ?? [];

    if (!names.contains(name)) {
      names.add(name);
      await prefs.setStringList('$_directoryPrefix$directory', names);
    }

    return AppImage(
      bytes: bytes,
      id: relativePath,
      relativePath: relativePath,
    );
  }

  @override
  Future<AppImage?> get(String relativePath) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString('$_imagePrefix$relativePath');

    if (encoded == null) return null;

    return AppImage(
      bytes: base64Decode(encoded),
      id: relativePath,
      relativePath: relativePath,
    );
  }

  @override
  Future<List<AppImage>> getAll(String relativeDirectory) async {
    final prefs = await SharedPreferences.getInstance();
    final names =
        prefs.getStringList('$_directoryPrefix$relativeDirectory') ?? [];

    final images = <AppImage>[];

    for (final name in names) {
      final image = await get(p.join(relativeDirectory, name));
      if (image != null) images.add(image);
    }

    return images;
  }

  @override
  Future<void> delete(AppImage image) async {
    final relativePath = image.relativePath;

    if (relativePath == null) {
      throw LocalizedStateError(AppErrorCode.imageStoragePathMissing);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_imagePrefix$relativePath');

    final directory = p.dirname(relativePath);
    final names = prefs.getStringList('$_directoryPrefix$directory') ?? [];
    names.remove(p.basename(relativePath));

    await prefs.setStringList('$_directoryPrefix$directory', names);
  }

  @override
  Future<void> deleteDirectory(String relativeDirectory) async {
    final prefs = await SharedPreferences.getInstance();
    final names =
        prefs.getStringList('$_directoryPrefix$relativeDirectory') ?? [];

    for (final name in names) {
      await prefs.remove(
        '$_imagePrefix${p.join(relativeDirectory, name)}',
      );
    }

    await prefs.remove('$_directoryPrefix$relativeDirectory');
  }
}
