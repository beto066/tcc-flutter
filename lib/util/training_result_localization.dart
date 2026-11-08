import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/enums/training_result.dart';
import 'package:tccflutter/models/note_table_value.dart';

TrainingResult? trainingResultFromStoredValues({
  String? label,
  String? value,
}) {
  final candidates = [label, value]
      .whereType<String>()
      .map((text) => text.trim().toLowerCase())
      .toSet();

  for (final result in TrainingResult.values) {
    if (candidates.contains(result.label.toLowerCase()) ||
        candidates.contains(result.value.toLowerCase()) ||
        candidates.contains(result.name.toLowerCase())) {
      return result;
    }
  }

  if (candidates.any({
    'sucesso',
    'éxito',
  }.contains)) {
    return TrainingResult.success;
  }

  if (candidates.any({
    'sucesso com dica',
    'sucesso com ajuda',
    'éxito con ayuda',
    'dica',
    'tip',
    'ayuda',
  }.contains)) {
    return TrainingResult.successWithTip;
  }
  if (candidates.any({'erro', 'error'}.contains)) {
    return TrainingResult.error;
  }

  return null;
}

String localizedTrainingResult(
  TrainingResult result,
  AppLocalizations localization, {
  bool compact = false,
}) {
  return switch (result) {
    TrainingResult.success => compact
        ? localization.training_result_success_compact
        : localization.training_result_success,
    TrainingResult.successWithTip => compact
        ? localization.training_result_tip_short
        : localization.training_result_success_with_tip,
    TrainingResult.error => compact
        ? localization.training_result_error_compact
        : localization.training_result_error,
  };
}

String localizedTableValueLabel(
  NoteTableValue value,
  AppLocalizations localization,
) {
  final result = trainingResultFromStoredValues(
    label: value.label,
    value: value.value,
  );

  return result == null
      ? value.label ?? ''
      : localizedTrainingResult(result, localization, compact: true);
}

String localizedTableValueSummary(
  NoteTableValue value,
  AppLocalizations localization,
) {
  final result = trainingResultFromStoredValues(
    label: value.label,
    value: value.value,
  );
  return result == null
      ? value.value ?? ''
      : localizedTrainingResult(result, localization);
}

String localizedTrainingStatisticLabel(
  String label,
  AppLocalizations localization,
) {
  final normalized = label
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[\s_-]+'), '')
      .replaceAll('á', 'a')
      .replaceAll('é', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ú', 'u');

  if ({
    'suc',
    'success',
    'successes',
    'sucesso',
    'sucessos',
    'acierto',
    'aciertos',
    'exito',
    'exitos',
  }.contains(normalized)) {
    return localizedTrainingResult(
      TrainingResult.success,
      localization,
      compact: true,
    );
  }

  if ({
    'tip',
    'successwithtip',
    'successwithtips',
    'successwithhelp',
    'sucessocomdica',
    'sucessocomajuda',
    'exitoconayuda',
    'exitosconayuda',
  }.contains(normalized)) {
    return localizedTrainingResult(
      TrainingResult.successWithTip,
      localization,
      compact: true,
    );
  }

  if ({
    'err',
    'error',
    'errors',
    'erro',
    'erros',
  }.contains(normalized)) {
    return localizedTrainingResult(
      TrainingResult.error,
      localization,
      compact: true,
    );
  }

  final characters = label.runes.toList();
  if (characters.length <= 4) return label;
  return '${String.fromCharCodes(characters.take(3))}…';
}
