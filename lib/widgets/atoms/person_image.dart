import 'package:flutter/material.dart';

class PersonImage extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const PersonImage({
    super.key,
    this.imageUrl,
    this.size = 50.0,
  });

  Widget _buildImage() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Icon(
        Icons.person,
        size: size,
        // color: Colors.grey[600],
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

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipBehavior: Clip.none,
      child: Container(
        height: size *0.9,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: _buildImage()
      ),
    );
  }
}