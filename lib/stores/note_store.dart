import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/patient.dart';
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

  Future<List<Note>> fetchNotes({String? title, DateTime? from, DateTime? to, NoteType? type}) async {
    var notes = await NoteService().fetchNotes(title: title, from: from, to: to, type: type);
    return notes;
  }

  Future<List<Note>> fetchNotesByPatient(Patient patient, Map<String, dynamic>? queries) async {
    var notes = await NoteService().fetchNotesByPatient(patient, queries);
    return notes;
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

  Future<void> addNote(Note note) async {
    await NoteService().addNote(note);
  }

  Future<void> updateNote(Note note) async {
    await NoteService().updateNote(note);
  }

  Future<List<dynamic>> fetchNoteTableValues() async {
    return await NoteService().fetchNoteValue();
  }
}