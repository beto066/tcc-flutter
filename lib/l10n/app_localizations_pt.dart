// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get create => 'Criar';

  @override
  String get aba => 'ABA (Aplicação baseada em ABA)';

  @override
  String get average => 'Média';

  @override
  String get config => 'Config.';

  @override
  String get settings => 'Configurações';

  @override
  String get home => 'Início';

  @override
  String get patient_details => 'Detalhes do paciente';

  @override
  String get note_table_screen => 'Nova anotação em tabela';

  @override
  String get note_pad_screen => 'Anotação por texto';

  @override
  String get note_training_screen => 'Novo treinamento';

  @override
  String get login => 'Login';

  @override
  String get register => 'Cadastre-se';

  @override
  String get email => 'Email';

  @override
  String get password => 'Senha';

  @override
  String get confirm_password => 'Confirmação de senha';

  @override
  String get birth => 'Nacimento';

  @override
  String get name => 'Nome';

  @override
  String get patient => 'Paciente';

  @override
  String get patients => 'Pacientes';

  @override
  String get notes => 'Anotações';

  @override
  String get new_patient => 'Novo Paciente';

  @override
  String get family => 'Família';

  @override
  String get therapist => 'Terapeuta';

  @override
  String get role => 'Função';

  @override
  String invalid_date_format(Object format) {
    return 'Formato da data errado $format';
  }

  @override
  String get invalid_date => 'Data inválida';

  @override
  String date_min_value(Object min_value) {
    return 'A data deve ser depois de $min_value';
  }

  @override
  String get date_is_past => 'A data não pode estar no futuro.';

  @override
  String get birth_required => 'Data de nacimento é obrigatório';

  @override
  String get unexpected_error => 'Ocorreu um erro inesperado.';

  @override
  String get auth_invalid_credentials => 'Email ou senha incorreto.';

  @override
  String get auth_email_required => 'Por favor, insira seu email.';

  @override
  String get auth_invalid_email => 'Por favor, insira um email válido.';

  @override
  String get auth_password_required => 'Por favor, insira sua senha.';

  @override
  String auth_password_min_length(Object length) {
    return 'A senha deve ter pelo menos $length caracteres.';
  }

  @override
  String get auth_password_mismatch => 'A confirmação de senha não corresponde à senha.';

  @override
  String get auth_name_required => 'Por favor, introduzca su nombre.';

  @override
  String auth_name_min_length(Object length) {
    return 'O nome deve ter pelo menos $length caracteres.';
  }

  @override
  String auth_name_max_length(Object length) {
    return 'O nome deve ter menos que $length caracteres.';
  }

  @override
  String get weekly_notes => 'Anotações na semana';

  @override
  String get notes_quantity => 'Quantidade de anotações';

  @override
  String get patients_screen_description => 'Selecione um paciente para visualizar ou adicionar anotações.';

  @override
  String get patients_treatment_started_at => 'O tratamento começou em:';

  @override
  String get patients_fetch_error => 'Ocorreu um erro ao buscar os pacientes. Por favor, tente novamente mais tarde.';

  @override
  String get configurations_screen_language => 'Idioma';
}
