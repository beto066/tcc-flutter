import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class AppImage {
  const AppImage({
    required this.bytes,
    required this.id,
    this.relativePath,
    this.storageKey,
  });

  final Uint8List bytes;
  final String id;
  final String? relativePath;
  final String? storageKey;

  static Future<AppImage> fromXFile(XFile file) async {
    return AppImage(
      bytes: await file.readAsBytes(),
      id: file.name,
    );
  }
}
