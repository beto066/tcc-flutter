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
  String get settings => 'Ajustes';

  @override
  String get home => 'Inicio';

  @override
  String get bottom_link_settings => 'Ajustes';

  @override
  String get bottom_link_notes => 'Notas';

  @override
  String get bottom_link_logout => 'Salir';

  @override
  String get patient_details => 'Datos del paciente';

  @override
  String get note_table_screen => 'Nueva anotación en la tabla';

  @override
  String get note_pad_screen => 'Anotación de texto';

  @override
  String get note_training_screen => 'Nueva formación';

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
  String get patients => 'Pacientes';

  @override
  String get notes => 'Notas';

  @override
  String get new_patient => 'Nuevo Paciente';

  @override
  String get family => 'Familia';

  @override
  String get therapist => 'Terapeuta';

  @override
  String get role => 'Rol';

  @override
  String get save => 'Guardar';

  @override
  String invalid_date_format(Object format) {
    return 'Formato de fecha incorrecto $format';
  }

  @override
  String get invalid_date => 'Fecha no válida';

  @override
  String get date_required => 'La fecha es obligatoria';

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
  String get no_data => 'No hay datos disponibles';

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
  String get auth_password_mismatch =>
      'La confirmación de la contraseña no coincide.';

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
  String get patients_screen_description =>
      'Seleccione un paciente para verlo o agregar notas.';

  @override
  String get patients_treatment_started_at => 'El tratamiento comenzó en:';

  @override
  String get patients_fetch_error =>
      'Ocurrió un error al buscar los pacientes. Por favor, intente nuevamente más tarde.';

  @override
  String get patients_no_patients =>
      'No se encontraron pacientes. Agregue uno para comenzar.';

  @override
  String get configurations_screen_language => 'Idioma';

  @override
  String get configurations_screen_difficulty_level => 'Nivel de dificultad';

  @override
  String get configurations_screen_register_cards =>
      'Agregar tarjetas de entrenamiento';

  @override
  String get configurations_screen_register_send_image => 'Subir imagen';

  @override
  String get configurations_screen_select_label =>
      'Seleccione o escriba una etiqueta (por ejemplo, manzana).';

  @override
  String get configurations_screen_register_card_label_required =>
      'Se requiere etiqueta';

  @override
  String get configurations_screen_register_card => 'Agregar Tarjeta';

  @override
  String get configurations_screen_card_saved =>
      'Tarjeta guardada correctamente.';

  @override
  String get configurations_screen_cards => 'Tarjetas';

  @override
  String get configurations_screen_image_required =>
      'La imagen es obligatoria.';

  @override
  String get training_result_success => 'Éxito';

  @override
  String get training_result_success_compact => 'ÉXIT';

  @override
  String get training_result_success_with_tip => 'Éxito con ayuda';

  @override
  String get training_result_error => 'Error';

  @override
  String get training_result_error_compact => 'ERR';

  @override
  String get training_result_tip_short => 'Ayuda';

  @override
  String get average_short => 'PROM';

  @override
  String get training_result_select => 'Seleccione un resultado';

  @override
  String get training_feedback_success => '¡Muy bien!';

  @override
  String get training_feedback_success_with_tip =>
      '¡Muy bien! Respuesta con ayuda.';

  @override
  String get training_feedback_error =>
      'Está bien, intentemos con otro elemento.';

  @override
  String get training_feedback_try_again => '¡Casi! Inténtalo de nuevo.';

  @override
  String get training_action_success => 'Éxito';

  @override
  String get training_action_error => 'Error';

  @override
  String get training_action_tip => 'Ayuda';

  @override
  String get training_action_success_with_tip => 'Éxito con ayuda';

  @override
  String training_successes(Object count) {
    return 'Éxitos $count';
  }

  @override
  String training_errors(Object count) {
    return 'Errores $count';
  }

  @override
  String get training_saving => 'Guardando';

  @override
  String get training_finish => 'Finalizar';

  @override
  String get home_training_chart_title => 'Resultados de los entrenamientos';

  @override
  String get home_training_chart_description =>
      'Este gráfico solo incluye casos de entrenamiento.';

  @override
  String get error_prefix => 'Error';

  @override
  String get note_field_empty => 'Este campo no puede estar vacío';

  @override
  String get note_visible => 'Hacer visible';

  @override
  String get note_hidden => 'Hacer invisible';

  @override
  String get note_add_text => 'Agregar texto';

  @override
  String get note_text_placeholder => 'Escriba el texto';

  @override
  String get note_empty_text => 'No hay texto en esta anotación';

  @override
  String get note_empty_table => 'No hay valores en esta anotación';

  @override
  String get note_empty_training => 'No hay resultados en esta anotación';

  @override
  String get note_new_value => 'Nuevo';

  @override
  String get note_edit => 'Editar';

  @override
  String get note_delete => 'Eliminar';

  @override
  String get note_save_tooltip => 'Guardar';

  @override
  String get note_filter_title => 'Abrir filtros de búsqueda';

  @override
  String get note_filter_title_label => 'Título';

  @override
  String get note_filter_from => 'Desde:';

  @override
  String get note_filter_to => 'Hasta:';

  @override
  String get note_filter_type => 'Tipo';

  @override
  String get note_type_notepad => 'Anotación';

  @override
  String get note_type_table => 'Tabla';

  @override
  String get note_type_training => 'Entrenamiento';

  @override
  String get patient_note_count => 'Cant. anotaciones';

  @override
  String get patient_age => 'Edad';

  @override
  String get patient_therapy_duration => 'Años de terapia';

  @override
  String get patient_collect_data => 'Recopilar datos';

  @override
  String get note_filter_submit => 'Buscar';

  @override
  String get note_untitled => 'Sin título';

  @override
  String get navigation_history_empty => 'No hay historial de navegación';

  @override
  String get survey_dialog_title => 'Elija el tipo de recopilación';

  @override
  String get survey_dialog_description =>
      'Seleccione cómo desea registrar los datos.';

  @override
  String get survey_tests => 'Pruebas';

  @override
  String get survey_tests_description =>
      'Consulte los resultados de la recopilación.';

  @override
  String get survey_notes => 'Anotaciones';

  @override
  String get survey_notes_description =>
      'Registre observaciones en texto libre.';

  @override
  String get survey_table => 'Tabla';

  @override
  String get survey_table_description => 'Organice los datos en una tabla.';

  @override
  String get close => 'Cerrar';

  @override
  String get image_edit => 'Editar imagen';

  @override
  String get image_delete => 'Eliminar imagen';

  @override
  String get training_program_matching => 'Correspondencia';

  @override
  String get training_program_receptive => 'Receptivo';

  @override
  String get training_program_expressive => 'Expresivo';

  @override
  String get training_difficulty_mass => 'Entrenamiento masivo';

  @override
  String get training_difficulty_distraction => 'Fase de distracción';

  @override
  String get training_difficulty_extended => 'Entrenamiento extendido';

  @override
  String get training_difficulty_random => 'Rotación aleatoria';

  @override
  String get training_lets_start => '¡Vamos a entrenar!';

  @override
  String get training_type => 'Tipo de entrenamiento';

  @override
  String get training_difficulty_level => 'Nivel de dificultad';

  @override
  String get training_target_stimulus => 'Estímulo objetivo';

  @override
  String get training_options_quantity => 'Cantidad de opciones';

  @override
  String get training_option_singular => 'opción';

  @override
  String get training_option_plural => 'opciones';

  @override
  String training_random_options_description(Object count) {
    return 'La rotación aleatoria usa todos los estímulos disponibles ($count).';
  }

  @override
  String get training_register_target_images =>
      'Agregue imágenes para elegir el estímulo objetivo de este nivel.';

  @override
  String get training_register_images =>
      'Agregue imágenes para los estímulos del entrenamiento.';

  @override
  String get training_start => 'Comenzar';

  @override
  String get training_mass_description =>
      'Entrene con una opción o aumente la cantidad para garantizar el éxito.';

  @override
  String get training_distraction_description =>
      'Comience con estímulos neutros y luego avance a tarjetas distractoras.';

  @override
  String get training_extended_description =>
      'Varíe las imágenes del estímulo objetivo y use estímulos ya entrenados como distractores.';

  @override
  String get training_random_description =>
      'Los estímulos e imágenes se seleccionan y mezclan aleatoriamente.';

  @override
  String get training_find_matching_image => 'Encuentre la imagen igual';

  @override
  String training_tap_target(Object target) {
    return 'Toque: $target';
  }

  @override
  String get training_expressive_prompt => '¿Qué es esto?';

  @override
  String get training_distraction_phase => 'Fase de distractores';

  @override
  String get training_neutral_distractions => 'Neutros';

  @override
  String get training_neutral_stimulus => 'Estímulo neutro';

  @override
  String get training_cards => 'Tarjetas';

  @override
  String get training_complete_title => '¡Entrenamiento completado!';

  @override
  String training_complete_summary(
      Object total, Object successes, Object errors) {
    return 'Respuestas registradas: $total\nAciertos: $successes\nIntentos incorrectos: $errors';
  }

  @override
  String get training_complete_action => 'Finalizar';

  @override
  String get training_no_cards =>
      'Agregue imágenes a al menos una tarjeta para comenzar un entrenamiento.';

  @override
  String training_preferences_error(Object error) {
    return 'No se pudieron cargar las preferencias: $error';
  }

  @override
  String training_cards_error(Object error) {
    return 'No se pudieron cargar las tarjetas: $error';
  }

  @override
  String training_history_error(Object error) {
    return 'No se pudo cargar el historial de entrenamiento: $error';
  }

  @override
  String training_history_save_error(Object error) {
    return 'No se pudo guardar el historial del entrenamiento: $error';
  }

  @override
  String get training_visual_distraction_requires_cards =>
      'Agregue otra tarjeta para usar distractores visuales.';

  @override
  String training_save_error(Object error) {
    return 'No se pudo guardar el entrenamiento: $error';
  }

  @override
  String training_preferences_save_error(Object error) {
    return 'No se pudo guardar la preferencia: $error';
  }

  @override
  String training_defaults_load_error(Object error) {
    return 'No se pudieron cargar los valores predeterminados: $error';
  }

  @override
  String training_defaults_save_error(Object error) {
    return 'No se pudo guardar el valor predeterminado: $error';
  }

  @override
  String get training_unexpected_user =>
      'No hay un usuario autenticado para guardar la preferencia.';

  @override
  String get training_unexpected_user_load =>
      'No hay un usuario autenticado para cargar las preferencias.';

  @override
  String get training_identity_error =>
      'No se pudo identificar al paciente o al usuario autenticado.';

  @override
  String get training_patient_identity_error =>
      'No se pudo identificar al paciente del entrenamiento.';

  @override
  String get image_storage_unsupported =>
      'El almacenamiento local de imágenes no es compatible con esta plataforma.';

  @override
  String get image_storage_path_missing =>
      'La imagen no tiene una ruta de almacenamiento.';

  @override
  String get image_view_tooltip => 'Ver imagen';

  @override
  String get image_add_tooltip => 'Agregar imagen';

  @override
  String get training_hint_after => 'Ayuda después de';

  @override
  String get seconds => 'segundos';

  @override
  String get training_default => 'Entrenamiento predeterminado';

  @override
  String get training_difficulty_default => 'Dificultad predeterminada';

  @override
  String get training_defaults_title =>
      'Valores predeterminados del entrenamiento';

  @override
  String get try_again => 'Intentar de nuevo';

  @override
  String get note_pad_enter_text => 'Escriba algo';
}
