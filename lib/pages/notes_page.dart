import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/stores/note_store.dart';
import 'package:tccflutter/widgets/molecules/card_list_item.dart';
import 'package:tccflutter/widgets/organisms/note_list.dart';
import 'package:tccflutter/widgets/organisms/patient_form_filter.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> notes = [];
  var isLoading = false;
  int? expandedId;
  Note? originalNoteExpanded;

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  Future<List<Note>> _fetchNotes({Map<String, dynamic>? queries}) async {
    isLoading = true;

    var fetchedNotes = await NoteStore().fetchNotes(
      title: queries?['title'],
      type: queries?['type'],
      from: queries?['from'],
      to: queries?['to'],
    );
    setState(() {
      notes = fetchedNotes;
      if (expandedId == null) {
        originalNoteExpanded = null;
        return;
      }
      _setOriginalNote(expandedId!);
    });

    return notes;
  }

  void _setOriginalNote(int? id) {
    setState(() {
      var expandedNote = notes.firstWhere((note) {
        return note.id == id;
      });

      originalNoteExpanded = expandedNote.clone();
    });
  }

  void _onExpanded(int? id) {
    if (expandedId == id) {
      expandedId = null;
      originalNoteExpanded = null;
      return;
    }
    _setOriginalNote(id);

    expandedId = id;
  }

  @override
  Widget build(BuildContext context) {
    var inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    var contextHeight = MediaQuery.of(context).size.height;
    var contextWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          CardListItem(
            'Abrir filtros de pesquisa',
            initialHeight: max(contextHeight * 0.06, 50),
            finalHeight: max(contextHeight * 0.06, 50) + 170,
            child: PatientFormFilter(onSearch: (queries) {
              _fetchNotes(queries: queries);
            }),
          ),

          NoteList(
            notes: notes,
            height: contextHeight * 0.75 - 100,
            onSave: _fetchNotes,
            onExpand: _onExpanded,
            expandedId: expandedId,
            originalNoteExpanded: originalNoteExpanded,
          )
        ],
      ),
    );
  }
}