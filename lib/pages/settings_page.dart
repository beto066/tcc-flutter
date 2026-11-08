import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/stores/auth_store.dart';
import 'package:tccflutter/theme/default_theme.dart';
import 'package:tccflutter/util/event_controller.dart';
import 'package:tccflutter/util/training_preferences.dart';
import 'package:tccflutter/widgets/molecules/card_training_list.dart';
import 'package:tccflutter/widgets/molecules/preferences_panel.dart';
import 'package:tccflutter/widgets/molecules/register_card_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsPage> {
  late AppLocalizations _localization;
  bool _preferencesLoadStarted = false;
  final ValueNotifier<Locale> _localeNotifier =
      ValueNotifier(const Locale('pt', 'BR'));
  int _cardListVersion = 0;
  int? _userId;
  int _hintDelaySeconds = TrainingPreferences.defaultHintDelaySeconds;
  Program _defaultProgram = TrainingPreferences.defaultProgram;
  DifficultyLevel _defaultDifficulty = TrainingPreferences.defaultDifficulty;
  bool _preferencesLoading = true;
  String? _preferencesError;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localization = AppLocalizations.of(context)!;
    if (_preferencesLoadStarted) return;
    _preferencesLoadStarted = true;
    _loadTrainingPreferences();
  }

  Future<void> _loadTrainingPreferences() async {
    setState(() {
      _preferencesLoading = true;
      _preferencesError = null;
    });

    try {
      final user = await AuthStore().loggedUser;
      if (user?.id == null) {
        throw StateError(
          _localization.training_unexpected_user_load,
        );
      }

      final hintDelay = await TrainingPreferences.getHintDelaySeconds();
      final program = await TrainingPreferences.getDefaultProgram(user!.id!);
      final difficulty =
          await TrainingPreferences.getDefaultDifficulty(user.id!);
      if (!mounted) return;

      setState(() {
        _userId = user.id;
        _hintDelaySeconds = hintDelay;
        _defaultProgram = program;
        _defaultDifficulty = difficulty;
        _preferencesLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _preferencesError =
            _localization.training_preferences_error('$error');
        _preferencesLoading = false;
      });
    }
  }

  void _showPreferenceSaveError(Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _localization.training_preferences_save_error('$error'),
        ),
      ),
    );
  }

  Future<void> _changeHintDelay(int seconds) async {
    try {
      await TrainingPreferences.setHintDelaySeconds(seconds);
      if (mounted) setState(() => _hintDelaySeconds = seconds);
    } catch (error) {
      if (mounted) _showPreferenceSaveError(error);
    }
  }

  Future<void> _changeDefaultProgram(Program program) async {
    try {
      final userId = _userId;
      if (userId == null) {
        throw StateError(
          _localization.training_unexpected_user,
        );
      }
      await TrainingPreferences.setDefaultProgram(userId, program);
      if (mounted) setState(() => _defaultProgram = program);
    } catch (error) {
      if (mounted) _showPreferenceSaveError(error);
    }
  }

  Future<void> _changeDefaultDifficulty(DifficultyLevel level) async {
    try {
      final userId = _userId;
      if (userId == null) {
        throw StateError(
          _localization.training_unexpected_user,
        );
      }
      await TrainingPreferences.setDefaultDifficulty(userId, level);
      if (mounted) setState(() => _defaultDifficulty = level);
    } catch (error) {
      if (mounted) _showPreferenceSaveError(error);
    }
  }

  void _changeLanguage(Locale? locale) async {
    if (locale != null) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('locale_language', locale.languageCode);

      if (locale.countryCode != null) {
        await prefs.setString('locale_country', locale.countryCode!);
      }

      _localeNotifier.value = locale;
      EventController().locale.value = locale;
      if (mounted) setState(() {});
    }
  }

  Future<void> _registerCard() async {
    final registered = await showModalBottomSheet<bool>(
        context: context,
        builder: (BuildContext context) {
          return const RegisterCardDialog();
        });

    if (registered == true && mounted) {
      setState(() {
        _cardListVersion++;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _localization.configurations_screen_card_saved,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = _localization;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxHeight < 560;
        final pageMargin = isCompact ? 6.0 : 20.0;

        final preferences = PreferencesPanel(
          locale: _localeNotifier.value,
          onLanguageChanged: _changeLanguage,
          hintDelaySeconds: _hintDelaySeconds,
          defaultProgram: _defaultProgram,
          defaultDifficulty: _defaultDifficulty,
          onHintDelayChanged: _changeHintDelay,
          onDefaultProgramChanged: _changeDefaultProgram,
          onDefaultDifficultyChanged: _changeDefaultDifficulty,
          isLoading: _preferencesLoading,
          error: _preferencesError,
          onRetry: _loadTrainingPreferences,
        );

        final cardList = Card(
          color: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          child: CardTrainingList(
            key: ValueKey(_cardListVersion),
          ),
        );

        final registerButton = ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          onPressed: _registerCard,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              localization.configurations_screen_register_cards,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
        );

        return SizedBox(
          height: constraints.maxHeight,
          child: Padding(
            padding: EdgeInsets.all(pageMargin),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isCompact ? 24 : 40),
              ),
              color: Color(int.parse(DefaultTheme.cyan)),
              child: Padding(
                padding: EdgeInsets.only(bottom: isCompact ? 8 : 20),
                child: isCompact
                    ? SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            preferences,
                            Text(localization.configurations_screen_cards),
                            SizedBox(
                              height: 220,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: cardList,
                              ),
                            ),
                            registerButton,
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          preferences,
                          Text(localization.configurations_screen_cards),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: cardList,
                            ),
                          ),
                          registerButton,
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
