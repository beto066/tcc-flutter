import 'package:flutter/material.dart';
import 'package:tccflutter/models/app_image.dart';

class SmartImage extends StatelessWidget {
  final AppImage? file;
  final String? imageUrl;
  final double width;
  final double height;
  final IconData? defaultIcon;

  const SmartImage({
    super.key,
    this.file,
    this.imageUrl,
    this.defaultIcon,
    this.width = 50,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    Widget fallback = Icon(
      defaultIcon ?? Icons.person,
      size: width,
      color: Colors.grey[600],
    );

    if (file != null) {
      return Image.memory(
        file!.bytes,
        key: ValueKey(file!.id),
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
      );
    }

    if (imageUrl == null || imageUrl!.isEmpty) {
      return fallback;
    }

    if (imageUrl!.startsWith('http')) {
      return Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
      );
    }

    return Image.asset(
      imageUrl!,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}
