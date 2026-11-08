import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:tccflutter/models/app_image.dart';
import 'package:tccflutter/services/image_storage.dart';

ImageStorage createImageStorage() => _IoImageStorage();

class _IoImageStorage implements ImageStorage {
  Future<String> get _rootPath async =>
      (await getApplicationDocumentsDirectory()).path;

  @override
  Future<AppImage> save(Uint8List bytes, String relativePath) async {
    final file = File(p.join(await _rootPath, relativePath));
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes, flush: true);
    return AppImage(
      bytes: bytes,
      id: file.path,
      relativePath: relativePath,
      storageKey: file.path,
    );
  }

  @override
  Future<AppImage?> get(String relativePath) async {
    final file = File(p.join(await _rootPath, relativePath));
    if (!await file.exists()) return null;
    return AppImage(
      bytes: await file.readAsBytes(),
      id: file.path,
      relativePath: relativePath,
      storageKey: file.path,
    );
  }

  @override
  Future<List<AppImage>> getAll(String relativeDirectory) async {
    final directory = Directory(p.join(await _rootPath, relativeDirectory));
    if (!await directory.exists()) return [];
    final files = await directory
        .list()
        .where((entry) => entry is File)
        .cast<File>()
        .toList();
    final images = <AppImage>[];
    for (final file in files) {
      images.add(
        AppImage(
          bytes: await file.readAsBytes(),
          id: file.path,
          relativePath: p.join(relativeDirectory, p.basename(file.path)),
          storageKey: file.path,
        ),
      );
    }
    return images;
  }

  @override
  Future<void> delete(AppImage image) async {
    final storageKey = image.storageKey;
    if (storageKey == null) return;
    final file = File(storageKey);
    if (await file.exists()) await file.delete();
  }

  @override
  Future<void> deleteDirectory(String relativeDirectory) async {
    final directory = Directory(p.join(await _rootPath, relativeDirectory));
    if (await directory.exists()) await directory.delete(recursive: true);
  }
}
