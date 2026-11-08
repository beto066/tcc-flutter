import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/widgets/molecules/survey_option_tile.dart';

class SurveyDialog extends StatefulWidget {
  final Patient patient;
  final bool rootNavigator;

  const SurveyDialog(
      {super.key, required this.patient, this.rootNavigator = false});

  static Future<void> showSurveyDialog(BuildContext context, Patient patient,
      {bool rootNavigator = false}) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SurveyDialog(patient: patient, rootNavigator: rootNavigator);
      },
    );
  }

  @override
  State<SurveyDialog> createState() => _SurveyDialogState();
}

class _SurveyDialogState extends State<SurveyDialog> {
  static redirectTo(
      BuildContext context, String page, Patient patient, bool rootNavigator) {
    Navigator.of(context, rootNavigator: rootNavigator).pop(page);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    final screenSize = MediaQuery.sizeOf(context);
    final isLandscape = screenSize.width > screenSize.height;
    final maxContentHeight = screenSize.height * (isLandscape ? 0.55 : 0.7);

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      backgroundColor: theme.colorScheme.surface,
      elevation: 12,
      titlePadding: EdgeInsets.fromLTRB(24, isLandscape ? 12 : 22, 16, 0),
      contentPadding: EdgeInsets.fromLTRB(
        24,
        isLandscape ? 8 : 12,
        24,
        isLandscape ? 16 : 24,
      ),
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localization.survey_dialog_title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  localization.survey_dialog_description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: localization.close,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
      content: SizedBox(
        width: isLandscape ? (screenSize.width - 96).clamp(240.0, 720.0) : 380,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxContentHeight),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SurveyOptionTile(
                  icon: Icons.fact_check_outlined,
                  title: localization.survey_tests,
                  subtitle: localization.survey_tests_description,
                  color: theme.colorScheme.primary,
                  onTap: () => redirectTo(
                    context,
                    'NoteTraining',
                    widget.patient,
                    widget.rootNavigator,
                  ),
                ),
                const SizedBox(height: 10),
                SurveyOptionTile(
                  icon: Icons.edit_note_rounded,
                  title: localization.survey_notes,
                  subtitle: localization.survey_notes_description,
                  color: theme.colorScheme.tertiary,
                  onTap: () => redirectTo(
                    context,
                    'NotePad',
                    widget.patient,
                    widget.rootNavigator,
                  ),
                ),
                const SizedBox(height: 10),
                SurveyOptionTile(
                  icon: Icons.table_chart_outlined,
                  title: localization.survey_table,
                  subtitle: localization.survey_table_description,
                  color: theme.colorScheme.secondary,
                  onTap: () => redirectTo(
                    context,
                    'NoteTable',
                    widget.patient,
                    widget.rootNavigator,
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
