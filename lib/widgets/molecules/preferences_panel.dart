import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/widgets/molecules/preference_row.dart';

class PreferencesPanel extends StatelessWidget {
  const PreferencesPanel({
    required this.locale,
    required this.onLanguageChanged,
    required this.hintDelaySeconds,
    required this.defaultProgram,
    required this.defaultDifficulty,
    required this.onHintDelayChanged,
    required this.onDefaultProgramChanged,
    required this.onDefaultDifficultyChanged,
    required this.isLoading,
    required this.error,
    required this.onRetry,
    super.key,
  });

  final Locale locale;
  final ValueChanged<Locale?> onLanguageChanged;
  final int hintDelaySeconds;
  final Program defaultProgram;
  final DifficultyLevel defaultDifficulty;
  final ValueChanged<int> onHintDelayChanged;
  final ValueChanged<Program> onDefaultProgramChanged;
  final ValueChanged<DifficultyLevel> onDefaultDifficultyChanged;
  final bool isLoading;
  final String? error;
  final VoidCallback onRetry;

  String _programLabel(
    Program program,
    AppLocalizations localization,
  ) =>
      switch (program) {
        Program.matching => localization.training_program_matching,
        Program.receptive => localization.training_program_receptive,
        Program.expressive => localization.training_program_expressive,
      };

  String _difficultyLabel(
    DifficultyLevel level,
    AppLocalizations localization,
  ) =>
      switch (level) {
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization.settings,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          PreferenceRow(
            label: '${localization.configurations_screen_language}:',
            child: DropdownButton<Locale>(
              value: locale,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(
                  value: Locale('pt', 'BR'),
                  child: Text(
                    'Português',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text(
                    'English',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DropdownMenuItem(
                  value: Locale('es'),
                  child: Text(
                    'Español',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              onChanged: onLanguageChanged,
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(12),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else if (error != null)
            Row(
              children: [
                Expanded(child: Text(error!)),
                TextButton(
                  onPressed: onRetry,
                  child: Text(localization.try_again),
                ),
              ],
            )
          else ...[
            PreferenceRow(
              label: localization.training_hint_after,
              child: DropdownButton<int>(
                value: hintDelaySeconds,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                items: const [5, 10, 15, 30, 45, 60, 90, 120]
                    .map(
                      (seconds) => DropdownMenuItem(
                        value: seconds,
                        child: Text(
                          '$seconds ${localization.seconds}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (seconds) {
                  if (seconds != null) onHintDelayChanged(seconds);
                },
              ),
            ),
            PreferenceRow(
              label: localization.training_default,
              child: DropdownButton<Program>(
                value: defaultProgram,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                items: Program.values
                    .map(
                      (program) => DropdownMenuItem(
                        value: program,
                        child: Text(
                          _programLabel(program, localization),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (program) {
                  if (program != null) onDefaultProgramChanged(program);
                },
              ),
            ),
            PreferenceRow(
              label: localization.training_difficulty_default,
              child: DropdownButton<DifficultyLevel>(
                value: defaultDifficulty,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                items: DifficultyLevel.values
                    .map(
                      (level) => DropdownMenuItem(
                        value: level,
                        child: Text(
                          _difficultyLabel(level, localization),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (level) {
                  if (level != null) onDefaultDifficultyChanged(level);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
