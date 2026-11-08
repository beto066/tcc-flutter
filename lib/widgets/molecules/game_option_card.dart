import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/training_option.dart';
import 'package:tccflutter/widgets/atoms/hint_shake.dart';
import 'package:tccflutter/widgets/atoms/smart_image.dart';

class GameOptionCard extends StatelessWidget {
  const GameOptionCard({
    required this.option,
    required this.onTap,
    this.hinted = false,
    super.key,
  });

  final TrainingOption option;
  final VoidCallback? onTap;
  final bool hinted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neutralStimulusIcon = switch (option.neutralStimulus) {
      NeutralStimulus.circle => Icons.circle_outlined,
      NeutralStimulus.triangle => Icons.change_history_rounded,
      NeutralStimulus.square => Icons.square_outlined,
      NeutralStimulus.star => Icons.star_outline_rounded,
      NeutralStimulus.diamond => Icons.diamond_outlined,
      NeutralStimulus.cross => Icons.add_rounded,
      null => null,
    };

    return Semantics(
      button: true,
      label: option.card?.label ??
          AppLocalizations.of(context)!.training_neutral_stimulus,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: hinted ? 8 : 3,
        color: theme.colorScheme.primaryContainer,
        child: InkWell(
          onTap: onTap,
          child: HintShake(
            hinted: hinted,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (neutralStimulusIcon != null) {
                    return Center(
                      child: Icon(
                        neutralStimulusIcon,
                        size: constraints.biggest.shortestSide * 0.6,
                        color: Colors.blueGrey.shade300,
                      ),
                    );
                  }

                  final image = option.image;
                  if (image == null) {
                    return const Center(
                      child: Icon(Icons.image_not_supported_outlined),
                    );
                  }

                  return SmartImage(
                    file: image,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    defaultIcon: Icons.image_not_supported_outlined,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
