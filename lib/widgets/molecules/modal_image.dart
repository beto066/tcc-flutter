import 'dart:io';

import 'package:flutter/material.dart';

class ModalImage extends StatefulWidget {
  final File image;
  final Future<File?> Function()? onEdit;
  final Future<void> Function()? onDelete;

  const ModalImage({
    super.key,
    required this.image,
    this.onEdit,
    this.onDelete,
  });

  static Future<void> show(
    BuildContext context, {
    required File image,
    Future<File?> Function()? onEdit,
    Future<void> Function()? onDelete,
  }) {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return ModalImage(
          image: image,
          onEdit: onEdit,
          onDelete: onDelete,
        );
      },
    );
  }

  @override
  State<ModalImage> createState() => _ModalImageState();
}

class _ModalImageState extends State<ModalImage> {
  late File _currentImage;

  @override
  void initState() {
    super.initState();
    _currentImage = widget.image;
  }

  Key _getImageKey(File file) {
    try {
      if (file.existsSync()) {
        return ValueKey('${file.path}_${file.lastModifiedSync().microsecondsSinceEpoch}');
      }
    } catch (_) {}
    return ValueKey(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.onEdit != null)
                Container(
                  margin: const EdgeInsets.only(right: 4),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit_rounded, color: Colors.white, size: 20),
                    tooltip: 'Editar imagem',
                    onPressed: () async {
                      final newFile = await widget.onEdit!();
                      if (newFile != null && mounted) {
                        setState(() {
                          _currentImage = newFile;
                        });
                      }
                    },
                  ),
                ),
              if (widget.onDelete != null)
                Container(
                  margin: const EdgeInsets.only(right: 4),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.delete_rounded, color: Colors.redAccent, size: 20),
                    tooltip: 'Apagar imagem',
                    onPressed: () async {
                      Navigator.pop(context);
                      await widget.onDelete!();
                    },
                  ),
                ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white, size: 20),
                  tooltip: 'Fechar',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          InteractiveViewer(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                _currentImage,
                key: _getImageKey(_currentImage),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
