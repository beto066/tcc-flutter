import 'package:flutter/material.dart';
import 'package:tccflutter/models/enums/training_result.dart';
import 'package:tccflutter/models/note_training.dart';

class SelectNoteTrainingResult extends StatefulWidget {
  final NoteTraining note;
  final int? index;

  const SelectNoteTrainingResult({super.key, required this.note, this.index});

  @override
  State<StatefulWidget> createState() {
    return SelectNoteTrainingResultState();
  }
}

class SelectNoteTrainingResultState extends State<SelectNoteTrainingResult> {
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
              child: Wrap(
                alignment: WrapAlignment.center,
                children: TrainingResult.values.map((value) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 90,
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.index != null) {
                          widget.note.results![widget.index!] = value;
                        } else {
                          widget.note.results!.add(value);
                        }
                        
                        Navigator.pop(context);
                      },
                      child: Flex(direction: Axis.horizontal, children: [
                        Text(value.label ?? ''),
                      ])
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}