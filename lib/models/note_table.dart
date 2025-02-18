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
    createdAt = DateTime.parse(map['createdAt']);
    values = (map['values'] as List<Map<String, dynamic>>).map((value) => NoteTableValue.factory(value)).toList();
  }

  @override
  String? getSubTitle() {
    var subTitle = '';
    for (int i = 0; i < 3 && (values.isNotEmpty && i < values.length - 1); i++) {
      subTitle += values[i].label ?? '';
    }

    return subTitle;
  }
}