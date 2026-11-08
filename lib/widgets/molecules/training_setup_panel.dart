import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/program.dart';

class TrainingSetupPanel extends StatelessWidget {
  const TrainingSetupPanel({
    required this.program,
    required this.level,
    required this.choiceCount,
    required this.maxChoiceCount,
    required this.labels,
    required this.selectedTargetLabel,
    required this.canStart,
    required this.onProgramChanged,
    required this.onLevelChanged,
    required this.onChoiceCountChanged,
    required this.onTargetLabelChanged,
    required this.onStart,
    super.key,
  });

  final Program program;
  final DifficultyLevel level;
  final int choiceCount;
  final int maxChoiceCount;
  final List<String> labels;
  final String? selectedTargetLabel;
  final bool canStart;
  final ValueChanged<Program> onProgramChanged;
  final ValueChanged<DifficultyLevel> onLevelChanged;
  final ValueChanged<int> onChoiceCountChanged;
  final ValueChanged<String> onTargetLabelChanged;
  final VoidCallback onStart;

  String _programLabel(Program value, AppLocalizations localization) =>
      switch (value) {
        Program.matching => localization.training_program_matching,
        Program.receptive => localization.training_program_receptive,
        Program.expressive => localization.training_program_expressive,
      };

  String _levelLabel(DifficultyLevel value, AppLocalizations localization) =>
      switch (value) {
        DifficultyLevel.massTraining => localization.training_difficulty_mass,
        DifficultyLevel.distractPhase =>
          localization.training_difficulty_distraction,
        DifficultyLevel.extendedTraining =>
          localization.training_difficulty_extended,
        DifficultyLevel.randomRotation => localization.training_difficulty_random,
      };

  bool _requiresTargetLabel(DifficultyLevel level) =>
      level == DifficultyLevel.distractPhase ||
      level == DifficultyLevel.extendedTraining;

  String _levelDescription(
    DifficultyLevel level,
    AppLocalizations localization,
  ) =>
      switch (level) {
        DifficultyLevel.massTraining => localization.training_mass_description,
        DifficultyLevel.distractPhase =>
          localization.training_distraction_description,
        DifficultyLevel.extendedTraining =>
          localization.training_extended_description,
        DifficultyLevel.randomRotation => localization.training_random_description,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    final choiceValues = List.generate(maxChoiceCount, (index) => index + 1);
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isLandscape ? 760 : 560),
        child: Card(
          elevation: 2,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isLandscape ? 16 : 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.sports_esports_outlined,
                  size: 54,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  localization.training_lets_start,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _levelDescription(level, localization),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<Program>(
                  initialValue: program,
                  decoration: InputDecoration(
                    labelText: localization.training_type,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.category_outlined),
                  ),
                  items: Program.values.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(_programLabel(value, localization)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) onProgramChanged(value);
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<DifficultyLevel>(
                  initialValue: level,
                  decoration: InputDecoration(
                    labelText: localization.training_difficulty_level,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.tune),
                  ),
                  items: DifficultyLevel.values.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(_levelLabel(value, localization)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) onLevelChanged(value);
                  },
                ),
                if (_requiresTargetLabel(level)) ...[
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    key: ValueKey('${level.name}:$selectedTargetLabel'),
                    initialValue: selectedTargetLabel,
                    decoration: InputDecoration(
                      labelText: localization.training_target_stimulus,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.label_outline),
                    ),
                    items: labels.map((label) {
                      return DropdownMenuItem(
                        value: label,
                        child: Text(label),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) onTargetLabelChanged(value);
                    },
                  ),
                ],
                if (level != DifficultyLevel.randomRotation &&
                    program != Program.expressive) ...[
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    key: ValueKey('${level.name}:$choiceCount'),
                    initialValue: choiceCount,
                    decoration: InputDecoration(
                      labelText: localization.training_options_quantity,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.grid_view),
                    ),
                    items: choiceValues.map((count) {
                      return DropdownMenuItem(
                        value: count,
                        child: Text(
                          '$count ${count == 1 ? localization.training_option_singular : localization.training_option_plural}',
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) onChoiceCountChanged(value);
                    },
                  ),
                ],
                if (level == DifficultyLevel.randomRotation &&
                    program != Program.expressive)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      localization.training_random_options_description(
                        maxChoiceCount,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (!canStart)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      level == DifficultyLevel.extendedTraining
                          ? localization.training_register_target_images
                          : localization.training_register_images,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: canStart ? onStart : null,
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(localization.training_start),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
