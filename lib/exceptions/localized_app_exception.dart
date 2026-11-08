import 'package:tccflutter/l10n/app_localizations.dart';

enum AppErrorCode {
  trainingIdentity,
  trainingUserUnavailable,
  trainingPatientUnavailable,
  imageStorageUnsupported,
  imageStoragePathMissing,
}

class LocalizedStateError extends StateError {
  LocalizedStateError(this.code) : super(code.name);

  final AppErrorCode code;
}

class LocalizedUnsupportedError extends UnsupportedError {
  LocalizedUnsupportedError(this.code) : super(code.name);

  final AppErrorCode code;
}

String localizedErrorMessage(Object error, AppLocalizations localization) {
  final code = switch (error) {
    LocalizedStateError(:final code) => code,
    LocalizedUnsupportedError(:final code) => code,
    _ => null,
  };
  if (code == null) return '$error';

  return switch (code) {
    AppErrorCode.trainingIdentity => localization.training_identity_error,
    AppErrorCode.trainingUserUnavailable =>
      localization.training_unexpected_user_load,
    AppErrorCode.trainingPatientUnavailable =>
      localization.training_patient_identity_error,
    AppErrorCode.imageStorageUnsupported =>
      localization.image_storage_unsupported,
    AppErrorCode.imageStoragePathMissing =>
      localization.image_storage_path_missing,
  };
}
