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
  String get bottom_link_settings => 'Config.';

  @override
  String get bottom_link_notes => 'Notas';

  @override
  String get bottom_link_logout => 'Sair';

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
  String get birth => 'Nascimento';

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
  String get save => 'Salvar';

  @override
  String invalid_date_format(Object format) {
    return 'Formato da data errado $format';
  }

  @override
  String get invalid_date => 'Data inválida';

  @override
  String get date_required => 'Data é obrigatória';

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
  String get no_data => 'Sem dados disponíveis';

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
  String get auth_password_mismatch =>
      'A confirmação de senha não corresponde à senha.';

  @override
  String get auth_name_required => 'Por favor, insira seu nome.';

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
  String get patients_screen_description =>
      'Selecione um paciente para visualizar ou adicionar anotações.';

  @override
  String get patients_treatment_started_at => 'O tratamento começou em:';

  @override
  String get patients_fetch_error =>
      'Ocorreu um erro ao buscar os pacientes. Por favor, tente novamente mais tarde.';

  @override
  String get patients_no_patients =>
      'Nenhum paciente encontrado. Por favor, adicione um paciente para começar.';

  @override
  String get configurations_screen_language => 'Idioma';

  @override
  String get configurations_screen_difficulty_level => 'Dificuldade';

  @override
  String get configurations_screen_register_cards =>
      'Adicionar cards de treinamento';

  @override
  String get configurations_screen_register_send_image => 'Subir imagem';

  @override
  String get configurations_screen_select_label =>
      'Selecione ou digite um apelido (ex: maçã)';

  @override
  String get configurations_screen_register_card_label_required =>
      'Apelido é obrigatório';

  @override
  String get configurations_screen_register_card => 'Cadastrar Card';

  @override
  String get configurations_screen_card_saved => 'Card salvo com sucesso.';

  @override
  String get configurations_screen_cards => 'Cards';

  @override
  String get configurations_screen_image_required => 'Imagem é obrigatória';

  @override
  String get training_result_success => 'Sucesso';

  @override
  String get training_result_success_compact => 'SUC';

  @override
  String get training_result_success_with_tip => 'Sucesso com dica';

  @override
  String get training_result_error => 'Erro';

  @override
  String get training_result_error_compact => 'ERR';

  @override
  String get training_result_tip_short => 'Dica';

  @override
  String get average_short => 'MÉD';

  @override
  String get training_result_select => 'Selecione um resultado';

  @override
  String get training_feedback_success => 'Muito bem!';

  @override
  String get training_feedback_success_with_tip =>
      'Muito bem! Resposta com ajuda.';

  @override
  String get training_feedback_error => 'Tudo bem, vamos tentar outro item.';

  @override
  String get training_feedback_try_again => 'Quase! Tente mais uma vez.';

  @override
  String get training_action_success => 'Sucesso';

  @override
  String get training_action_error => 'Erro';

  @override
  String get training_action_tip => 'Dica';

  @override
  String get training_action_success_with_tip => 'Sucesso com dica';

  @override
  String training_successes(Object count) {
    return 'Acertos $count';
  }

  @override
  String training_errors(Object count) {
    return 'Erros $count';
  }

  @override
  String get training_saving => 'Salvando';

  @override
  String get training_finish => 'Encerrar';

  @override
  String get home_training_chart_title => 'Resultados dos treinamentos';

  @override
  String get home_training_chart_description =>
      'Este gráfico considera apenas os casos de treinamento.';

  @override
  String get error_prefix => 'Erro';

  @override
  String get note_field_empty => 'O campo não pode ficar vazio';

  @override
  String get note_visible => 'Tornar visível';

  @override
  String get note_hidden => 'Tornar invisível';

  @override
  String get note_add_text => 'Adicionar texto';

  @override
  String get note_text_placeholder => 'Digite o texto';

  @override
  String get note_empty_text => 'Nenhum texto nesta anotação';

  @override
  String get note_empty_table => 'Nenhum valor nesta anotação';

  @override
  String get note_empty_training => 'Nenhum resultado nesta anotação';

  @override
  String get note_new_value => 'Novo';

  @override
  String get note_edit => 'Editar';

  @override
  String get note_delete => 'Excluir';

  @override
  String get note_save_tooltip => 'Salvar';

  @override
  String get note_filter_title => 'Abrir filtros de pesquisa';

  @override
  String get note_filter_title_label => 'Título';

  @override
  String get note_filter_from => 'De:';

  @override
  String get note_filter_to => 'Até:';

  @override
  String get note_filter_type => 'Tipo';

  @override
  String get note_type_notepad => 'Anotação';

  @override
  String get note_type_table => 'Tabela';

  @override
  String get note_type_training => 'Treinamento';

  @override
  String get patient_note_count => 'Quant. anotações';

  @override
  String get patient_age => 'Idade';

  @override
  String get patient_therapy_duration => 'Anos de terapia';

  @override
  String get patient_collect_data => 'Levantar dados';

  @override
  String get note_filter_submit => 'Enviar';

  @override
  String get note_untitled => 'Sem título';

  @override
  String get navigation_history_empty => 'Nenhum histórico de navegação';

  @override
  String get survey_dialog_title => 'Escolha o tipo de levantamento';

  @override
  String get survey_dialog_description =>
      'Selecione como deseja registrar os dados.';

  @override
  String get survey_tests => 'Testes';

  @override
  String get survey_tests_description =>
      'Acompanhe os resultados do levantamento.';

  @override
  String get survey_notes => 'Anotações';

  @override
  String get survey_notes_description => 'Registre observações em texto livre.';

  @override
  String get survey_table => 'Tabela';

  @override
  String get survey_table_description =>
      'Organize os dados em formato de tabela.';

  @override
  String get close => 'Fechar';

  @override
  String get image_edit => 'Editar imagem';

  @override
  String get image_delete => 'Apagar imagem';

  @override
  String get training_program_matching => 'Correspondência';

  @override
  String get training_program_receptive => 'Receptivo';

  @override
  String get training_program_expressive => 'Expressivo';

  @override
  String get training_difficulty_mass => 'Treino em massa';

  @override
  String get training_difficulty_distraction => 'Fase de distração';

  @override
  String get training_difficulty_extended => 'Treino estendido';

  @override
  String get training_difficulty_random => 'Rotação aleatória';

  @override
  String get training_lets_start => 'Vamos treinar!';

  @override
  String get training_type => 'Tipo de treino';

  @override
  String get training_difficulty_level => 'Nível de dificuldade';

  @override
  String get training_target_stimulus => 'Estímulo-alvo';

  @override
  String get training_options_quantity => 'Quantidade de opções';

  @override
  String get training_option_singular => 'opção';

  @override
  String get training_option_plural => 'opções';

  @override
  String training_random_options_description(Object count) {
    return 'A rotação aleatória usa todos os estímulos disponíveis ($count).';
  }

  @override
  String get training_register_target_images =>
      'Cadastre imagens para escolher o estímulo-alvo deste nível.';

  @override
  String get training_register_images =>
      'Cadastre imagens para os estímulos do treino.';

  @override
  String get training_start => 'Começar';

  @override
  String get training_mass_description =>
      'Treine com uma opção ou aumente a quantidade para garantir o sucesso.';

  @override
  String get training_distraction_description =>
      'Comece com estímulos neutros e depois avance para cards distratores.';

  @override
  String get training_extended_description =>
      'Varie imagens do estímulo-alvo e use estímulos já treinados como distratores.';

  @override
  String get training_random_description =>
      'Estímulos e imagens são escolhidos e embaralhados aleatoriamente.';

  @override
  String get training_find_matching_image => 'Encontre a imagem igual';

  @override
  String training_tap_target(Object target) {
    return 'Toque em: $target';
  }

  @override
  String get training_expressive_prompt => 'O que é isso?';

  @override
  String get training_distraction_phase => 'Fase dos distratores';

  @override
  String get training_neutral_distractions => 'Neutros';

  @override
  String get training_neutral_stimulus => 'Estímulo neutro';

  @override
  String get training_cards => 'Cards';

  @override
  String get training_complete_title => 'Treino concluído!';

  @override
  String training_complete_summary(
      Object total, Object successes, Object errors) {
    return 'Respostas registradas: $total\nAcertos: $successes\nTentativas incorretas: $errors';
  }

  @override
  String get training_complete_action => 'Concluir';

  @override
  String get training_no_cards =>
      'Cadastre imagens em pelo menos um card para começar um treino.';

  @override
  String training_preferences_error(Object error) {
    return 'Não foi possível carregar as preferências: $error';
  }

  @override
  String training_cards_error(Object error) {
    return 'Não foi possível carregar os cards: $error';
  }

  @override
  String training_history_error(Object error) {
    return 'Não foi possível carregar o histórico de treino: $error';
  }

  @override
  String training_history_save_error(Object error) {
    return 'Não foi possível salvar o histórico do treino: $error';
  }

  @override
  String get training_visual_distraction_requires_cards =>
      'Adicione outro card para usar distratores visuais.';

  @override
  String training_save_error(Object error) {
    return 'Não foi possível salvar o treino: $error';
  }

  @override
  String training_preferences_save_error(Object error) {
    return 'Não foi possível salvar a preferência: $error';
  }

  @override
  String training_defaults_load_error(Object error) {
    return 'Não foi possível carregar os padrões: $error';
  }

  @override
  String training_defaults_save_error(Object error) {
    return 'Não foi possível salvar o padrão: $error';
  }

  @override
  String get training_unexpected_user =>
      'Não há usuário autenticado para salvar a preferência.';

  @override
  String get training_unexpected_user_load =>
      'Não há usuário autenticado para carregar as preferências.';

  @override
  String get training_identity_error =>
      'Não foi possível identificar o paciente ou usuário autenticado.';

  @override
  String get training_patient_identity_error =>
      'Não foi possível identificar o paciente do treino.';

  @override
  String get image_storage_unsupported =>
      'O armazenamento local de imagens não é suportado nesta plataforma.';

  @override
  String get image_storage_path_missing =>
      'A imagem não possui caminho de armazenamento.';

  @override
  String get image_view_tooltip => 'Visualizar imagem';

  @override
  String get image_add_tooltip => 'Adicionar imagem';

  @override
  String get training_hint_after => 'Dica após';

  @override
  String get seconds => 'segundos';

  @override
  String get training_default => 'Treino padrão';

  @override
  String get training_difficulty_default => 'Dificuldade padrão';

  @override
  String get training_defaults_title => 'Padrões de treinamento';

  @override
  String get try_again => 'Tentar novamente';

  @override
  String get note_pad_enter_text => 'Digite algo';
}
