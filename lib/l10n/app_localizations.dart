import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt')
  ];

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @aba.
  ///
  /// In en, this message translates to:
  /// **'ABA (ABA-based application)'**
  String get aba;

  /// No description provided for @average.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get average;

  /// No description provided for @config.
  ///
  /// In en, this message translates to:
  /// **'Config.'**
  String get config;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @bottom_link_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get bottom_link_settings;

  /// No description provided for @bottom_link_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get bottom_link_notes;

  /// No description provided for @bottom_link_logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get bottom_link_logout;

  /// No description provided for @patient_details.
  ///
  /// In en, this message translates to:
  /// **'Patient details'**
  String get patient_details;

  /// No description provided for @note_table_screen.
  ///
  /// In en, this message translates to:
  /// **'New annotation in table'**
  String get note_table_screen;

  /// No description provided for @note_pad_screen.
  ///
  /// In en, this message translates to:
  /// **'Text Note'**
  String get note_pad_screen;

  /// No description provided for @note_training_screen.
  ///
  /// In en, this message translates to:
  /// **'New training'**
  String get note_training_screen;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm_password;

  /// No description provided for @birth.
  ///
  /// In en, this message translates to:
  /// **'Birth'**
  String get birth;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patients;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @new_patient.
  ///
  /// In en, this message translates to:
  /// **'New Patient'**
  String get new_patient;

  /// No description provided for @family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// No description provided for @therapist.
  ///
  /// In en, this message translates to:
  /// **'Therapist'**
  String get therapist;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @invalid_date_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid date format {format}'**
  String invalid_date_format(Object format);

  /// No description provided for @invalid_date.
  ///
  /// In en, this message translates to:
  /// **'Invalid date'**
  String get invalid_date;

  /// No description provided for @date_required.
  ///
  /// In en, this message translates to:
  /// **'Date is required'**
  String get date_required;

  /// No description provided for @date_min_value.
  ///
  /// In en, this message translates to:
  /// **'The date should be after {min_value}'**
  String date_min_value(Object min_value);

  /// No description provided for @date_is_past.
  ///
  /// In en, this message translates to:
  /// **'The date cannot be in the future.'**
  String get date_is_past;

  /// No description provided for @birth_required.
  ///
  /// In en, this message translates to:
  /// **'Birthday is required'**
  String get birth_required;

  /// No description provided for @unexpected_error.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get unexpected_error;

  /// No description provided for @no_data.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get no_data;

  /// No description provided for @auth_invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get auth_invalid_credentials;

  /// No description provided for @auth_email_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email.'**
  String get auth_email_required;

  /// No description provided for @auth_invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email.'**
  String get auth_invalid_email;

  /// No description provided for @auth_password_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password.'**
  String get auth_password_required;

  /// No description provided for @auth_password_min_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {length} characters.'**
  String auth_password_min_length(Object length);

  /// No description provided for @auth_password_mismatch.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation does not match.'**
  String get auth_password_mismatch;

  /// No description provided for @auth_name_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name.'**
  String get auth_name_required;

  /// No description provided for @auth_name_min_length.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least {length} characters.'**
  String auth_name_min_length(Object length);

  /// No description provided for @auth_name_max_length.
  ///
  /// In en, this message translates to:
  /// **'The name must be less than {length} characters.'**
  String auth_name_max_length(Object length);

  /// No description provided for @weekly_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes this week'**
  String get weekly_notes;

  /// No description provided for @notes_quantity.
  ///
  /// In en, this message translates to:
  /// **'Number of notes'**
  String get notes_quantity;

  /// No description provided for @patients_screen_description.
  ///
  /// In en, this message translates to:
  /// **'Select a patient to view or add notes.'**
  String get patients_screen_description;

  /// No description provided for @patients_treatment_started_at.
  ///
  /// In en, this message translates to:
  /// **'Treatment started at:'**
  String get patients_treatment_started_at;

  /// No description provided for @patients_fetch_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while fetching patients. Please try again later.'**
  String get patients_fetch_error;

  /// No description provided for @patients_no_patients.
  ///
  /// In en, this message translates to:
  /// **'No patients found. Add a patient to get started.'**
  String get patients_no_patients;

  /// No description provided for @configurations_screen_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get configurations_screen_language;

  /// No description provided for @configurations_screen_difficulty_level.
  ///
  /// In en, this message translates to:
  /// **'Difficulty level'**
  String get configurations_screen_difficulty_level;

  /// No description provided for @configurations_screen_register_cards.
  ///
  /// In en, this message translates to:
  /// **'Add training cards'**
  String get configurations_screen_register_cards;

  /// No description provided for @configurations_screen_register_send_image.
  ///
  /// In en, this message translates to:
  /// **'Upload image'**
  String get configurations_screen_register_send_image;

  /// No description provided for @configurations_screen_select_label.
  ///
  /// In en, this message translates to:
  /// **'Select or type a nickname (e.g., apple)'**
  String get configurations_screen_select_label;

  /// No description provided for @configurations_screen_register_card_label_required.
  ///
  /// In en, this message translates to:
  /// **'Label is required'**
  String get configurations_screen_register_card_label_required;

  /// No description provided for @configurations_screen_register_card.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get configurations_screen_register_card;

  /// No description provided for @configurations_screen_card_saved.
  ///
  /// In en, this message translates to:
  /// **'Card saved successfully.'**
  String get configurations_screen_card_saved;

  /// No description provided for @configurations_screen_cards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get configurations_screen_cards;

  /// No description provided for @configurations_screen_image_required.
  ///
  /// In en, this message translates to:
  /// **'Image is required.'**
  String get configurations_screen_image_required;

  /// No description provided for @training_result_success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get training_result_success;

  /// No description provided for @training_result_success_compact.
  ///
  /// In en, this message translates to:
  /// **'SUCC'**
  String get training_result_success_compact;

  /// No description provided for @training_result_success_with_tip.
  ///
  /// In en, this message translates to:
  /// **'Success with tip'**
  String get training_result_success_with_tip;

  /// No description provided for @training_result_error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get training_result_error;

  /// No description provided for @training_result_error_compact.
  ///
  /// In en, this message translates to:
  /// **'ERR'**
  String get training_result_error_compact;

  /// No description provided for @training_result_tip_short.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get training_result_tip_short;

  /// No description provided for @average_short.
  ///
  /// In en, this message translates to:
  /// **'AVG'**
  String get average_short;

  /// No description provided for @training_result_select.
  ///
  /// In en, this message translates to:
  /// **'Select a result'**
  String get training_result_select;

  /// No description provided for @training_feedback_success.
  ///
  /// In en, this message translates to:
  /// **'Well done!'**
  String get training_feedback_success;

  /// No description provided for @training_feedback_success_with_tip.
  ///
  /// In en, this message translates to:
  /// **'Well done! Answered with help.'**
  String get training_feedback_success_with_tip;

  /// No description provided for @training_feedback_error.
  ///
  /// In en, this message translates to:
  /// **'That\'s okay, let\'s try another item.'**
  String get training_feedback_error;

  /// No description provided for @training_feedback_try_again.
  ///
  /// In en, this message translates to:
  /// **'Almost! Try again.'**
  String get training_feedback_try_again;

  /// No description provided for @training_action_success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get training_action_success;

  /// No description provided for @training_action_error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get training_action_error;

  /// No description provided for @training_action_tip.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get training_action_tip;

  /// No description provided for @training_action_success_with_tip.
  ///
  /// In en, this message translates to:
  /// **'Success with tip'**
  String get training_action_success_with_tip;

  /// No description provided for @training_successes.
  ///
  /// In en, this message translates to:
  /// **'Successes {count}'**
  String training_successes(Object count);

  /// No description provided for @training_errors.
  ///
  /// In en, this message translates to:
  /// **'Errors {count}'**
  String training_errors(Object count);

  /// No description provided for @training_saving.
  ///
  /// In en, this message translates to:
  /// **'Saving'**
  String get training_saving;

  /// No description provided for @training_finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get training_finish;

  /// No description provided for @home_training_chart_title.
  ///
  /// In en, this message translates to:
  /// **'Training results'**
  String get home_training_chart_title;

  /// No description provided for @home_training_chart_description.
  ///
  /// In en, this message translates to:
  /// **'This chart includes training cases only.'**
  String get home_training_chart_description;

  /// No description provided for @error_prefix.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error_prefix;

  /// No description provided for @note_field_empty.
  ///
  /// In en, this message translates to:
  /// **'This field cannot be empty'**
  String get note_field_empty;

  /// No description provided for @note_visible.
  ///
  /// In en, this message translates to:
  /// **'Make visible'**
  String get note_visible;

  /// No description provided for @note_hidden.
  ///
  /// In en, this message translates to:
  /// **'Make invisible'**
  String get note_hidden;

  /// No description provided for @note_add_text.
  ///
  /// In en, this message translates to:
  /// **'Add text'**
  String get note_add_text;

  /// No description provided for @note_text_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Enter text'**
  String get note_text_placeholder;

  /// No description provided for @note_empty_text.
  ///
  /// In en, this message translates to:
  /// **'There is no text in this note'**
  String get note_empty_text;

  /// No description provided for @note_empty_table.
  ///
  /// In en, this message translates to:
  /// **'There are no values in this note'**
  String get note_empty_table;

  /// No description provided for @note_empty_training.
  ///
  /// In en, this message translates to:
  /// **'There are no results in this note'**
  String get note_empty_training;

  /// No description provided for @note_new_value.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get note_new_value;

  /// No description provided for @note_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get note_edit;

  /// No description provided for @note_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get note_delete;

  /// No description provided for @note_save_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get note_save_tooltip;

  /// No description provided for @note_filter_title.
  ///
  /// In en, this message translates to:
  /// **'Open search filters'**
  String get note_filter_title;

  /// No description provided for @note_filter_title_label.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get note_filter_title_label;

  /// No description provided for @note_filter_from.
  ///
  /// In en, this message translates to:
  /// **'From:'**
  String get note_filter_from;

  /// No description provided for @note_filter_to.
  ///
  /// In en, this message translates to:
  /// **'To:'**
  String get note_filter_to;

  /// No description provided for @note_filter_type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get note_filter_type;

  /// No description provided for @note_type_notepad.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note_type_notepad;

  /// No description provided for @note_type_table.
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get note_type_table;

  /// No description provided for @note_type_training.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get note_type_training;

  /// No description provided for @patient_note_count.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get patient_note_count;

  /// No description provided for @patient_age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get patient_age;

  /// No description provided for @patient_therapy_duration.
  ///
  /// In en, this message translates to:
  /// **'Years in therapy'**
  String get patient_therapy_duration;

  /// No description provided for @patient_collect_data.
  ///
  /// In en, this message translates to:
  /// **'Collect data'**
  String get patient_collect_data;

  /// No description provided for @note_filter_submit.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get note_filter_submit;

  /// No description provided for @note_untitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get note_untitled;

  /// No description provided for @navigation_history_empty.
  ///
  /// In en, this message translates to:
  /// **'No navigation history'**
  String get navigation_history_empty;

  /// No description provided for @survey_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Choose the data collection type'**
  String get survey_dialog_title;

  /// No description provided for @survey_dialog_description.
  ///
  /// In en, this message translates to:
  /// **'Select how you want to record the data.'**
  String get survey_dialog_description;

  /// No description provided for @survey_tests.
  ///
  /// In en, this message translates to:
  /// **'Tests'**
  String get survey_tests;

  /// No description provided for @survey_tests_description.
  ///
  /// In en, this message translates to:
  /// **'Track data collection results.'**
  String get survey_tests_description;

  /// No description provided for @survey_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get survey_notes;

  /// No description provided for @survey_notes_description.
  ///
  /// In en, this message translates to:
  /// **'Record free-form observations.'**
  String get survey_notes_description;

  /// No description provided for @survey_table.
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get survey_table;

  /// No description provided for @survey_table_description.
  ///
  /// In en, this message translates to:
  /// **'Organize data in a table.'**
  String get survey_table_description;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @image_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit image'**
  String get image_edit;

  /// No description provided for @image_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete image'**
  String get image_delete;

  /// No description provided for @training_program_matching.
  ///
  /// In en, this message translates to:
  /// **'Matching'**
  String get training_program_matching;

  /// No description provided for @training_program_receptive.
  ///
  /// In en, this message translates to:
  /// **'Receptive'**
  String get training_program_receptive;

  /// No description provided for @training_program_expressive.
  ///
  /// In en, this message translates to:
  /// **'Expressive'**
  String get training_program_expressive;

  /// No description provided for @training_difficulty_mass.
  ///
  /// In en, this message translates to:
  /// **'Massed training'**
  String get training_difficulty_mass;

  /// No description provided for @training_difficulty_distraction.
  ///
  /// In en, this message translates to:
  /// **'Distraction phase'**
  String get training_difficulty_distraction;

  /// No description provided for @training_difficulty_extended.
  ///
  /// In en, this message translates to:
  /// **'Extended training'**
  String get training_difficulty_extended;

  /// No description provided for @training_difficulty_random.
  ///
  /// In en, this message translates to:
  /// **'Random rotation'**
  String get training_difficulty_random;

  /// No description provided for @training_lets_start.
  ///
  /// In en, this message translates to:
  /// **'Let\'s train!'**
  String get training_lets_start;

  /// No description provided for @training_type.
  ///
  /// In en, this message translates to:
  /// **'Training type'**
  String get training_type;

  /// No description provided for @training_difficulty_level.
  ///
  /// In en, this message translates to:
  /// **'Difficulty level'**
  String get training_difficulty_level;

  /// No description provided for @training_target_stimulus.
  ///
  /// In en, this message translates to:
  /// **'Target stimulus'**
  String get training_target_stimulus;

  /// No description provided for @training_options_quantity.
  ///
  /// In en, this message translates to:
  /// **'Number of options'**
  String get training_options_quantity;

  /// No description provided for @training_option_singular.
  ///
  /// In en, this message translates to:
  /// **'option'**
  String get training_option_singular;

  /// No description provided for @training_option_plural.
  ///
  /// In en, this message translates to:
  /// **'options'**
  String get training_option_plural;

  /// No description provided for @training_random_options_description.
  ///
  /// In en, this message translates to:
  /// **'Random rotation uses all available stimuli ({count}).'**
  String training_random_options_description(Object count);

  /// No description provided for @training_register_target_images.
  ///
  /// In en, this message translates to:
  /// **'Add images to choose the target stimulus for this level.'**
  String get training_register_target_images;

  /// No description provided for @training_register_images.
  ///
  /// In en, this message translates to:
  /// **'Add images for the training stimuli.'**
  String get training_register_images;

  /// No description provided for @training_start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get training_start;

  /// No description provided for @training_mass_description.
  ///
  /// In en, this message translates to:
  /// **'Train with one option or increase the number to ensure success.'**
  String get training_mass_description;

  /// No description provided for @training_distraction_description.
  ///
  /// In en, this message translates to:
  /// **'Start with neutral stimuli, then move on to distracting cards.'**
  String get training_distraction_description;

  /// No description provided for @training_extended_description.
  ///
  /// In en, this message translates to:
  /// **'Vary target stimulus images and use previously trained stimuli as distractors.'**
  String get training_extended_description;

  /// No description provided for @training_random_description.
  ///
  /// In en, this message translates to:
  /// **'Stimuli and images are selected and shuffled at random.'**
  String get training_random_description;

  /// No description provided for @training_find_matching_image.
  ///
  /// In en, this message translates to:
  /// **'Find the matching image'**
  String get training_find_matching_image;

  /// No description provided for @training_tap_target.
  ///
  /// In en, this message translates to:
  /// **'Tap: {target}'**
  String training_tap_target(Object target);

  /// No description provided for @training_expressive_prompt.
  ///
  /// In en, this message translates to:
  /// **'What is this?'**
  String get training_expressive_prompt;

  /// No description provided for @training_distraction_phase.
  ///
  /// In en, this message translates to:
  /// **'Distractor phase'**
  String get training_distraction_phase;

  /// No description provided for @training_neutral_distractions.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get training_neutral_distractions;

  /// No description provided for @training_neutral_stimulus.
  ///
  /// In en, this message translates to:
  /// **'Neutral stimulus'**
  String get training_neutral_stimulus;

  /// No description provided for @training_cards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get training_cards;

  /// No description provided for @training_complete_title.
  ///
  /// In en, this message translates to:
  /// **'Training complete!'**
  String get training_complete_title;

  /// No description provided for @training_complete_summary.
  ///
  /// In en, this message translates to:
  /// **'Responses recorded: {total}\nSuccesses: {successes}\nIncorrect attempts: {errors}'**
  String training_complete_summary(
      Object total, Object successes, Object errors);

  /// No description provided for @training_complete_action.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get training_complete_action;

  /// No description provided for @training_no_cards.
  ///
  /// In en, this message translates to:
  /// **'Add images to at least one card to start training.'**
  String get training_no_cards;

  /// No description provided for @training_preferences_error.
  ///
  /// In en, this message translates to:
  /// **'Could not load preferences: {error}'**
  String training_preferences_error(Object error);

  /// No description provided for @training_cards_error.
  ///
  /// In en, this message translates to:
  /// **'Could not load cards: {error}'**
  String training_cards_error(Object error);

  /// No description provided for @training_history_error.
  ///
  /// In en, this message translates to:
  /// **'Could not load training history: {error}'**
  String training_history_error(Object error);

  /// No description provided for @training_history_save_error.
  ///
  /// In en, this message translates to:
  /// **'Could not save training history: {error}'**
  String training_history_save_error(Object error);

  /// No description provided for @training_visual_distraction_requires_cards.
  ///
  /// In en, this message translates to:
  /// **'Add another card to use visual distractors.'**
  String get training_visual_distraction_requires_cards;

  /// No description provided for @training_save_error.
  ///
  /// In en, this message translates to:
  /// **'Could not save training: {error}'**
  String training_save_error(Object error);

  /// No description provided for @training_preferences_save_error.
  ///
  /// In en, this message translates to:
  /// **'Could not save preference: {error}'**
  String training_preferences_save_error(Object error);

  /// No description provided for @training_defaults_load_error.
  ///
  /// In en, this message translates to:
  /// **'Could not load defaults: {error}'**
  String training_defaults_load_error(Object error);

  /// No description provided for @training_defaults_save_error.
  ///
  /// In en, this message translates to:
  /// **'Could not save default: {error}'**
  String training_defaults_save_error(Object error);

  /// No description provided for @training_unexpected_user.
  ///
  /// In en, this message translates to:
  /// **'No authenticated user is available to save the preference.'**
  String get training_unexpected_user;

  /// No description provided for @training_unexpected_user_load.
  ///
  /// In en, this message translates to:
  /// **'No authenticated user is available to load preferences.'**
  String get training_unexpected_user_load;

  /// No description provided for @training_identity_error.
  ///
  /// In en, this message translates to:
  /// **'Could not identify the patient or authenticated user.'**
  String get training_identity_error;

  /// No description provided for @training_patient_identity_error.
  ///
  /// In en, this message translates to:
  /// **'Could not identify the training patient.'**
  String get training_patient_identity_error;

  /// No description provided for @image_storage_unsupported.
  ///
  /// In en, this message translates to:
  /// **'Local image storage is not supported on this platform.'**
  String get image_storage_unsupported;

  /// No description provided for @image_storage_path_missing.
  ///
  /// In en, this message translates to:
  /// **'The image has no storage path.'**
  String get image_storage_path_missing;

  /// No description provided for @image_view_tooltip.
  ///
  /// In en, this message translates to:
  /// **'View image'**
  String get image_view_tooltip;

  /// No description provided for @image_add_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Add image'**
  String get image_add_tooltip;

  /// No description provided for @training_hint_after.
  ///
  /// In en, this message translates to:
  /// **'Hint after'**
  String get training_hint_after;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// No description provided for @training_default.
  ///
  /// In en, this message translates to:
  /// **'Default training'**
  String get training_default;

  /// No description provided for @training_difficulty_default.
  ///
  /// In en, this message translates to:
  /// **'Default difficulty'**
  String get training_difficulty_default;

  /// No description provided for @training_defaults_title.
  ///
  /// In en, this message translates to:
  /// **'Training defaults'**
  String get training_defaults_title;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get try_again;

  /// No description provided for @note_pad_enter_text.
  ///
  /// In en, this message translates to:
  /// **'Enter something'**
  String get note_pad_enter_text;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
