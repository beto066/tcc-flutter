import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/widgets/molecules/card_list_item.dart';
import 'package:tccflutter/widgets/molecules/preference_row.dart';

class PatientTrainingDefaults extends StatelessWidget {
  const PatientTrainingDefaults({
    required this.program,
    required this.difficulty,
    required this.isLoading,
    required this.error,
    required this.onProgramChanged,
    required this.onDifficultyChanged,
    required this.onRetry,
    super.key,
  });

  final Program? program;
  final DifficultyLevel? difficulty;
  final bool isLoading;
  final String? error;
  final ValueChanged<Program> onProgramChanged;
  final ValueChanged<DifficultyLevel> onDifficultyChanged;
  final VoidCallback onRetry;

  String _programLabel(Program value, AppLocalizations localization) =>
      switch (value) {
        Program.matching => localization.training_program_matching,
        Program.receptive => localization.training_program_receptive,
        Program.expressive => localization.training_program_expressive,
      };

  String _difficultyLabel(
    DifficultyLevel value,
    AppLocalizations localization,
  ) =>
      switch (value) {
        DifficultyLevel.massTraining => localization.training_difficulty_mass,
        DifficultyLevel.distractPhase =>
          localization.training_difficulty_distraction,
        DifficultyLevel.extendedTraining =>
          localization.training_difficulty_extended,
        DifficultyLevel.randomRotation =>
          localization.training_difficulty_random,
      };

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final contextHeight = MediaQuery.sizeOf(context).height;
    final rowHeight = (contextHeight * 0.06).clamp(50.0, double.infinity);

    return CardListItem(
      localization.training_defaults_title,
      initialHeight: rowHeight,
      finalHeight: rowHeight + 125,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;

    if (isLoading) {
      return const SizedBox(
        height: 48,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (error != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(child: Text(error!)),
            IconButton(
              tooltip: localization.try_again,
              onPressed: onRetry,
              icon: Icon(Icons.refresh, color: theme.colorScheme.primary),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PreferenceRow(
            label: localization.training_default,
            child: DropdownButton<Program>(
              key: ValueKey(program),
              value: program,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              items: Program.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        _programLabel(value, localization),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: program == null
                  ? null
                  : (value) {
                      if (value != null) onProgramChanged(value);
                    },
            ),
          ),
          PreferenceRow(
            label: localization.training_difficulty_default,
            child: DropdownButton<DifficultyLevel>(
              key: ValueKey(difficulty),
              value: difficulty,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              items: DifficultyLevel.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        _difficultyLabel(value, localization),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: difficulty == null
                  ? null
                  : (value) {
                      if (value != null) onDifficultyChanged(value);
                    },
            ),
          ),
        ],
      ),
    );
  }
}
