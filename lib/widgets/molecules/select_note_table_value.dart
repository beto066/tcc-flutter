import 'package:flutter/material.dart';
import 'package:tccflutter/models/note_table.dart';
import 'package:tccflutter/models/note_table_value.dart';
import 'package:tccflutter/stores/note_store.dart';

class SelectNoteTableValue extends StatefulWidget
{
  final NoteTable note;
  final int? index;

  const SelectNoteTableValue({super.key, required this.note, this.index});

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
      height: contextHeight * 0.4,
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
                      alignment: WrapAlignment.center,
                      children: snapshot.data!.map((value) {
                        if (value is NoteTableValue) {
                          return SizedBox(
                            width: 70,
                            child: ElevatedButton(
                              onPressed: () {
                                if (widget.index != null) {
                                  widget.note.values[widget.index!] = value;
                                } else {
                                  widget.note.values.add(value);
                                }

                                Navigator.pop(context);
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