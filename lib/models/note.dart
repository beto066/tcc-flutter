import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/patient.dart';

abstract class Note {
  late final Patient? patient;
  late final Program? program;
  late final NoteType? type;
  late final DifficultyLevel? level;
}