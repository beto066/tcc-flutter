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

  void _onToggleVisibility() {
    setState(() {
      _note.visibilityForFamily = !(_note.visibilityForFamily ?? false);
    });
  }

  Future<void> _onSave() async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    var contextWidth = MediaQuery.of(context).size.width;
    var contextHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: contextHeight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                ElevatedButton.icon(
                  onPressed: _onSave,
                  icon: const Icon(Icons.save),
                  label: const Text("Salvar"),
                ),

                const SizedBox(width: 12),

                ElevatedButton.icon(
                  onPressed: _onToggleVisibility,
                  icon: const Icon(Icons.visibility),
                  label: _note.visibilityForFamily ?? false?
                    const Text("Tornar Visível"):
                    const Text('Tornar Invisível'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
