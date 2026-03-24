import 'dart:io';

import 'package:flutter/material.dart';

class SmartImage extends StatelessWidget {
  final File? file;
  final String? imageUrl;
  final double width;
  final double height;

  const SmartImage({
    super.key,
    this.file,
    this.imageUrl,
    this.width = 50,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    Widget fallback = Icon(
      Icons.person,
      size: width,
      color: Colors.grey[600],
    );

    if (file != null) {
      return Image.file(
        file!,
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