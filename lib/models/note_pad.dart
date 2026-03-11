import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/patient.dart';

class NotePad extends Note {
  List<String>? body;

  NotePad() {
    body = [];
  }

  NotePad.factory(Map<String, dynamic> map) {
    if (map['patient'] != null) {
      patient = Patient.factory(map);
    }

    program = Program.valueOf(map['program'] as String);
    id = map['id'] as int?;
    authorId = map['authorId'];
    type = NoteType.notepad;
    level = DifficultyLevel.valueOf(map['level'] as String);
    title = map['title'] as String?;
    body = (map['body'] ?? [] as List<dynamic>?)?.map<String>((e) => e.toString()).toList();
    createdAt = map['createdAt'] != null? DateTime.parse(map['createdAt']): null;
    visibilityForFamily = map['visibilityForFamily'];
  }

  @override
  bool hasChanges(Note other) {
    if (super.hasChanges(other)) {
      return true;
    }

    if (other is! NotePad) {
      return true;
    }

    final thisResults = body ?? [];
    final otherResults = other.body ?? [];

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
    return body?[0] ?? ' - ';
  }

  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();

    map['body'] = body;

    return map;
  }

  @override
  NotePad clone({Note? clone}) {
    var cloned = NotePad();
    super.clone(clone: cloned);

    cloned.body = body?.map((value) => value).toList();

    return cloned;
  }
}