// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get create => 'Create';

  @override
  String get aba => 'ABA (ABA-based application)';

  @override
  String get average => 'Average';

  @override
  String get config => 'Config.';

  @override
  String get home => 'Home';

  @override
  String get patient_details => 'Patient details';

  @override
  String get note_table_screen => 'New annotation in table';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirm_password => 'Confirm password';

  @override
  String get birth => 'Birth';

  @override
  String get name => 'Name';

  @override
  String get patient => 'Patient';

  @override
  String get patients => 'Patients';

  @override
  String get new_patient => 'New Patient';

  @override
  String get family => 'Familia';

  @override
  String get therapist => 'Terapeuta';

  @override
  String get role => 'Role';

  @override
  String invalid_date_format(Object format) {
    return 'Invalid date format $format';
  }

  @override
  String get invalid_date => 'Invalid date';

  @override
  String date_min_value(Object min_value) {
    return 'The date should be after $min_value';
  }

  @override
  String get date_is_past => 'The date cannot be in the future.';

  @override
  String get birth_required => 'Birthday is required';

  @override
  String get unexpected_error => 'An unexpected error occurred.';

  @override
  String get auth_invalid_credentials => 'Incorrect email or password.';

  @override
  String get auth_email_required => 'Please enter your email.';

  @override
  String get auth_invalid_email => 'Please enter a valid email.';

  @override
  String get auth_password_required => 'Please enter your password.';

  @override
  String auth_password_min_length(Object length) {
    return 'Password must be at least $length characters.';
  }

  @override
  String get auth_password_mismatch => 'Password confirmation does not match.';

  @override
  String get auth_name_required => 'Please enter your name.';

  @override
  String auth_name_min_length(Object length) {
    return 'Name must be at least $length characters.';
  }

  @override
  String auth_name_max_length(Object length) {
    return 'The name must be less than $length characters.';
  }

  @override
  String get weekly_notes => 'Notes this week';

  @override
  String get notes_quantity => 'Number of notes';

  @override
  String get patients_screen_description => 'Select a patient to view or add notes.';

  @override
  String get patients_treatment_started_at => 'Treatment started at:';

  @override
  String get patients_fetch_error => 'An error occurred while fetching patients. Please try again later.';
}
