
import 'package:flutter/material.dart';
import 'package:tccflutter/models/note_pad.dart';
import 'package:tccflutter/models/patient.dart';
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
  final NotePad _note = NotePad();

  void _setSelectedValue(int index) {
    setState(() {
      indexSelectedValue = index;
    });
  }

  void _setBodyInNote() {
    setState(() {
      if (indexSelectedValue == null) {
        _note.body!.add(_bodyController.value.text ?? '');
      } else {
        _note.body![indexSelectedValue!] = _bodyController.value.text ?? '';
        indexSelectedValue = null;
      }

      _bodyController.clear();
    });
  }

  String? _noteBodyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo não pode ser vazio';
    }

    return null;
  }

  void _onToggleVisibility() {
    setState(() {
      _note.visibilityForFamily = !(_note.visibilityForFamily ?? false);
    });
  }

  Future<void> _onSave() async {
    return;
  }

  @override
  Widget build(BuildContext context) {
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
                label: const Text("Salvar"),
              ),

              const SizedBox(width: 12),

              ElevatedButton.icon(
                onPressed: _onToggleVisibility,
                icon: const Icon(Icons.visibility),
                label: _note.visibilityForFamily ?? false?
                const Text("Tornar Visível"):
                const Text('Tornar Invisível'),
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
              Widget? leading = const Icon(Icons.edit);

              if (listIndex == _note.body!.length) {
                return ListTile(
                  leading: const Icon(Icons.add),
                  onTap: () => {
                    _setBodyInNote()
                  },
                  title: const Text("Adicionar texto"),
                );
              }

              return ListTile(
                selected: listIndex == indexSelectedValue,
                leading: leading,
                onTap: () => {
                  _setSelectedValue(listIndex)
                },
                title: Text(
                  _note.body?[listIndex] ?? '',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16.0)
                ),
              );
            }
          ),
        ),

        InputText(
          'Adcionar body',
          validator: _noteBodyValidator,
          controller: _bodyController,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDEE2E3)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF7A8CBA)),
          ),
          keyboardType: TextInputType.emailAddress,
          onSubmitted: _setBodyInNote,
        ),
      ],
    );
  }
}
