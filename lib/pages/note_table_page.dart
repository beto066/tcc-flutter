import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tccflutter/models/note_table.dart';
import 'package:tccflutter/models/note_table_value.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/widgets/molecules/select_note_table_value.dart';
import 'package:tccflutter/widgets/organisms/note_table_component.dart';

class NoteTablePage extends StatefulWidget {
  final Patient patient;

  const NoteTablePage({super.key, required this.patient});

  @override
  State<StatefulWidget> createState() {
    return _NoteTablePageState();
  }
}

class _NoteTablePageState extends State<NoteTablePage> {
  int? indexSelectedValue;
  bool isEditing = false;
  final _note = NoteTable();

  void _setSelectedValue(int index) {
    setState(() {
      indexSelectedValue = index;
    });
  }

  void _editValue(NoteTableValue value) {
    if (indexSelectedValue != null) {
      _note.values[indexSelectedValue!] = value;
      indexSelectedValue = null;
    } else {
      _note.values.add(value);
    }
  }

  void _removeValue(int index) {
    _note.values.removeAt(index);
    indexSelectedValue = null;
  }

  Future<void> _fetchNoteValues() async {
    if (kDebugMode) {
      print('hello mundo');
    }
  }

  @override
  Widget build(BuildContext context) {
    var contextWidth = MediaQuery.of(context).size.width;
    var contextHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: contextHeight,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
              child: Stack(
                children: [
                  NoteTableComponent(
                    values: _note.values,
                    onEditSelected: _setSelectedValue,
                    onRemoveSelected: _removeValue,
                    indexSelected: indexSelectedValue,
                  ),
                ],
              ),
            ),
          ),
          SelectNoteTableValue(
            note: _note,
            onSelect: (value) {
              setState(() {
                _editValue(value);
              });
            },
          ),
        ],
      ),
    );
  }
}
