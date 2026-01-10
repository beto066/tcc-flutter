import 'package:flutter/material.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/note_pad.dart';
import 'package:tccflutter/models/note_table.dart';
import 'package:tccflutter/models/note_training.dart';
import 'package:tccflutter/models/user.dart';
import 'package:tccflutter/stores/auth_store.dart';
import 'package:tccflutter/stores/note_store.dart';
import 'package:tccflutter/widgets/molecules/select_note_table_value.dart';
import 'package:tccflutter/widgets/molecules/select_note_training_result.dart';
import 'package:tccflutter/widgets/molecules/text_note_pad.dart';

class DetailNote extends StatefulWidget {
  final double? height;
  final Note note;
  final VoidCallback? onSave;

  const DetailNote({super.key, required this.note, this.height, this.onSave});

  @override
  State<StatefulWidget> createState() {
    return _DetailNoteState();
  }
}

class _DetailNoteState extends State<DetailNote> {
  User? _loggedUser;
  Note? _originalNote;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _originalNote = widget.note.clone();
    _loadLoggedUser();
  }

  Future<void> _loadLoggedUser() async {
    _loggedUser = await AuthStore().loggedUser;
    setState(() {});
  }

  Future<void> _updateNote(Note note) async {
    _loading = true;
    await NoteStore().updateNote(note);
    setState(() {
      _loading = false;
      _originalNote = widget.note;
      if (widget.onSave != null) {
        widget.onSave!();
      }
    });
  }

  void _editNotePad(int listIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: TextNotePad(note: widget.note as NotePad, index: listIndex)
        );
      }
    );
  }

  void _editNoteTable(int listIndex) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: SelectNoteTableValue(
              note: widget.note as NoteTable,
              index: listIndex
            ),
          );
        }
    );
  }

  void _editNoteTraining(int listIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
            padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: SelectNoteTrainingResult(
            note: widget.note as NoteTraining,
            index: listIndex
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    var primary = Theme.of(context).colorScheme.primary;
    var contextHeight = MediaQuery.of(context).size.height;
    var contextWidth = MediaQuery.of(context).size.width;

    var sizeHeight = widget.height ?? contextHeight * 0.53;
    var isAuthor = _loggedUser?.id == widget.note.authorId;

    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                  child: IconButton(
                    disabledColor: Colors.grey[690],
                    color: primary,
                    onPressed: widget.note.visibilityForFamily != null && isAuthor? () {
                      setState(() {
                        widget.note.visibilityForFamily = !widget.note.visibilityForFamily!;
                      });
                    }: null,
                    tooltip: 'Tornar visível',
                    icon:  Icon(
                      widget.note.visibilityForFamily?? false? Icons.lock_open: Icons.lock,
                      size: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 30,
                  child: IconButton(
                    disabledColor: Colors.grey[690],
                    color: primary,
                    onPressed: isAuthor && (
                      _originalNote == null ||
                      widget.note.hasChanges(_originalNote!)
                    )? () async {
                      _updateNote(widget.note);
                    }: null,
                    tooltip: 'Salvar',
                    icon: const Icon(Icons.save_as, size: 15),
                  ),
                ),
              ],
            ),
          )
        ),
        SizedBox(
          height: sizeHeight - 80,
          child: Builder(
            builder: (context) {
              if (widget.note is NotePad) {
                var note = widget.note as NotePad;

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: (note.body ?? []).length,
                  itemBuilder: (context, listIndex) {
                    Widget? leading;

                    if (isAuthor) {
                      leading = IconButton(onPressed: () => _editNotePad(listIndex), icon: const Icon(Icons.edit));
                    }

                    return ListTile(
                      leading: leading,
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
                    children: note.values.asMap().entries.map((entry) {
                      var value = entry.value;
                      var index = entry.key;

                      return SizedBox(
                        width: isAuthor? 85: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            if (isAuthor) {
                              _editNoteTable(index);
                            }
                          },
                          child: Flex(direction: Axis.horizontal, children: [
                            if (isAuthor) const Icon(Icons.edit),
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
                    children: note.results?.asMap().entries.map((entry) {
                      var value = entry.value;
                      var index = entry.key;

                      return SizedBox(
                        width: isAuthor? 85: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            if (isAuthor) {
                              _editNoteTraining(index);
                            }
                          },
                          child: Flex(direction: Axis.horizontal, children: [
                            if (isAuthor) const Icon(Icons.edit),
                            Text(value.label, textAlign: TextAlign.center),
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
        ),
      ],
    );
  }
}