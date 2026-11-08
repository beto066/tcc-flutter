import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/app_image.dart';
import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/stores/auth_store.dart';
import 'package:tccflutter/stores/note_store.dart';
import 'package:tccflutter/stores/patient_store.dart';
import 'package:tccflutter/util/training_preferences.dart';
import 'package:tccflutter/widgets/molecules/card_list_item.dart';
import 'package:tccflutter/widgets/molecules/modal_image.dart';
import 'package:tccflutter/widgets/molecules/patient_header.dart';
import 'package:tccflutter/widgets/molecules/patient_training_defaults.dart';
import 'package:tccflutter/widgets/organisms/note_list.dart';
import 'package:tccflutter/widgets/organisms/patient_form_filter.dart';

class DetailPatientPage extends StatefulWidget {
  final Patient patient;

  const DetailPatientPage(this.patient, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _DetailPatientPageState();
  }
}

class _DetailPatientPageState extends State<DetailPatientPage> {
  late AppLocalizations _localization;
  bool _preferencesLoadStarted = false;
  var isLoading = true;
  Note? originalNoteExpanded;
  List<Note> notes = [];
  int? expandedId;
  AppImage? image;
  int? _preferencesUserId;
  Program? _defaultProgram;
  DifficultyLevel? _defaultDifficulty;
  bool _preferencesLoading = true;
  String? _preferencesError;

  @override
  void initState() {
    super.initState();
    _fetchNotes();
    _loadImage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localization = AppLocalizations.of(context)!;
    if (_preferencesLoadStarted) return;
    _preferencesLoadStarted = true;
    _loadPatientTrainingPreferences();
  }

  Future<void> _loadPatientTrainingPreferences() async {
    try {
      final patientId = widget.patient.id;
      final userId = (await AuthStore().loggedUser)?.id;
      if (patientId == null || userId == null) {
        throw StateError(
          _localization.training_identity_error,
        );
      }

      final patientProgram =
          await TrainingPreferences.getPatientDefaultProgram(userId, patientId);
      final patientDifficulty =
          await TrainingPreferences.getPatientDefaultDifficulty(
        userId,
        patientId,
      );
      final program =
          patientProgram ?? await TrainingPreferences.getDefaultProgram(userId);
      final difficulty = patientDifficulty ??
          await TrainingPreferences.getDefaultDifficulty(userId);

      if (!mounted) return;
      setState(() {
        _preferencesUserId = userId;
        _defaultProgram = program;
        _defaultDifficulty = difficulty;
        _preferencesLoading = false;
        _preferencesError = null;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _preferencesLoading = false;
        _preferencesError =
            _localization.training_defaults_load_error('$error');
      });
    }
  }

  Future<void> _savePatientDefaultProgram(Program program) async {
    final userId = _preferencesUserId;
    final patientId = widget.patient.id;
    if (userId == null || patientId == null) {
      _showPreferenceError(
        StateError(_localization.training_identity_error),
      );
      return;
    }

    try {
      await TrainingPreferences.setPatientDefaultProgram(
        userId,
        patientId,
        program,
      );
      if (mounted) setState(() => _defaultProgram = program);
    } catch (error) {
      _showPreferenceError(error);
    }
  }

  Future<void> _savePatientDefaultDifficulty(DifficultyLevel level) async {
    final userId = _preferencesUserId;
    final patientId = widget.patient.id;
    if (userId == null || patientId == null) {
      _showPreferenceError(
        StateError(_localization.training_identity_error),
      );
      return;
    }

    try {
      await TrainingPreferences.setPatientDefaultDifficulty(
        userId,
        patientId,
        level,
      );
      if (mounted) setState(() => _defaultDifficulty = level);
    } catch (error) {
      _showPreferenceError(error);
    }
  }

  void _showPreferenceError(Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _localization.training_defaults_save_error('$error'),
        ),
      ),
    );
  }

  void _onTapImage() {
    if (image == null) {
      _onEditImage();
      return;
    }

    ModalImage.show(
      context,
      image: image!,
      onEdit: () async {
        final picker = ImagePicker();
        final file = await picker.pickImage(source: ImageSource.gallery);
        if (file != null) {
          final newFile = await AppImage.fromXFile(file);
          await PatientStore().saveImage(newFile, widget.patient);
          await _loadImage();
          return image;
        }
        return null;
      },
      onDelete: () async {
        if (image != null) {
          await PatientStore().deleteImage(widget.patient);
          setState(() {
            image = null;
          });
        }
      },
    );
  }

  void _onEditImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      await PatientStore().saveImage(
        await AppImage.fromXFile(file),
        widget.patient,
      );
      await _loadImage();
    }
  }

  Future<void> _loadImage() async {
    var loadedImage = await PatientStore().getImage(widget.patient);
    setState(() {
      image = loadedImage;
    });
  }

  Future<List<dynamic>> _fetchNotes({Map<String, dynamic>? queries}) async {
    isLoading = true;

    var fetchedNotes =
        await NoteStore().fetchNotesByPatient(widget.patient, queries);
    setState(() {
      notes = fetchedNotes;
      if (expandedId == null) {
        originalNoteExpanded = null;
        return;
      }
      _setOriginalNote(expandedId!);
    });

    return notes;
  }

  void _onExpanded(int? id) {
    if (expandedId == id) {
      expandedId = null;
      originalNoteExpanded = null;
      return;
    }
    _setOriginalNote(id);

    expandedId = id;
  }

  void _setOriginalNote(int? id) {
    setState(() {
      var expandedNote = notes.firstWhere((note) {
        return note.id == id;
      });

      originalNoteExpanded = expandedNote.clone();
    });
  }

  @override
  Widget build(BuildContext context) {
    var contextHeight = MediaQuery.of(context).size.height;
    var contextWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: contextWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: contextHeight * (contextHeight > 600 ? 0.03 : 0.03)),
          Text(widget.patient.name ?? '',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: (contextHeight * 0.05) > 30
                      ? (contextHeight * 0.05)
                      : 30)),
          SizedBox(height: contextHeight * (contextHeight > 600 ? 0.01 : 0.01)),
          PatientHeader(
            countNotes: '5',
            age: '${widget.patient.age}',
            therapyDuration: '${widget.patient.therapyDuration}',
            patient: widget.patient,
            image: image,
            onTapImage: _onTapImage,
            onEditImage: _onEditImage,
          ),
          Expanded(
            child: NoteList(
              notes: notes,
              header: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PatientTrainingDefaults(
                    program: _defaultProgram,
                    difficulty: _defaultDifficulty,
                    isLoading: _preferencesLoading,
                    error: _preferencesError,
                    onProgramChanged: _savePatientDefaultProgram,
                    onDifficultyChanged: _savePatientDefaultDifficulty,
                    onRetry: _loadPatientTrainingPreferences,
                  ),
                  CardListItem(
                    _localization.note_filter_title,
                    initialHeight: max(contextHeight * 0.06, 50),
                    finalHeight: max(contextHeight * 0.06, 50) + 170,
                    child: PatientFormFilter(onSearch: (queries) {
                      _fetchNotes(queries: queries);
                    }),
                  ),
                ],
              ),
              onSave: _fetchNotes,
              onExpand: _onExpanded,
              expandedId: expandedId,
              originalNoteExpanded: originalNoteExpanded,
            ),
          ),
        ],
      ),
    );
  }
}
