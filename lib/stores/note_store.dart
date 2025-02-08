import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/note_table_value.dart';
import 'package:tccflutter/services/note_service.dart';

class NoteStore {
  Map<String, double>? statistics;

  double? countNotes;
  double? countWeeklyNotes;

  static final NoteStore _instance = NoteStore._internal();

  NoteStore._internal();

  factory NoteStore() {
    return _instance;
  }

  Future<List<dynamic>> fetchNotes({String? title, DateTime? from, DateTime? to, NoteType? type}) async {
    var notes = await NoteService().fetchNotes(title: title, from: from, to: to, type: type);
    return notes ?? [];
  }

  Future<Map<String, double>> fetchStatistics() async {
    statistics = await NoteService().fetchStatistics();
    return statistics ?? {};
  }

  Future<double?> fetchCountNotes() async {
    countNotes = await NoteService().fetchCountNote(null, null);
    return countNotes;
  }

  Future<double?> fetchCountWeeklyNotes() async {
    var from = DateTime.now().toUtc().subtract(const Duration(days: 7));

    countWeeklyNotes = await NoteService().fetchCountNote(from, null);
    return countWeeklyNotes;
  }

  List<NoteTableValue> fetchNoteTableValues() {
    return [];
  }
}