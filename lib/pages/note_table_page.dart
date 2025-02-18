import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tccflutter/models/note_table_value.dart';
import 'package:tccflutter/widgets/organisms/note_table_component.dart';

class NoteTablePage extends StatefulWidget {
  const NoteTablePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NoteTablePageState();
  }
}

class _NoteTablePageState extends State<NoteTablePage> {
  int? indexSelectedValue;
  List<NoteTableValue> values = [];
  bool isEditing = false;

  void _setSelectedValue(int index) {
    setState(() {
      indexSelectedValue = index;
    });
  }

  void _editValue() {
    isEditing = true;
  }

  void _removeValue() {
    values.removeAt(indexSelectedValue!);
  }

  Future<void> _fetchNoteValues() async {
    if (kDebugMode) {
      print('hello mundo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
      child: Stack(
        children: [
          NoteTableComponent(
            values: values,
            selectedTableValue: _setSelectedValue,
          ),
          if (indexSelectedValue != null)
            Positioned(
              bottom: 20,
              right: 20,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.yellow[200], // Cor de "post-it"
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: _editValue,
                        child: const Text('Editar',
                            style: TextStyle(color: Colors.black)),
                      ),
                      TextButton(
                        onPressed: _removeValue,
                        child: const Text('Excluir',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: FutureBuilder(
          //     future: _fetchNoteValues(),
          //     builder: (context) {
          //       return Container();
          //     }
          //   ),
          // )
        ],
      ),
    );
  }
}
