// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get aba => 'ABA (Aplicação baseada em ABA)';

  @override
  String get average => 'Média';

  @override
  String get config => 'Config.';

  @override
  String get home => 'Início';

  @override
  String get patient_details => 'Detalhes do paciente';

  @override
  String get note_table_screen => 'Nova anotação em tabela';

  @override
  String get login => 'Login';

  @override
  String get register => 'Cadastre-se';

  @override
  String get email => 'Email';

  @override
  String get password => 'Senha';

  @override
  String get name => 'Nome';

  @override
  String get patient => 'Paciente';

  @override
  String get patients => 'Pacientes';

  @override
  String get auth_invalid_credentials => 'Email ou senha incorreto.';

  @override
  String get unexpected_error => 'Ocorreu um erro inesperado.';

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
}
