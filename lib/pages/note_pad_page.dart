import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/note_pad.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/stores/note_store.dart';
import 'package:tccflutter/widgets/atoms/input_text.dart';

class NotePadPage extends StatefulWidget {
  final Patient patient;

  const NotePadPage({super.key, required this.patient});

  @override
  State<StatefulWidget> createState() {
    return _NotePadPageState();
  }
}

class _NotePadPageState extends State<NotePadPage> {
  int? indexSelectedValue;
  final _bodyController = TextEditingController();
  final _bodyFocusNode = FocusNode();
  final NotePad _note = NotePad();

  @override
  void dispose() {
    _bodyController.dispose();
    _bodyFocusNode.dispose();
    super.dispose();
  }

  void _setSelectedValue(int index) {
    setState(() {
      indexSelectedValue = index;
    });
  }

  void _setBodyInNote() {
    final body = _bodyController.text.trim();
    if (body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.note_field_empty),
        ),
      );
      _bodyFocusNode.requestFocus();
      return;
    }

    setState(() {
      if (indexSelectedValue == null) {
        _note.body!.add(body);
      } else {
        _note.body![indexSelectedValue!] = body;
        indexSelectedValue = null;
      }

      _bodyController.clear();
    });
    _bodyFocusNode.requestFocus();
  }

  void _onToggleVisibility() {
    setState(() {
      _note.visibilityForFamily = !(_note.visibilityForFamily ?? false);
    });
  }

  Future<void> _onSave() async {
    _note.patient = widget.patient;
    await NoteStore().addNote(_note);

    if (Navigator.of(context).mounted) {
      Navigator.of(context)
          .popAndPushNamed('Patient', arguments: {'patient': widget.patient});
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: _onSave,
                icon: const Icon(Icons.save),
                label: Text(localization.save),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _onToggleVisibility,
                icon: const Icon(Icons.visibility),
                label: _note.visibilityForFamily ?? false
                    ? Text(localization.note_visible)
                    : Text(localization.note_hidden),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: (_note.body ?? []).length + 1,
              itemBuilder: (context, listIndex) {
                if (listIndex == _note.body!.length) {
                  return ListTile(
                    leading: const Icon(Icons.add),
                    onTap: _setBodyInNote,
                    title: Text(localization.note_add_text),
                  );
                }

                return ListTile(
                  selected: listIndex == indexSelectedValue,
                  leading: const Icon(Icons.edit),
                  onTap: () => _setSelectedValue(listIndex),
                  title: Text(_note.body?[listIndex] ?? '',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 16.0)),
                );
              }),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InputText(
                localization.note_text_placeholder,
                focusNode: _bodyFocusNode,
                controller: _bodyController,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFDEE2E3)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF7A8CBA)),
                ),
                keyboardType: TextInputType.text,
                onSubmitted: _setBodyInNote,
              ),
            ),
            IconButton.filled(
              tooltip: localization.note_add_text,
              onPressed: _setBodyInNote,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
