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
    final hasImage = selectedImage != null || (imageUrl != null && imageUrl!.isNotEmpty);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          MouseRegion(
            cursor: onTapImage != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
            child: Tooltip(
              message: onTapImage != null ? (hasImage ? 'Visualizar imagem' : 'Adicionar imagem') : '',
              child: GestureDetector(
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
            ),
          ),

          if (onTapImage != null && hasImage)
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: onTapImage,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.65),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.edit,
                    size: size * 0.16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          if (positionedChild != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: positionedChild!,
            ),
        ],
      ),
    );
  }
}
