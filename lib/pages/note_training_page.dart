import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tccflutter/exceptions/localized_app_exception.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/card_training.dart';
import 'package:tccflutter/models/app_image.dart';
import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/enums/training_result.dart';
import 'package:tccflutter/models/note_training.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/models/training_option.dart';
import 'package:tccflutter/stores/auth_store.dart';
import 'package:tccflutter/stores/card_store.dart';
import 'package:tccflutter/stores/note_store.dart';
import 'package:tccflutter/stores/training_history_store.dart';
import 'package:tccflutter/util/training_preferences.dart';
import 'package:tccflutter/widgets/molecules/training_game_view.dart';
import 'package:tccflutter/widgets/molecules/training_setup_panel.dart';

class NoteTrainingPage extends StatefulWidget {
  final Patient patient;

  const NoteTrainingPage({super.key, required this.patient});

  @override
  State<NoteTrainingPage> createState() => _NoteTrainingPageState();
}

class _NoteTrainingPageState extends State<NoteTrainingPage> {
  late AppLocalizations _localization;
  bool _initialLoadStarted = false;
  final _random = Random();
  final _trainingHistoryStore = TrainingHistoryStore();
  final List<CardTraining> _cards = [];
  final List<TrainingResult> _results = [];
  final Map<String, AppImage> _distractionTargetImages = {};
  Timer? _hintTimer;
  Set<String> _previouslyUsedLabels = {};

  Program _program = Program.matching;
  DifficultyLevel _level = TrainingPreferences.defaultDifficulty;
  int _hintDelaySeconds = TrainingPreferences.defaultHintDelaySeconds;
  int _choiceCount = 1;
  String? _selectedTargetLabel;
  CardTraining? _target;
  AppImage? _targetImage;
  List<TrainingOption> _options = [];
  String? _loadError;
  String? _feedback;
  bool _feedbackIsPositive = true;
  bool _loading = true;
  bool _started = false;
  bool _answering = false;
  bool _usedTip = false;
  bool _hintShown = false;
  bool _saving = false;
  bool _preferencesLoaded = false;
  bool _usesNeutralDistractions = true;
  bool _historyWriteFailed = false;
  Future<void> _historyWriteQueue = Future<void>.value();

  @override
  void initState() {
    super.initState();
    unawaited(SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localization = AppLocalizations.of(context)!;
    if (_initialLoadStarted) return;
    _initialLoadStarted = true;
    _loadCards();
    _loadTrainingPreferences();
  }

  Future<void> _loadTrainingPreferences() async {
    try {
      final user = await AuthStore().loggedUser;
      if (user?.id == null) {
        throw LocalizedStateError(AppErrorCode.trainingUserUnavailable);
      }

      final patientId = widget.patient.id;
      if (patientId == null) {
        throw LocalizedStateError(AppErrorCode.trainingPatientUnavailable);
      }

      final userId = user!.id!;
      final patientDifficulty =
          await TrainingPreferences.getPatientDefaultDifficulty(
        userId,
        patientId,
      );
      final patientProgram = await TrainingPreferences.getPatientDefaultProgram(
        userId,
        patientId,
      );
      final difficulty = patientDifficulty ??
          await TrainingPreferences.getDefaultDifficulty(userId);

      final hintDelay = await TrainingPreferences.getHintDelaySeconds();
      final program =
          patientProgram ?? await TrainingPreferences.getDefaultProgram(userId);

      if (!mounted) return;

      setState(() {
        _level = difficulty;
        _hintDelaySeconds = hintDelay;
        _program = program;
        _choiceCount = _presetChoiceCount(difficulty);
        final labels = _labelsForLevel(difficulty);
        _selectedTargetLabel = labels.isEmpty ? null : labels.first;
        _preferencesLoaded = true;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _preferencesLoaded = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _localization.training_preferences_error(
              localizedErrorMessage(error, _localization),
            ),
          ),
        ),
      );
    }
  }

