import 'package:flutter/material.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/user.dart';
import 'package:tccflutter/stores/auth_store.dart';
import 'package:tccflutter/stores/note_store.dart';
import 'package:tccflutter/widgets/molecules/note_content.dart';
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
    var loggedUser = await AuthStore().loggedUser;
    setState(() {
      _loggedUser = loggedUser;
    });
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

  @override
  Widget build(BuildContext context) {
    var inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    var primary = Theme.of(context).colorScheme.primary;
    var contextHeight = MediaQuery.of(context).size.height;
    var contextWidth = MediaQuery.of(context).size.width;

    var sizeHeight = widget.height ?? contextHeight * 0.53;
    var isAuthor = _loggedUser?.id == widget.note.authorId;
    double multipleOf110 = (contextWidth ~/ 110) * 110;

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
        NoteContent(
          note: widget.note,
          isAuthor: isAuthor,
          sizeHeight: sizeHeight,
          multipleOf110: multipleOf110,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}