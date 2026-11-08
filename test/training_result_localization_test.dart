import 'package:flutter_test/flutter_test.dart';
import 'package:tccflutter/exceptions/localized_app_exception.dart';
import 'package:tccflutter/l10n/app_localizations_pt.dart';
import 'package:tccflutter/l10n/app_localizations_en.dart';
import 'package:tccflutter/models/enums/training_result.dart';
import 'package:tccflutter/models/note_table_value.dart';
import 'package:tccflutter/util/training_result_localization.dart';

void main() {
  final localization = AppLocalizationsPt();

  test('localizes training result names and compact labels', () {
    expect(
      localizedTrainingResult(TrainingResult.success, localization),
      'Sucesso',
    );
    expect(
      localizedTrainingResult(
        TrainingResult.success,
        localization,
        compact: true,
      ),
      'SUC',
    );
    expect(
      localizedTrainingResult(
        TrainingResult.successWithTip,
        localization,
        compact: true,
      ),
      'Dica',
    );
    expect(
      localizedTrainingResult(TrainingResult.error, localization),
      'Erro',
    );
  });

  test('localizes standard table values but keeps custom values', () {
    expect(
      localizedTableValueLabel(
        NoteTableValue(label: 'TIP', value: 'Success with tip'),
        localization,
      ),
      'Dica',
    );
    expect(
      localizedTableValueSummary(
        NoteTableValue(label: 'ERR', value: 'Error'),
        localization,
      ),
      'Erro',
    );
    expect(
      localizedTableValueLabel(
        NoteTableValue(label: 'CUSTOM', value: 'Custom value'),
        localization,
      ),
      'CUSTOM',
    );
  });

  test('localizes training statistic keys from the backend', () {
    expect(
      localizedTrainingStatisticLabel('Success with tip', localization),
      'Dica',
    );
    expect(
      localizedTrainingStatisticLabel('ERR', localization),
      'ERR',
    );
    expect(
      localizedTrainingStatisticLabel('Success', AppLocalizationsEn()),
      'SUCC',
    );
    expect(
      localizedTrainingStatisticLabel('custom-statistic', localization),
      'cus…',
    );
  });

  test('localizes domain errors and training messages', () {
    expect(
      localizedErrorMessage(
        LocalizedStateError(AppErrorCode.trainingIdentity),
        localization,
      ),
      localization.training_identity_error,
    );
    expect(
      localizedErrorMessage(
        LocalizedUnsupportedError(AppErrorCode.imageStorageUnsupported),
        AppLocalizationsEn(),
      ),
      AppLocalizationsEn().image_storage_unsupported,
    );
    expect(
      localization.training_visual_distraction_requires_cards,
      'Adicione outro card para usar distratores visuais.',
    );
    expect(localization.image_view_tooltip, 'Visualizar imagem');
    expect(localization.image_add_tooltip, 'Adicionar imagem');
  });
}
