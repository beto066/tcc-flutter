import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/note_pad.dart';
import 'package:tccflutter/widgets/atoms/input_text.dart';

class TextNotePad extends StatefulWidget
{
  final NotePad note;
  final int? index;
  const TextNotePad({super.key, required this.note, this.index});

  @override
  State<StatefulWidget> createState() {
    return _TextNotePadState();
  }
}

class _TextNotePadState extends State<TextNotePad> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    Future.delayed(const Duration(milliseconds: 100), () {
      _focusNode.requestFocus();
    });

    if (widget.index != null) {
      _controller.text = widget.note.body?[widget.index!] ?? '';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          localization.note_pad_enter_text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        InputText(
          localization.note_text_placeholder,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          validator: (validator) => null,
          controller: _controller
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                if (widget.index != null) {
                  widget.note.body![widget.index!] = _controller.text;
                } else {
                  widget.note.body!.add(_controller.text);
                }

                Navigator.pop(context);
              },
              child: Text(localization.save),
            ),
          ],
        ),
      ],
    );
  }
}