import 'package:tccflutter/exceptions/internal_server_error_exception.dart';
import 'package:tccflutter/exceptions/unexpected_exception.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/note_pad.dart';
import 'package:tccflutter/models/note_table.dart';
import 'package:tccflutter/models/note_table_value.dart';
import 'package:tccflutter/models/note_training.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/util/api_service.dart';
import 'dart:convert';

class NoteService {
  static final NoteService _instance = NoteService._internal();

  NoteService._internal();

  factory NoteService() {
    return _instance;
  }

  Future<List<dynamic>> fetchNotes({String? title, DateTime? from, DateTime? to, NoteType? type}) async {
    Map<String, dynamic> queryParams = {};

    if (title != null) {
      queryParams['title'] = title;
    }

    if (from != null) {
      queryParams['from'] = from.toUtc().toIso8601String();
    }

    if (to != null) {
      queryParams['to'] = to.toUtc().toIso8601String();
    }

    if (type != null) {
      queryParams['type'] = type.id;
    }

    var response = await ApiService().get('/notes', queryParams: queryParams);

    var body = jsonDecode(utf8.decode(response.bodyBytes));

    return body.map((e) {
      if (e is Map<String, dynamic>) {
        return Note.factory(e);
      }
      return NoteTable();
    }).toList();
  }

  Future<void> addNote(Note note) async {
    Map<String, dynamic> noteMap = {
      'patientId': note.patient?.id,
      'level': 1,
      'visibilityForFamily': note.visibilityForFamily,
      'program': 1,
    };
    if (note is NoteTable) {
      Map<String, dynamic> noteMap = {
        'patientId': note.patient?.id,
        'level': 1,
        'visibilityForFamily': note.visibilityForFamily,
        'program': 1,
        'values': [],
      };

      note.values ??= [];

      for (var i = 0; i < note.values!.length; i++) {
        noteMap['values'] = [];
        noteMap['values']!.add({
          'tableId': note.id,
          'valueId': note.values![i].id,
          'position': i
        });
      }

      var response = ApiService().post('/notes/tables', data: noteMap);
    } else if (note is NotePad) {
      noteMap['body'] = note.body ?? [];

      var response = ApiService().post('/notes/pad', data: noteMap);
    }
  }

  Future<void> updateNote(Note note) async {
    Map<String, dynamic> noteMap = {
      'body': [],
      'values': [],
      'results': [],
      'visibilityForFamily': note.visibilityForFamily,
    };

    if (note is NotePad) {
      noteMap['body'] = note.body ?? [];
    }

    if (note is NoteTable) {
      note.values ??= [];

      noteMap['values'] = [];
      for (var i = 0; i < note.values!.length; i++) {
        noteMap['values']!.add({
          'tableId': note.id,
          'valueId': note.values![i].id,
          'position': i
        });
      }
    }

    if (note is NoteTraining) {
      noteMap['results'] = [];
      for (var i = 0; i < (note.results?.length ?? 0); i++) {
        noteMap['results']!.add({
          'trainingId': note.id,
          'resultId': note.results![i].id,
          'position': i
        });
      }
    }

    var response = await ApiService().put('/notes/${note.id}', data: noteMap);
  }

  Future<List<dynamic>> fetchNotesByPatient(Patient patient, Map<String, dynamic>? queries) async {
    var response = await ApiService().get('/notes/patient/${patient.id}', queryParams: queries ?? {});

    var body = jsonDecode(utf8.decode(response.bodyBytes));

    return body.map((e) {
      if (e is Map<String, dynamic>) {
        return Note.factory(e);
      }
      return NoteTable();
    }).toList();
  }

  Future<List<dynamic>> fetchNoteValue() async {
    var response = await ApiService().get('/users/notes/values');

    var body = jsonDecode(utf8.decode(response.bodyBytes));return body.map((e) {
      if (e is Map<String, dynamic>) {
        return NoteTableValue.factory(e);
      }
      return NoteTableValue();
    }).toList();
  }

  Future<double?> fetchCountNote(DateTime? from, DateTime? to) async {
    Map<String, String> queryParams = {};

    if (from != null) {
      var iso8601string = from.toUtc().toIso8601String();
      queryParams['from'] = iso8601string;
    }

    if (to != null) {
      queryParams['to'] = to.toUtc().toIso8601String();
    }

    var response = await ApiService().get('/notes/count');

    var decodedBody = double.tryParse(response.body);

    if (decodedBody == null) {
      throw UnexpectedException('O valor retornado não é uma string');
    }

    return decodedBody;
  }

  Future<Map<String, double>> fetchStatistics() async {
    var response = await ApiService().get('/notes/statistics');

    return (jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>).map<String, double>((key, value) {
      if (value is int) {
        return MapEntry(key, value * 1.0);
      } else if (value is double) {
        return MapEntry(key, value);
      }
      throw InternalServerErrorException('${jsonEncode(response.body)}, with statusCode: ${response.body}');
    });
  }
}