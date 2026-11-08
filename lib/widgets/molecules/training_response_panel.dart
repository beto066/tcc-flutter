import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/card_training.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/enums/training_result.dart';
import 'package:tccflutter/models/training_option.dart';
import 'package:tccflutter/widgets/molecules/game_option_card.dart';

class TrainingResponsePanel extends StatelessWidget {
  const TrainingResponsePanel({
    required this.program,
    required this.target,
    required this.options,
    required this.hintShown,
    required this.answering,
    required this.saving,
    required this.onAnswerChoice,
    required this.onAnswerExpressive,
    this.landscape = false,
    super.key,
  });

  final Program program;
  final CardTraining? target;
  final List<TrainingOption> options;
  final bool hintShown;
  final bool answering;
  final bool saving;
  final ValueChanged<TrainingOption> onAnswerChoice;
  final ValueChanged<TrainingResult> onAnswerExpressive;
  final bool landscape;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    if (program == Program.expressive) {
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 340),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 68,
                child: FilledButton.icon(
                  onPressed: answering || saving
                      ? null
                      : () => onAnswerExpressive(TrainingResult.success),
                  icon: const Icon(Icons.check_circle_outline, size: 26),
                  label: Text(localization.training_action_success),
                  style: FilledButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 68,
                child: OutlinedButton.icon(
                  onPressed: answering || saving
                      ? null
                      : () => onAnswerExpressive(TrainingResult.error),
                  icon: const Icon(Icons.cancel_outlined, size: 26),
                  label: Text(localization.training_action_error),
                  style: OutlinedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 68,
                child: OutlinedButton.icon(
                  onPressed: answering || saving
                      ? null
                      : () => onAnswerExpressive(TrainingResult.successWithTip),
                  icon: const Icon(Icons.lightbulb_outline, size: 26),
                  label: Text(localization.training_action_tip),
                  style: OutlinedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final availableColumns = landscape
        ? (MediaQuery.of(context).size.width > 1000 ? 4 : 3)
        : (MediaQuery.of(context).size.width > 440 ? 3 : 2);

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: options.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: options.length < availableColumns
            ? options.length
            : availableColumns,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: landscape ? 1.15 : 0.95,
      ),
      itemBuilder: (context, index) {
        final option = options[index];
        return GameOptionCard(
          option: option,
          hinted: hintShown && option.label == target?.label,
          onTap: answering || saving ? null : () => onAnswerChoice(option),
        );
      },
    );
  }
}
