import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/note_pad.dart';
import 'package:tccflutter/models/note_table.dart';
import 'package:tccflutter/models/note_training.dart';
import 'package:tccflutter/models/patient.dart';

class Note {
  int? id;
  String? title;
  int? authorId;
  late final Patient? patient;
  late final Program? program;
  late final NoteType? type;
  late final DifficultyLevel? level;                          
  late final DateTime? createdAt;
  bool? visibilityForFamily;

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'patient': patient?.toMap() ?? {},
      'program': program?.description,
      'type': type?.description,
      'level': level?.description,
      'createdAt': createdAt,
      'visibilityForFamily': visibilityForFamily,
    };
  }

  Note clone({Note? clone}) {
    clone ??= Note();
    clone.id = id;
    clone.title = title;
    clone.authorId = authorId;
    clone.patient = patient;
    clone.program = program;
    clone.type = type;
    clone.level = level;
    clone.createdAt = createdAt;
    clone.visibilityForFamily = visibilityForFamily;

    return clone;
  }

  String? getSubTitle() {
    return '';
  }

  bool hasChanges(Note other) {
    return title != other.title || level != other.level || visibilityForFamily != other.visibilityForFamily;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}