import 'package:flutter/material.dart';
import 'package:tccflutter/models/note_table.dart';
import 'package:tccflutter/models/note_table_value.dart';
import 'package:tccflutter/stores/note_store.dart';

class SelectNoteTableValue extends StatefulWidget
{
  final NoteTable note;
  final int? index;
  final void Function(NoteTableValue) onSelect;

  const SelectNoteTableValue({super.key, required this.note, required this.onSelect, this.index});

  @override
  State<StatefulWidget> createState() {
    return SelectNoteTableValueState();
  }
}

class SelectNoteTableValueState extends State<SelectNoteTableValue> {
  Future<List<dynamic>> _fetchNoteValues() async {
    return await NoteStore().fetchNoteTableValues();
  }

  @override
  Widget build(BuildContext context) {
    var contextWidth = MediaQuery.of(context).size.width;
    var contextHeight = MediaQuery.of(context).size.height;
    
    return SizedBox(
      height: 110,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Selecione um resultado',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: contextWidth,
              child: FutureBuilder(
                future: _fetchNoteValues(),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    return Wrap(
                      spacing: 10,
                      alignment: WrapAlignment.center,
                      children: snapshot.data!.map((value) {
                        if (value is NoteTableValue) {
                          return SizedBox(
                            width: 80,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.onSelect(value);
                              },
                              child: Flex(direction: Axis.horizontal, children: [
                                Text(value.label ?? ''),
                              ])
                            ),
                          );
                        }
                        return Container();
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  return const SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}