  Future<void> _loadCards() async {
    setState(() {
      _loading = true;
      _loadError = null;
      _historyWriteFailed = false;
    });

    try {
      var page = 1;
      final cards = <CardTraining>[];

      while (true) {
        final result = await CardStore().paginateCards(page: page++);
        if (result.isEmpty) break;
        cards.addAll(
          result.where((card) => card.images?.isNotEmpty ?? false),
        );
      }

      Set<String> previouslyUsedLabels = {};
      String? historyLoadError;
      try {
        previouslyUsedLabels =
            await _trainingHistoryStore.getUsedLabels(widget.patient);
      } catch (error) {
        historyLoadError = _localization.training_history_error(
          localizedErrorMessage(error, _localization),
        );
      }

      if (!mounted) return;

      setState(() {
        _cards
          ..clear()
          ..addAll(cards);
        _previouslyUsedLabels = previouslyUsedLabels;
        _historyWriteFailed = historyLoadError != null;
        _choiceCount = _presetChoiceCount(_level);
        _selectedTargetLabel =
            _availableLabels.isEmpty ? null : _availableLabels.first;
        _loading = false;
      });

      if (historyLoadError != null) {
        _showMessage(historyLoadError);
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loadError = _localization.training_cards_error(
          localizedErrorMessage(error, _localization),
        );
        _loading = false;
      });
    }
  }

  void _startTraining() {
    if (!_canStart) return;
    _distractionTargetImages.clear();

    if (_level == DifficultyLevel.distractPhase &&
        _selectedTargetLabel != null) {
      final target = _cardForLabel(_selectedTargetLabel!);
      _distractionTargetImages[_selectedTargetLabel!] =
          _randomItem(target.images!);
    }

    setState(() {
      _started = true;
      _results.clear();
      _feedback = null;
      _nextRound();
    });
  }

  List<String> _labelsForLevel(DifficultyLevel level) {
    final labels = _cards.map((card) => card.label).toSet();
    if (level == DifficultyLevel.extendedTraining &&
        _previouslyUsedLabels.isNotEmpty) {
      labels.removeWhere((label) => !_previouslyUsedLabels.contains(label));
    }
    return labels.toList()..sort();
  }

  List<String> get _availableLabels => _labelsForLevel(_level);

  int _maxChoiceCountFor(DifficultyLevel level) {
    switch (level) {
      case DifficultyLevel.massTraining:
        return min(3, max(1, _labelsForLevel(level).length));
      case DifficultyLevel.randomRotation:
        return max(1, _cards.length);
      case DifficultyLevel.distractPhase:
        return min(
          3,
          max(2, _labelsForLevel(level).length),
        );
      case DifficultyLevel.extendedTraining:
        return min(3, max(1, _cards.map((card) => card.label).toSet().length));
    }
  }

  int _presetChoiceCount(DifficultyLevel level) {
    switch (level) {
      case DifficultyLevel.massTraining:
        return 1;
      case DifficultyLevel.distractPhase:
        return min(2, _maxChoiceCountFor(level));
      case DifficultyLevel.extendedTraining:
        return min(3, _maxChoiceCountFor(level));
      case DifficultyLevel.randomRotation:
        return _maxChoiceCountFor(level);
    }
  }

  bool get _canStart {
    if (_cards.isEmpty) return false;

    if (_level == DifficultyLevel.distractPhase ||
        _level == DifficultyLevel.extendedTraining) {
      return _selectedTargetLabel != null &&
          _availableLabels.contains(_selectedTargetLabel);
    }

    return true;
  }

  CardTraining _cardForLabel(String label) =>
      _cards.firstWhere((card) => card.label == label);

  void _selectTargetLabel(String label) {
    setState(() {
      _selectedTargetLabel = label;
      _nextRound();
    });
  }

  void _setNeutralDistractions(bool useNeutralStimuli) {
    if (!useNeutralStimuli &&
        !_cards.any((card) => card.label != _selectedTargetLabel)) {
      _showMessage(_localization.training_visual_distraction_requires_cards);
      return;
    }

    setState(() {
      _usesNeutralDistractions = useNeutralStimuli;
      _nextRound();
    });
  }

  void _recordDisplayedLabels() {
    if (_historyWriteFailed) return;

    final labels = <String>{
      if (_target != null) _target!.label,
      ..._options
          .where((option) => option.card != null)
          .map((option) => option.card!.label),
    };

    _historyWriteQueue = _historyWriteQueue.then((_) async {
      for (final label in labels) {
        await _trainingHistoryStore.recordUsedLabel(widget.patient, label);
        if (mounted) {
          setState(() => _previouslyUsedLabels.add(label));
        } else {
          _previouslyUsedLabels.add(label);
        }
      }
    }).catchError((Object error) {
      _historyWriteFailed = true;
      if (mounted) {
        _showMessage(
          _localization.training_history_save_error(
            localizedErrorMessage(error, _localization),
          ),
        );
      }
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _nextRound() {
    _hintTimer?.cancel();
    _hintShown = false;
    _usedTip = false;
    _answering = false;
    _feedback = null;

    final shuffledCards = List<CardTraining>.of(_cards)..shuffle(_random);
    if (_level == DifficultyLevel.distractPhase ||
        _level == DifficultyLevel.extendedTraining) {
      _target = _cardForLabel(_selectedTargetLabel!);
      _targetImage = _level == DifficultyLevel.distractPhase
          ? _distractionTargetImages.putIfAbsent(
              _selectedTargetLabel!,
              () => _randomItem(_target!.images!),
            )
          : _randomItem(_target!.images!);
    } else {
      _target = shuffledCards.first;
      _targetImage = _randomItem(_target!.images!);
    }

    if (_program == Program.expressive) {
      _options = [];
      _scheduleHint();
      _recordDisplayedLabels();
      return;
    }

    _options = switch (_level) {
      DifficultyLevel.massTraining => _massTrainingOptions(shuffledCards),
      DifficultyLevel.distractPhase => _distractionOptions(shuffledCards),
      DifficultyLevel.extendedTraining =>
        _extendedTrainingOptions(shuffledCards),
      DifficultyLevel.randomRotation => _randomRotationOptions(shuffledCards),
    };

    _options.shuffle(_random);
    _scheduleHint();
    _recordDisplayedLabels();
  }

  List<TrainingOption> _massTrainingOptions(List<CardTraining> shuffledCards) {
    final target = _target!;
    final distractorLabels = shuffledCards
        .map((card) => card.label)
        .where((label) => label != target.label)
        .toSet()
        .toList()
      ..shuffle(_random);

    final selected = <TrainingOption>[
      TrainingOption.card(card: target, image: _targetImage!),
    ];

    selected.addAll(
      distractorLabels.take(_choiceCount - 1).map((label) {
        final card = _cardForLabel(label);
        return TrainingOption.card(
          card: card,
          image: _randomItem(card.images!),
        );
      }),
    );

    return selected;
  }

  List<TrainingOption> _distractionOptions(
    List<CardTraining> shuffledCards,
  ) {
    final target = _target!;
    final selected = <TrainingOption>[
      TrainingOption.card(card: target, image: _targetImage!),
    ];

    if (_usesNeutralDistractions) {
      final neutralStimuli = List<NeutralStimulus>.of(NeutralStimulus.values)
        ..shuffle(_random);
      selected.addAll(
        neutralStimuli.take(_choiceCount - 1).map(TrainingOption.neutral),
      );
    } else {
      final distractorLabels = shuffledCards
          .map((card) => card.label)
          .where((label) => label != target.label)
          .toSet()
          .toList()
        ..shuffle(_random);

      selected.addAll(
        distractorLabels.take(_choiceCount - 1).map((label) {
          final card = _cardForLabel(label);
          return TrainingOption.card(
            card: card,
            image: _randomItem(card.images!),
          );
        }),
      );
    }

    return selected;
  }

  List<TrainingOption> _extendedTrainingOptions(
    List<CardTraining> shuffledCards,
  ) {
    final target = _target!;

    final distractorLabels = shuffledCards
        .map((card) => card.label)
        .where((label) => label != target.label)
        .toSet()
        .toList();

    final knownDistractorLabels = distractorLabels
        .where(_previouslyUsedLabels.contains)
        .toList()
      ..shuffle(_random);

    final additionalDistractorLabels = distractorLabels
        .where((label) => !_previouslyUsedLabels.contains(label))
        .toList()
      ..shuffle(_random);

    final selectedDistractorLabels = [
      ...knownDistractorLabels,
      ...additionalDistractorLabels,
    ].take(_choiceCount - 1);

    final selected = <TrainingOption>[
      TrainingOption.card(card: target, image: _targetImage!),
    ];

    selected.addAll(
      selectedDistractorLabels.map((label) {
        final card = _cardForLabel(label);
        return TrainingOption.card(
          card: card,
          image: _randomItem(card.images!),
        );
      }),
    );
    return selected;
  }

  List<TrainingOption> _randomRotationOptions(
    List<CardTraining> shuffledCards,
  ) {
    return shuffledCards
        .map(
          (card) => TrainingOption.card(
            card: card,
            image: card.label == _target!.label
                ? _targetImage!
                : _randomItem(card.images!),
          ),
        )
        .toList();
  }

  void _scheduleHint() {
    _hintTimer?.cancel();

    if (_level == DifficultyLevel.randomRotation ||
        _program == Program.expressive) {
      return;
    }

    _hintTimer = Timer(Duration(seconds: _hintDelaySeconds), () {
      if (!mounted || !_started || _saving) return;
      setState(() {
        _hintShown = true;
        _usedTip = true;
      });
    });
  }

  T _randomItem<T>(List<T> items) => items[_random.nextInt(items.length)];

  void _answerChoice(TrainingOption option) {
    if (_answering || _saving || _target == null) return;

    final isCorrect = option.card != null && option.label == _target!.label;
    final localization = AppLocalizations.of(context)!;

    setState(() {
      _answering = true;
      if (isCorrect) {
        _results.add(
          _usedTip ? TrainingResult.successWithTip : TrainingResult.success,
        );
        _feedbackIsPositive = true;
        _feedback = _usedTip
            ? localization.training_feedback_success_with_tip
            : localization.training_feedback_success;
      } else {
        _results.add(TrainingResult.error);
        _feedbackIsPositive = false;
        _feedback = localization.training_feedback_try_again;
      }
    });

    if (isCorrect) {
      _advanceAfterFeedback();
    } else {
      Future<void>.delayed(const Duration(milliseconds: 900), () {
        if (!mounted || !_started || _saving) return;
        setState(() => _answering = false);
      });
    }
  }

  void _answerExpressive(TrainingResult result) {
    if (_answering || _saving) return;

    final localization = AppLocalizations.of(context)!;
    setState(() {
      _answering = true;
      _results.add(result);
      _feedbackIsPositive = result != TrainingResult.error;
      _feedback = switch (result) {
        TrainingResult.success => localization.training_feedback_success,
        TrainingResult.successWithTip =>
          localization.training_feedback_success_with_tip,
        TrainingResult.error => localization.training_feedback_error,
      };
    });
    _advanceAfterFeedback();
  }

  void _advanceAfterFeedback() {
    Future<void>.delayed(const Duration(milliseconds: 1100), () {
      if (!mounted || !_started || _saving) return;
      setState(_nextRound);
    });
  }

  void _giveTip() {
    if (_answering || _saving || _usedTip) return;
    _hintTimer?.cancel();
    setState(() {
      _usedTip = true;
      _hintShown = true;
    });
  }

  Future<void> _finishTraining() async {
    if (_saving) return;
    _hintTimer?.cancel();
    if (_results.isEmpty) {
      _returnToPatient();
      return;
    }

    setState(() => _saving = true);
    final note = NoteTraining()
      ..patient = widget.patient
      ..program = _program
      ..level = _level
      ..type = NoteType.training
      ..createdAt = DateTime.now().toUtc()
      ..visibilityForFamily = false
      ..results = List.of(_results);

    try {
      await NoteStore().addNote(note);
      if (!mounted) return;

      setState(() {
        _started = false;
        _saving = false;
      });

      final successes =
          _results.where((result) => result != TrainingResult.error).length;

      final errors = _results.length - successes;

      final shouldReturn = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => AlertDialog(
          icon: const Icon(Icons.celebration_outlined, size: 40),
          title: Text(AppLocalizations.of(context)!.training_complete_title),
          content: Text(
            AppLocalizations.of(context)!.training_complete_summary(
              _results.length,
              successes,
              errors,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                AppLocalizations.of(context)!.training_complete_action,
              ),
            ),
          ],
        ),
      );

      if (shouldReturn == true && mounted) {
        _returnToPatient();
      }
    } catch (error) {
      if (!mounted) return;

      setState(() => _saving = false);

      final localization = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localization.training_save_error(
              localizedErrorMessage(error, localization),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  void _returnToPatient() {
    Navigator.of(context).popAndPushNamed(
      'Patient',
      arguments: {'patient': widget.patient},
    );
  }

  @override
  void dispose() {
    _hintTimer?.cancel();
    unawaited(SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
    ]));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_loading || !_preferencesLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_loadError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_outlined, size: 48),
              const SizedBox(height: 12),
              Text(_loadError!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _loadCards,
                icon: const Icon(Icons.refresh),
                label: Text(AppLocalizations.of(context)!.try_again),
              ),
            ],
          ),
        ),
      );
    }

    if (_cards.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.style_outlined,
                size: 56,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context)!.training_no_cards,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(
        MediaQuery.orientationOf(context) == Orientation.landscape ? 8 : 16,
      ),
      child: _started
          ? TrainingGameView(
              program: _program,
              level: _level,
              target: _target,
              targetImage: _targetImage,
              options: _options,
              labels: _availableLabels,
              selectedTargetLabel: _selectedTargetLabel,
              usesNeutralDistractions: _usesNeutralDistractions,
              canUseVisualDistractions:
                  _cards.any((card) => card.label != _selectedTargetLabel),
              successes: _results
                  .where((result) => result != TrainingResult.error)
                  .length,
              errors: _results
                  .where((result) => result == TrainingResult.error)
                  .length,
              feedback: _feedback,
              feedbackIsPositive: _feedbackIsPositive,
              usedTip: _usedTip,
              hintShown: _hintShown,
              answering: _answering,
              saving: _saving,
              onFinish: _finishTraining,
              onTargetLabelChanged: _selectTargetLabel,
              onNeutralDistractionsChanged: _setNeutralDistractions,
              onAnswerChoice: _answerChoice,
              onAnswerExpressive: _answerExpressive,
              onGiveTip: _giveTip,
            )
          : TrainingSetupPanel(
              program: _program,
              level: _level,
              choiceCount: _choiceCount,
              maxChoiceCount: _maxChoiceCountFor(_level),
              labels: _availableLabels,
              selectedTargetLabel: _selectedTargetLabel,
              canStart: _canStart,
              onProgramChanged: (program) {
                setState(() => _program = program);
              },
              onLevelChanged: (level) {
                setState(() {
                  _level = level;
                  final labels = _labelsForLevel(level);
                  _selectedTargetLabel = labels.isEmpty ? null : labels.first;
                  _choiceCount = _presetChoiceCount(level);
                });
              },
              onChoiceCountChanged: (count) {
                setState(() => _choiceCount = count);
              },
              onTargetLabelChanged: (label) {
                setState(() => _selectedTargetLabel = label);
              },
              onStart: _startTraining,
            ),
    );
  }
}
