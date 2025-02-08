import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/note_table_value.dart';
import 'package:tccflutter/models/patient.dart';

class NoteTable extends Note {
  late final List<NoteTableValue> values;

  NoteTable();

  NoteTable.factory(Map<String, dynamic> map) {
    if (map['patient'] != null) {
      patient = Patient.factory(map);
    }

    program = Program.valueOf(map['program'] as String);
    type = NoteType.table;
    level = DifficultyLevel.valueOf(map['level'] as String);
    values = (map['values'] as List<Map<String, dynamic>>).map((value) => NoteTableValue.factory(value)).toList();
  }
}