import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tccflutter/widgets/atoms/smart_image.dart';

class PersonImage extends StatelessWidget {
  final String? imageUrl;
  final File? selectedImage;
  final Border? border;
  final Widget? positionedChild;
  final VoidCallback? onTapImage;
  final double size;

  const PersonImage({
    super.key,
    this.imageUrl,
    this.selectedImage,
    this.border,
    this.positionedChild,
    this.onTapImage,
    this.size = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: onTapImage,
            child: ClipOval(
              child: Container(
                width: size + 1,
                height: size + 1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: border ?? Border.all(width: 1),
                  color: Colors.white,
                ),
                child: SmartImage(
                  file: selectedImage,
                  imageUrl: imageUrl,
                  width: size,
                  height: size,
                ),
              ),
            ),
          ),

          if (positionedChild != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: positionedChild!
            ),
        ],
      ),
    );
  }
}