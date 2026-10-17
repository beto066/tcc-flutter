import 'package:flutter/material.dart';
import 'package:tccflutter/models/card_training.dart';
import 'package:tccflutter/widgets/atoms/smart_image.dart';

class WrapCardTraining extends StatelessWidget {
  final CardTraining card;
  const WrapCardTraining({super.key, required this.card});

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
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SmartImage(
                width: 50,
                height: 50,
                file: image,
                defaultIcon: Icons.image_not_supported,
              ),
            );
          }).toList() ?? [],
        ),
      ],
    );
  }
}