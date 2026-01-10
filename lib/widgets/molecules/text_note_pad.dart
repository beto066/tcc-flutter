import 'package:flutter/material.dart';
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
    Future.delayed(const Duration(milliseconds: 100), () {
      _focusNode.requestFocus();
    });

    if (widget.index != null) {
      _controller.text = widget.note.body?[widget.index!] ?? '';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Digite algo',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        InputText(
          'label',
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
              child: const Text('Cancelar'),
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
              child: const Text('Salvar'),
            ),
          ],
        ),
      ],
    );
  }
}