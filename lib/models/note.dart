import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/note_pad.dart';
import 'package:tccflutter/models/note_table.dart';
import 'package:tccflutter/models/note_training.dart';
import 'package:tccflutter/models/patient.dart';

abstract class Note {
  String? title;
  late final Patient? patient;
  late final Program? program;
  late final NoteType? type;
  late final DifficultyLevel? level;
  late final DateTime createdAt;

  Note();

  factory Note.factory(Map<String, dynamic> map) {
    if (map['type'] == null) {
      throw Exception('Erro tipo não pode ser null');
    }

    if (map['type'] == NoteType.notepad.description) {
      return NotePad.factory(map);
    }

    if (map['type'] == NoteType.table.description) {
      return NoteTable.factory(map);
    }

    return NoteTraining.factory(map);
  }

  String? getSubTitle();
}