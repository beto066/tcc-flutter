import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/enums/training_result.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/patient.dart';

class NoteTraining extends Note {
  late final List<TrainingResult>? results;

  NoteTraining();

  NoteTraining.factory(Map<String, dynamic> map) {
    if (map['patient'] != null) {
      patient = Patient.factory(map);
    }

    program = Program.valueOf(map['program'] as String);
    type = NoteType.training;
    level = DifficultyLevel.valueOf(map['level'] as String);

    if (map['results'] is List<String>) {
      results = (map['results']).map((result) => TrainingResult.valueOf(result)!).toList();
    }
  }
}