import 'package:flutter/foundation.dart';
import 'package:tccflutter/exceptions/bad_request_exception.dart';
import 'package:tccflutter/exceptions/internal_server_error_exception.dart';
import 'package:tccflutter/exceptions/unauthorized_exception.dart';
import 'package:tccflutter/exceptions/unexpected_exception.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/note_table.dart';
import 'package:tccflutter/models/note_table_value.dart';
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
      queryParams['from'] = from.toIso8601String();
    }

    if (to != null) {
      queryParams['to'] = to.toIso8601String();
    }

    if (type != null) {
      queryParams['type'] = type.id;
    }

    var response = await ApiService().get('/notes', queryParams: queryParams);

    var body = jsonDecode(utf8.decode(response.bodyBytes));

    // if (body is List<Map<String, dynamic>>) {
      var notes = body.map((e) {
        if (e is Map<String, dynamic>) {
          return Note.factory(e);
        }
        return NoteTable();
      }).toList();
    // }

    print(notes);
    return notes;
  }

  Future<List<NoteTableValue>> fetchNoteValue() async {
    var response = await ApiService().get('/users/notes/values');
    return [];
  }

  Future<double?> fetchCountNote(DateTime? from, DateTime? to) async {
    Map<String, String> queryParams = {};

    if (from != null) {
      queryParams['from'] = from.toIso8601String();
    }

    if (to != null) {
      queryParams['to'] = to.toIso8601String();
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