import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/patient.dart';

class NotePad extends Note {
  late final List<String>? body;

  NotePad();

  NotePad.factory(Map<String, dynamic> map) {
    if (map['patient'] != null) {
      patient = Patient.factory(map);
    }

    program = Program.valueOf(map['program'] as String);
    type = NoteType.notepad;
    level = DifficultyLevel.valueOf(map['level'] as String);
    title = map['title'] as String?;
    body = (map['body'] as List<dynamic>?)?.map<String>((e) => e.toString()).toList();
    createdAt = DateTime.parse(map['createdAt']);
  }

  @override
  String? getSubTitle() {
    return body?[0] ?? ' - ';
  }
}