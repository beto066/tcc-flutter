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
  final Note? originalNote;
  final VoidCallback? onSave;

  const DetailNote({
    super.key,
    required this.note,
    required this.originalNote,
    this.height,
    this.onSave
  });

  @override
  State<StatefulWidget> createState() {
    return _DetailNoteState();
  }
}

class _DetailNoteState extends State<DetailNote> {
  User? _loggedUser;
  bool _loading = false;
  bool _hasChange = false;

  @override
  void initState() {
    super.initState();
    _loadLoggedUser();

    setState(() {
      if (widget.originalNote == null) {
        _hasChange = true;
        return;
      }
      _hasChange = widget.note.hasChanges(widget.originalNote!);
    });
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
      if (widget.onSave != null) {
        widget.onSave!();
      }
    });
  }

  void _openNotePadModal({int? listIndex}) {
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

  void _openNoteTableModal({int? listIndex}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SelectNoteTableValue(
            note: widget.note as NoteTable,
            index: listIndex,
            onSelect: (value) {
              var note = widget.note as NoteTable;

              if (listIndex != null) {
                note.values[listIndex] = value;

                if (Navigator.of(context).mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
        );
      }
    );
  }

  void _openNoteTrainingModal({int? listIndex}) {
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
    final multipleOf110 = (contextWidth ~/ 110) * 110;

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
                    onPressed: widget.note.visibilityForFamily != null && isAuthor?
                      () {
                        setState(() {
                          widget.note.visibilityForFamily = !widget.note.visibilityForFamily!;
                        });
                      }:
                      null,
                    tooltip: widget.note.visibilityForFamily ?? false ?
                      'Tornar visível':
                      'Tornar invisível',
                    icon:  Icon(
                      widget.note.visibilityForFamily ?? false?
                        Icons.lock_open:
                        Icons.lock,
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
                    onPressed: isAuthor && _hasChange? () async {
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
        Container(
          constraints: BoxConstraints(
            maxHeight: sizeHeight - 80,
          ),
          child: Builder(
            builder: (context) {
              if (widget.note is NotePad) {
                var note = widget.note as NotePad;

                if (note.body == null || note.body!.isEmpty) {
                  return const Text('Nenhum texto nessa anotação');
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: isAuthor?
                    (note.body ?? []).length + 1:
                    (note.body ?? []).length,
                  itemBuilder: (context, listIndex) {
                    Widget? leading;

                    if (isAuthor) {
                      leading = const Icon(Icons.edit);
                    }

                    if (isAuthor && listIndex == note.body!.length) {
                      return ListTile(
                        leading: const Icon(Icons.add),
                        onTap: () => {
                          _openNotePadModal()
                        },
                        title: const Text("Adicionar texto"),
                      );
                    }

                    return ListTile(
                      leading: leading,
                      onTap: () => {
                        _openNotePadModal(listIndex: listIndex)
                      },
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

                if (note.values.isEmpty) {
                  return const Text('Nenhum valor nessa anotação');
                }

                final children = note.values.asMap().entries.map((entry) {
                  var value = entry.value;
                  var index = entry.key;

                  return SizedBox(
                    width: isAuthor? 100: 70,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (isAuthor) {
                          _openNoteTableModal(listIndex: index);
                        }
                      },
                      icon: isAuthor? const Icon(Icons.edit): null,
                      label: Text(
                        value.label ?? '',
                        textAlign: TextAlign.center
                      ),
                    ),
                  );
                }).toList();

                if (isAuthor) {
                  children.add(
                    SizedBox(
                      width: 100,
                      child: ElevatedButton.icon(
                        onPressed: () => _openNoteTableModal(),
                        icon: const Icon(Icons.add),
                        label: const Text("Novo"),
                      ),
                    ),
                  );
                }

                return Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 1,
                  child: SizedBox(
                    width: multipleOf110 * 1,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: children,
                    ),
                  ),
                );

              } else if (widget.note is NoteTraining) {
                var note = widget.note as NoteTraining;

                if (note.results == null || note.results!.isEmpty) {
                  return const Text('Nenhum resultado nessa anotação');
                }

                final children = note.results?.asMap().entries.map((entry) {
                  var value = entry.value;
                  var index = entry.key;

                  return SizedBox(
                    width: isAuthor? 100: 70,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (isAuthor) {
                          _openNoteTrainingModal(listIndex: index);
                        }
                      },
                      icon: isAuthor? const Icon(Icons.edit): null,
                      label: Text(value.label, textAlign: TextAlign.center),
                    ),
                  );
                }).toList() ?? [];

                if (isAuthor) {
                  children.add(
                    SizedBox(
                      width: 100,
                      child: ElevatedButton.icon(
                        onPressed: () => _openNoteTrainingModal(),
                        icon: const Icon(Icons.add),
                        label: const Text("Novo"),
                      ),
                    ),
                  );
                }

                return SizedBox(
                  width: multipleOf110 * 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 1,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: children,
                    ),
                  ),
                );
              }
              return Container();
            }
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}