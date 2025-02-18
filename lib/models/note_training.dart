import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/models/enums/training_result.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/patient.dart';

class NoteTraining extends Note {
  List<TrainingResult>? results;

  NoteTraining();

  NoteTraining.factory(Map<String, dynamic> map) {
    if (map['patient'] != null) {
      patient = Patient.factory(map);
    }

    program = Program.valueOf(map['program'] as String);
    type = NoteType.training;
    level = DifficultyLevel.valueOf(map['level'] as String);
    createdAt = DateTime.parse(map['createdAt']);

    results = [];
    if (map['results'] is List<dynamic>) {
      results = (map['results'] as List).map((result) => TrainingResult.valueOf(result.toString())!).toList();
    }
  }

  @override
  String? getSubTitle() {
    var subTitle = '';

    for (int i = 0; i < 3 && ((results?.isNotEmpty ?? true) && i < results!.length - 1); i++) {
      subTitle += '|${results?[i].value ?? ''}| ';
    }

    return subTitle;
  }
}