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
    id = map['id'] as int?;
    authorId = map['authorId'];
    type = NoteType.training;
    level = DifficultyLevel.valueOf(map['level'] as String);
    createdAt = map['createdAt'] != null? DateTime.parse(map['createdAt']): null;
    visibilityForFamily = map['visibilityForFamily'];

    results = [];
    if (map['results'] is List<dynamic>) {
      results = (map['results'] as List).map((result) => TrainingResult.valueOf(result.toString())!).toList();
    }
  }

  @override
  bool hasChanges(Note other) {
    if (super.hasChanges(other)) {
      return true;
    }
    if (other is! NoteTraining) {
      return true;
    }

    final thisResults = results ?? [];
    final otherResults = other.results ?? [];

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

    for (int i = 0; i < 3 && (results?.isNotEmpty ?? true) && i < results!.length; i++) {
      subTitle += '|${results?[i].value ?? ''}| ';
    }

    return subTitle;
  }

  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();

    map['results'] = results?.map((result) {
      return result.label;
    });

    return map;
  }

  @override
  NoteTraining clone({Note? clone}) {
    var cloned = NoteTraining();
    super.clone(clone: cloned);

    cloned.results = results?.map((value) => value).toList();

    return cloned;
  }
}