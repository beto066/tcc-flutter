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
  String get settings => 'Settings';

  @override
  String get home => 'Home';

  @override
  String get bottom_link_settings => 'Settings';

  @override
  String get bottom_link_notes => 'Notes';

  @override
  String get bottom_link_logout => 'Log out';

  @override
  String get patient_details => 'Patient details';

  @override
  String get note_table_screen => 'New annotation in table';

  @override
  String get note_pad_screen => 'Text Note';

  @override
  String get note_training_screen => 'New training';

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
  String get notes => 'Notes';

  @override
  String get new_patient => 'New Patient';

  @override
  String get family => 'Family';

  @override
  String get therapist => 'Therapist';

  @override
  String get role => 'Role';

  @override
  String get save => 'Save';

  @override
  String invalid_date_format(Object format) {
    return 'Invalid date format $format';
  }

  @override
  String get invalid_date => 'Invalid date';

  @override
  String get date_required => 'Date is required';

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
  String get no_data => 'No data available';

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
  String get patients_screen_description =>
      'Select a patient to view or add notes.';

  @override
  String get patients_treatment_started_at => 'Treatment started at:';

  @override
  String get patients_fetch_error =>
      'An error occurred while fetching patients. Please try again later.';

  @override
  String get patients_no_patients =>
      'No patients found. Add a patient to get started.';

  @override
  String get configurations_screen_language => 'Language';

  @override
  String get configurations_screen_difficulty_level => 'Difficulty level';

  @override
  String get configurations_screen_register_cards => 'Add training cards';

  @override
  String get configurations_screen_register_send_image => 'Upload image';

  @override
  String get configurations_screen_select_label =>
      'Select or type a nickname (e.g., apple)';

  @override
  String get configurations_screen_register_card_label_required =>
      'Label is required';

  @override
  String get configurations_screen_register_card => 'Add Card';

  @override
  String get configurations_screen_card_saved => 'Card saved successfully.';

  @override
  String get configurations_screen_cards => 'Cards';

  @override
  String get configurations_screen_image_required => 'Image is required.';

  @override
  String get training_result_success => 'Success';

  @override
  String get training_result_success_compact => 'SUCC';

  @override
  String get training_result_success_with_tip => 'Success with tip';

  @override
  String get training_result_error => 'Error';

  @override
  String get training_result_error_compact => 'ERR';

  @override
  String get training_result_tip_short => 'Tip';

  @override
  String get average_short => 'AVG';

  @override
  String get training_result_select => 'Select a result';

  @override
  String get training_feedback_success => 'Well done!';

  @override
  String get training_feedback_success_with_tip =>
      'Well done! Answered with help.';

  @override
  String get training_feedback_error =>
      'That\'s okay, let\'s try another item.';

  @override
  String get training_feedback_try_again => 'Almost! Try again.';

  @override
  String get training_action_success => 'Success';

  @override
  String get training_action_error => 'Error';

  @override
  String get training_action_tip => 'Tip';

  @override
  String get training_action_success_with_tip => 'Success with tip';

  @override
  String training_successes(Object count) {
    return 'Successes $count';
  }

  @override
  String training_errors(Object count) {
    return 'Errors $count';
  }

  @override
  String get training_saving => 'Saving';

  @override
  String get training_finish => 'Finish';

  @override
  String get home_training_chart_title => 'Training results';

  @override
  String get home_training_chart_description =>
      'This chart includes training cases only.';

  @override
  String get error_prefix => 'Error';

  @override
  String get note_field_empty => 'This field cannot be empty';

  @override
  String get note_visible => 'Make visible';

  @override
  String get note_hidden => 'Make invisible';

  @override
  String get note_add_text => 'Add text';

  @override
  String get note_text_placeholder => 'Enter text';

  @override
  String get note_empty_text => 'There is no text in this note';

  @override
  String get note_empty_table => 'There are no values in this note';

  @override
  String get note_empty_training => 'There are no results in this note';

  @override
  String get note_new_value => 'New';

  @override
  String get note_edit => 'Edit';

  @override
  String get note_delete => 'Delete';

  @override
  String get note_save_tooltip => 'Save';

  @override
  String get note_filter_title => 'Open search filters';

  @override
  String get note_filter_title_label => 'Title';

  @override
  String get note_filter_from => 'From:';

  @override
  String get note_filter_to => 'To:';

  @override
  String get note_filter_type => 'Type';

  @override
  String get note_type_notepad => 'Note';

  @override
  String get note_type_table => 'Table';

  @override
  String get note_type_training => 'Training';

  @override
  String get patient_note_count => 'Notes';

  @override
  String get patient_age => 'Age';

  @override
  String get patient_therapy_duration => 'Years in therapy';

  @override
  String get patient_collect_data => 'Collect data';

  @override
  String get note_filter_submit => 'Search';

  @override
  String get note_untitled => 'Untitled';

  @override
  String get navigation_history_empty => 'No navigation history';

  @override
  String get survey_dialog_title => 'Choose the data collection type';

  @override
  String get survey_dialog_description =>
      'Select how you want to record the data.';

  @override
  String get survey_tests => 'Tests';

  @override
  String get survey_tests_description => 'Track data collection results.';

  @override
  String get survey_notes => 'Notes';

  @override
  String get survey_notes_description => 'Record free-form observations.';

  @override
  String get survey_table => 'Table';

  @override
  String get survey_table_description => 'Organize data in a table.';

  @override
  String get close => 'Close';

  @override
  String get image_edit => 'Edit image';

  @override
  String get image_delete => 'Delete image';

  @override
  String get training_program_matching => 'Matching';

  @override
  String get training_program_receptive => 'Receptive';

  @override
  String get training_program_expressive => 'Expressive';

  @override
  String get training_difficulty_mass => 'Massed training';

  @override
  String get training_difficulty_distraction => 'Distraction phase';

  @override
  String get training_difficulty_extended => 'Extended training';

  @override
  String get training_difficulty_random => 'Random rotation';

  @override
  String get training_lets_start => 'Let\'s train!';

  @override
  String get training_type => 'Training type';

  @override
  String get training_difficulty_level => 'Difficulty level';

  @override
  String get training_target_stimulus => 'Target stimulus';

  @override
  String get training_options_quantity => 'Number of options';

  @override
  String get training_option_singular => 'option';

  @override
  String get training_option_plural => 'options';

  @override
  String training_random_options_description(Object count) {
    return 'Random rotation uses all available stimuli ($count).';
  }

  @override
  String get training_register_target_images =>
      'Add images to choose the target stimulus for this level.';

  @override
  String get training_register_images => 'Add images for the training stimuli.';

  @override
  String get training_start => 'Start';

  @override
  String get training_mass_description =>
      'Train with one option or increase the number to ensure success.';

  @override
  String get training_distraction_description =>
      'Start with neutral stimuli, then move on to distracting cards.';

  @override
  String get training_extended_description =>
      'Vary target stimulus images and use previously trained stimuli as distractors.';

  @override
  String get training_random_description =>
      'Stimuli and images are selected and shuffled at random.';

  @override
  String get training_find_matching_image => 'Find the matching image';

  @override
  String training_tap_target(Object target) {
    return 'Tap: $target';
  }

  @override
  String get training_expressive_prompt => 'What is this?';

  @override
  String get training_distraction_phase => 'Distractor phase';

  @override
  String get training_neutral_distractions => 'Neutral';

  @override
  String get training_neutral_stimulus => 'Neutral stimulus';

  @override
  String get training_cards => 'Cards';

  @override
  String get training_complete_title => 'Training complete!';

  @override
  String training_complete_summary(
      Object total, Object successes, Object errors) {
    return 'Responses recorded: $total\nSuccesses: $successes\nIncorrect attempts: $errors';
  }

  @override
  String get training_complete_action => 'Done';

  @override
  String get training_no_cards =>
      'Add images to at least one card to start training.';

  @override
  String training_preferences_error(Object error) {
    return 'Could not load preferences: $error';
  }

  @override
  String training_cards_error(Object error) {
    return 'Could not load cards: $error';
  }

  @override
  String training_history_error(Object error) {
    return 'Could not load training history: $error';
  }

  @override
  String training_history_save_error(Object error) {
    return 'Could not save training history: $error';
  }

  @override
  String get training_visual_distraction_requires_cards =>
      'Add another card to use visual distractors.';

  @override
  String training_save_error(Object error) {
    return 'Could not save training: $error';
  }

  @override
  String training_preferences_save_error(Object error) {
    return 'Could not save preference: $error';
  }

  @override
  String training_defaults_load_error(Object error) {
    return 'Could not load defaults: $error';
  }

  @override
  String training_defaults_save_error(Object error) {
    return 'Could not save default: $error';
  }

  @override
  String get training_unexpected_user =>
      'No authenticated user is available to save the preference.';

  @override
  String get training_unexpected_user_load =>
      'No authenticated user is available to load preferences.';

  @override
  String get training_identity_error =>
      'Could not identify the patient or authenticated user.';

  @override
  String get training_patient_identity_error =>
      'Could not identify the training patient.';

  @override
  String get image_storage_unsupported =>
      'Local image storage is not supported on this platform.';

  @override
  String get image_storage_path_missing => 'The image has no storage path.';

  @override
  String get image_view_tooltip => 'View image';

  @override
  String get image_add_tooltip => 'Add image';

  @override
  String get training_hint_after => 'Hint after';

  @override
  String get seconds => 'seconds';

  @override
  String get training_default => 'Default training';

  @override
  String get training_difficulty_default => 'Default difficulty';

  @override
  String get training_defaults_title => 'Training defaults';

  @override
  String get try_again => 'Try again';

  @override
  String get note_pad_enter_text => 'Enter something';
}
