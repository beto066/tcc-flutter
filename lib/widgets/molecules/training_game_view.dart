import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/app_image.dart';
import 'package:tccflutter/models/card_training.dart';
import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/enums/training_result.dart';
import 'package:tccflutter/models/training_option.dart';
import 'package:tccflutter/widgets/atoms/score_chip.dart';
import 'package:tccflutter/widgets/molecules/training_prompt_panel.dart';
import 'package:tccflutter/widgets/molecules/training_response_panel.dart';

class TrainingGameView extends StatelessWidget {
  const TrainingGameView({
    required this.program,
    required this.level,
    required this.target,
    required this.targetImage,
    required this.options,
    required this.labels,
    required this.selectedTargetLabel,
    required this.usesNeutralDistractions,
    required this.canUseVisualDistractions,
    required this.successes,
    required this.errors,
    required this.feedback,
    required this.feedbackIsPositive,
    required this.usedTip,
    required this.hintShown,
    required this.answering,
    required this.saving,
    required this.onFinish,
    required this.onTargetLabelChanged,
    required this.onNeutralDistractionsChanged,
    required this.onAnswerChoice,
    required this.onAnswerExpressive,
    required this.onGiveTip,
    super.key,
  });

  final Program program;
  final DifficultyLevel level;
  final CardTraining? target;
  final AppImage? targetImage;
  final List<TrainingOption> options;
  final List<String> labels;
  final String? selectedTargetLabel;
  final bool usesNeutralDistractions;
  final bool canUseVisualDistractions;
  final int successes;
  final int errors;
  final String? feedback;
  final bool feedbackIsPositive;
  final bool usedTip;
  final bool hintShown;
  final bool answering;
  final bool saving;
  final VoidCallback onFinish;
  final ValueChanged<String> onTargetLabelChanged;
  final ValueChanged<bool> onNeutralDistractionsChanged;
  final ValueChanged<TrainingOption> onAnswerChoice;
  final ValueChanged<TrainingResult> onAnswerExpressive;
  final VoidCallback onGiveTip;

  String _programLabel(Program value, AppLocalizations localization) =>
      switch (value) {
        Program.matching => localization.training_program_matching,
        Program.receptive => localization.training_program_receptive,
        Program.expressive => localization.training_program_expressive,
      };

  String _levelLabel(
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
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${_programLabel(program, localization)} · '
                '${_levelLabel(level, localization)}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Wrap(
              spacing: 8,
              children: [
                ScoreChip(
                  icon: Icons.check_circle_outline,
                  label: localization.training_successes(successes),
                  color: Colors.green,
                ),
                ScoreChip(
                  icon: Icons.refresh_rounded,
                  label: localization.training_errors(errors),
                  color: theme.colorScheme.error,
                ),
              ],
            ),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: saving ? null : onFinish,
              icon: saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.stop_circle_outlined),
              label: Text(
                saving
                    ? localization.training_saving
                    : localization.training_finish,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 620) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.36,
                      child: TrainingPromptPanel(
                        program: program,
                        level: level,
                        target: target,
                        targetImage: targetImage,
                        labels: labels,
                        selectedTargetLabel: selectedTargetLabel,
                        usesNeutralDistractions: usesNeutralDistractions,
                        canUseVisualDistractions: canUseVisualDistractions,
                        feedback: feedback,
                        feedbackIsPositive: feedbackIsPositive,
                        usedTip: usedTip,
                        answering: answering,
                        saving: saving,
                        onTargetLabelChanged: onTargetLabelChanged,
                        onNeutralDistractionsChanged:
                            onNeutralDistractionsChanged,
                        onGiveTip: onGiveTip,
                      ),
                    ),
                    const VerticalDivider(width: 24),
                    Expanded(
                      child: TrainingResponsePanel(
                        program: program,
                        target: target,
                        options: options,
                        hintShown: hintShown,
                        answering: answering,
                        saving: saving,
                        onAnswerChoice: onAnswerChoice,
                        onAnswerExpressive: onAnswerExpressive,
                        landscape: true,
                      ),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  TrainingPromptPanel(
                    program: program,
                    level: level,
                    target: target,
                    targetImage: targetImage,
                    labels: labels,
                    selectedTargetLabel: selectedTargetLabel,
                    usesNeutralDistractions: usesNeutralDistractions,
                    canUseVisualDistractions: canUseVisualDistractions,
                    feedback: feedback,
                    feedbackIsPositive: feedbackIsPositive,
                    usedTip: usedTip,
                    answering: answering,
                    saving: saving,
                    onTargetLabelChanged: onTargetLabelChanged,
                    onNeutralDistractionsChanged: onNeutralDistractionsChanged,
                    onGiveTip: onGiveTip,
                  ),
                  Expanded(
                    child: TrainingResponsePanel(
                      program: program,
                      target: target,
                      options: options,
                      hintShown: hintShown,
                      answering: answering,
                      saving: saving,
                      onAnswerChoice: onAnswerChoice,
                      onAnswerExpressive: onAnswerExpressive,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
