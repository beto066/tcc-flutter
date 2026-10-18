import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tccflutter/models/card_training.dart';
import 'package:tccflutter/stores/card_store.dart';
import 'package:tccflutter/widgets/atoms/smart_image.dart';
import 'package:tccflutter/widgets/molecules/modal_image.dart';

class WrapCardTraining extends StatelessWidget {
  final CardTraining card;
  final VoidCallback? onCardChanged;
  final VoidCallback? onCardDeleted;

  const WrapCardTraining({
    super.key,
    required this.card,
    this.onCardChanged,
    this.onCardDeleted,
  });

  void _onTapImage(BuildContext context, File image) {
    ModalImage.show(
      context,
      image: image,
      onEdit: () async {
        final picker = ImagePicker();
        final file = await picker.pickImage(source: ImageSource.gallery);

        if (file != null) {
          final updated = await CardStore().editImage(image, File(file.path));
          await FileImage(image).evict();
          await FileImage(updated).evict();
          PaintingBinding.instance.imageCache.clear();
          PaintingBinding.instance.imageCache.clearLiveImages();

          final idx = card.images?.indexOf(image) ?? -1;
          if (idx != -1) {
            card.images![idx] = updated;
          }

          onCardChanged?.call();
          return updated;
        }
        return null;
      },
      onDelete: () async {
        await CardStore().deleteImage(image, card.label);
        card.images?.remove(image);

        if (card.images == null || card.images!.isEmpty) {
          onCardDeleted?.call();
        } else {
          onCardChanged?.call();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            card.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: card.images?.map((image) {
            Key? itemKey;
            try {
              if (image.existsSync()) {
                itemKey = ValueKey('${image.path}_${image.lastModifiedSync().microsecondsSinceEpoch}');
              }
            } catch (_) {}

            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  key: itemKey,
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _onTapImage(context, image),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: SmartImage(
                        key: itemKey,
                        width: 50,
                        height: 50,
                        file: image,
                        defaultIcon: Icons.image_not_supported,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList() ?? [],
        ),
      ],
    );
  }
}
