import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/app_image.dart';
import 'package:tccflutter/models/card_training.dart';
import 'package:tccflutter/widgets/atoms/smart_image.dart';

class TrainingTargetImage extends StatelessWidget {
  const TrainingTargetImage({
    required this.target,
    required this.image,
    super.key,
  });

  final CardTraining? target;
  final AppImage? image;

  @override
  Widget build(BuildContext context) {
    final targetImage = image;
    if (targetImage == null) return const SizedBox.shrink();

    return Semantics(
      label: target?.label ??
          AppLocalizations.of(context)!.training_find_matching_image,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: SmartImage(
          file: targetImage,
          width: 150,
          height: 150,
          defaultIcon: Icons.image_not_supported_outlined,
        ),
      ),
    );
  }
}
