import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/app_image.dart';
import 'package:tccflutter/models/card_training.dart';
import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/widgets/molecules/training_target_image.dart';

class TrainingPromptPanel extends StatelessWidget {
  const TrainingPromptPanel({
    required this.program,
    required this.level,
    required this.target,
    required this.targetImage,
    required this.labels,
    required this.selectedTargetLabel,
    required this.usesNeutralDistractions,
    required this.canUseVisualDistractions,
    required this.feedback,
    required this.feedbackIsPositive,
    required this.usedTip,
    required this.answering,
    required this.saving,
    required this.onTargetLabelChanged,
    required this.onNeutralDistractionsChanged,
    required this.onGiveTip,
    super.key,
  });

  final Program program;
  final DifficultyLevel level;
  final CardTraining? target;
  final AppImage? targetImage;
  final List<String> labels;
  final String? selectedTargetLabel;
  final bool usesNeutralDistractions;
  final bool canUseVisualDistractions;
  final String? feedback;
  final bool feedbackIsPositive;
  final bool usedTip;
  final bool answering;
  final bool saving;
  final ValueChanged<String> onTargetLabelChanged;
  final ValueChanged<bool> onNeutralDistractionsChanged;
  final VoidCallback onGiveTip;

  bool get _shouldChooseTargetLabel =>
      level == DifficultyLevel.distractPhase ||
      level == DifficultyLevel.extendedTraining;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    final prompt = switch (program) {
      Program.matching => localization.training_find_matching_image,
      Program.receptive =>
        localization.training_tap_target(target?.label ?? ''),
      Program.expressive => localization.training_expressive_prompt,
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            prompt,
            textAlign: TextAlign.center,
            style: program == Program.receptive
                ? theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  )
                : theme.textTheme.titleMedium,
          ),
          if (_shouldChooseTargetLabel) ...[
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey(selectedTargetLabel),
              initialValue: selectedTargetLabel,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: localization.training_target_stimulus,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              items: labels
                  .map(
                    (label) => DropdownMenuItem(
                      value: label,
                      child: Text(label, overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(),
              onChanged: answering || saving
                  ? null
                  : (label) {
                      if (label != null) onTargetLabelChanged(label);
                    },
            ),
          ],
          if (program != Program.receptive) ...[
            const SizedBox(height: 8),
            TrainingTargetImage(target: target, image: targetImage),
          ],
          if (level == DifficultyLevel.distractPhase) ...[
            const SizedBox(height: 12),
            Text(
              localization.training_distraction_phase,
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            SegmentedButton<bool>(
              segments: [
                ButtonSegment(
                  value: true,
                  icon: const Icon(Icons.circle_outlined),
                  label: Text(localization.training_neutral_distractions),
                ),
                ButtonSegment(
                  value: false,
                  icon: const Icon(Icons.image_outlined),
                  label: Text(localization.training_cards),
                  enabled: canUseVisualDistractions,
                ),
              ],
              selected: {usesNeutralDistractions},
              onSelectionChanged: answering || saving
                  ? null
                  : (selection) =>
                      onNeutralDistractionsChanged(selection.first),
            ),
          ],
          if (feedback != null) ...[
            const SizedBox(height: 12),
            Text(
              feedback!,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: feedbackIsPositive
                    ? Colors.green.shade700
                    : theme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          if (!usedTip &&
              program != Program.expressive &&
              level != DifficultyLevel.randomRotation) ...[
            const SizedBox(height: 4),
            TextButton.icon(
              onPressed: answering || saving ? null : onGiveTip,
              icon: const Icon(Icons.lightbulb_outline),
              label: Text(localization.training_action_tip),
            ),
          ],
        ],
      ),
    );
  }
}
