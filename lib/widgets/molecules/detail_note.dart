import 'package:flutter/material.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/note_pad.dart';
import 'package:tccflutter/models/note_table.dart';
import 'package:tccflutter/models/note_training.dart';
import 'package:tccflutter/widgets/atoms/input_text.dart';

class DetailNote extends StatefulWidget {
  final double? height;
  final Note note;

  const DetailNote({super.key, required this.note, this.height});

  @override
  State<StatefulWidget> createState() {
    return _DetailNoteState();
  }
}

class _DetailNoteState extends State<DetailNote> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  void _editNotePad(int listIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // Aguarda o modal abrir e ativa o teclado
        Future.delayed(const Duration(milliseconds: 100), () {
          _focusNode.requestFocus();
        });

        _controller.text = (widget.note as NotePad).body?[listIndex] ?? '';

        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Digite algo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              InputText('label', validator: (validator) => null, controller: _controller),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  (widget.note as NotePad).body![listIndex] = _controller.text;

                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
            ],
          ),
        );
      }
    );
  }

  void _editNoteTable() {

  }

  void _editNoteTraning() {

  }

  @override
  Widget build(BuildContext context) {
    var inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    var contextHeight = MediaQuery.of(context).size.height;
    var contextWidth = MediaQuery.of(context).size.width;

    var sizeHeight = widget.height ?? contextHeight * 0.53 - 170;

    return SizedBox(
      height: sizeHeight - 120,
      child: Builder(
        builder: (context) {
          if (widget.note is NotePad) {
            var note = widget.note as NotePad;

            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: (note.body ?? []).length,
              itemBuilder: (context, listIndex) {
                return ListTile(
                  leading: IconButton(onPressed: () => _editNotePad(listIndex), icon: const Icon(Icons.edit)),
                  title: Text(
                    note.body?[listIndex] ?? '',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16.0)
                  ),
                );
              }
            );

          } else if (widget.note is NoteTable) {
            var note = widget.note as NoteTable;

            return SizedBox(
              width: contextWidth * 0.8,
              child: Wrap(
                spacing: 10,
                children: note.values.map((value) {
                  return SizedBox(
                    width: 85,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Flex(direction: Axis.horizontal, children: [
                        const Icon(Icons.edit),
                        Text(value.label ?? ''),
                      ])
                    ),
                  );
                }).toList(),
              ),
            );

          } else if (widget.note is NoteTraining) {
            var note = widget.note as NoteTraining;

            return SizedBox(
              width: contextWidth * 0.9,
              child: Wrap(
                spacing: 10,
                children: note.results?.map((value) {
                  return SizedBox(
                    width: 85,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Flex(direction: Axis.horizontal, children: [
                        const Icon(Icons.edit),
                        Text(value.label),
                      ])
                    ),
                  );
                }).toList() ?? [],
              ),
            );
          }
          return Container();
        }
      ),
    );
  }
}