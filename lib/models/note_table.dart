import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/note_table_value.dart';
import 'package:tccflutter/models/patient.dart';

class NoteTable extends Note {
  late final List<NoteTableValue> values;

  NoteTable() {
    values = [];
  }

  NoteTable.factory(Map<String, dynamic> map) {
    if (map['patient'] != null) {
      patient = Patient.factory(map);
    }

    program = Program.valueOf(map['program'] as String);
    id = map['id'] as int?;
    authorId = map['authorId'];
    type = NoteType.table;
    level = DifficultyLevel.valueOf(map['level'] as String);
    createdAt = map['createdAt'] != null? DateTime.parse(map['createdAt']): null;
    visibilityForFamily = map['visibilityForFamily'];

    if (map['values'] is List && map['values'].length > 0) {
      values = (map['values'] as List<dynamic>).map((value) => NoteTableValue.factory(value)).toList();
    } else {
      values = [];
    }
  }

  @override
  bool hasChanges(Note other) {
    if (super.hasChanges(other)) {
      return true;
    }
    if (other is! NoteTable) {
      return true;
    }

    final thisResults = values;
    final otherResults = other.values;

    if (thisResults.length != otherResults.length) {
      return true;
    }

    var hasChanges = false;

    for (int i = 0; i < otherResults.length; i++) {
      if (thisResults[i] != otherResults[i]) {
        return true;
      }
    }

    return hasChanges;
  }

  @override
  String? getSubTitle() {
    var subTitle = '';

    for (int i = 0; i < 3 && (values.isNotEmpty) && i < values.length; i++) {
      subTitle += '|${values[i].value ?? ''}| ';
    }

    return subTitle;
  }

  @override
  NoteTable clone({Note? clone}) {
    var cloned = NoteTable();
    super.clone(clone: cloned);

    cloned.values = values.map((value) => value).toList();

    return cloned;
  }
}