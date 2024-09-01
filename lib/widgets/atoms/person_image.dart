import 'package:flutter/material.dart';

class PersonImage extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const PersonImage({
    super.key,
    this.imageUrl,
    this.size = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Icon(
        Icons.person,
        size: size,
        color: Colors.grey[600],
      );
    } else if (imageUrl!.startsWith('http') || imageUrl!.startsWith('https')) {
      return Image.network(
        imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.person,
            size: size,
            color: Colors.grey[600],
          );
        },
      );
    } else {
      return Image.asset(
        imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.person,
            size: size,
            color: Colors.grey[600],
          );
        },
      );
    }
  }
}