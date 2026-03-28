// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get create => 'Crear';

  @override
  String get aba => 'ABA (Aplicación basada en ABA)';

  @override
  String get average => 'Promedio';

  @override
  String get config => 'Cnfg.';

  @override
  String get home => 'Inicio';

  @override
  String get patient_details => 'Datos del paciente';

  @override
  String get note_table_screen => 'Nueva anotación en la tabla';

  @override
  String get login => 'Login';

  @override
  String get register => 'Registro';

  @override
  String get email => 'Correo';

  @override
  String get password => 'Contraseña';

  @override
  String get confirm_password => 'confirmación de contraseña';

  @override
  String get birth => 'Nacimiento';

  @override
  String get name => 'Nombre';

  @override
  String get patient => 'Paciente';

  @override
  String get patients => 'Patients';

  @override
  String get new_patient => 'Nuevo Paciente';

  @override
  String get family => 'Family';

  @override
  String get therapist => 'Therapist';

  @override
  String get role => 'Rol';

  @override
  String invalid_date_format(Object format) {
    return 'Formato de fecha incorrecto $format';
  }

  @override
  String get invalid_date => 'Fecha no válida';

  @override
  String date_min_value(Object min_value) {
    return 'La fecha debe ser posterior a $min_value';
  }

  @override
  String get date_is_past => 'La fecha no puede ser futura.';

  @override
  String get birth_required => 'Se requiere fecha de nacimiento';

  @override
  String get unexpected_error => 'Ocurrió un error inesperado.';

  @override
  String get auth_invalid_credentials => 'Correo o contraseña incorrectos.';

  @override
  String get auth_email_required => 'Por favor, ingrese su correo.';

  @override
  String get auth_invalid_email => 'Por favor, ingrese un correo válido.';

  @override
  String get auth_password_required => 'Por favor, ingrese su contraseña.';

  @override
  String auth_password_min_length(Object length) {
    return 'La contraseña debe tener al menos $length caracteres.';
  }

  @override
  String get auth_password_mismatch => 'La confirmación de la contraseña no coincide.';

  @override
  String get auth_name_required => 'Por favor, introduzca su nombre.';

  @override
  String auth_name_min_length(Object length) {
    return 'El nombre debe tener al menos $length caracteres.';
  }

  @override
  String auth_name_max_length(Object length) {
    return 'El nombre debe tener menos de $length caracteres.';
  }

  @override
  String get weekly_notes => 'Anotaciones de la semana';

  @override
  String get notes_quantity => 'Cantidad de anotaciones';

  @override
  String get patients_screen_description => 'Seleccione un paciente para verlo o agregar notas.';

  @override
  String get patients_treatment_started_at => 'El tratamiento comenzó en:';
}
