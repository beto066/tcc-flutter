import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/widgets/atoms/input_text.dart';

class PatientFormFilter extends StatefulWidget {
  const PatientFormFilter({super.key});

  @override
  State<PatientFormFilter> createState() => _PatientFormFilterState();
}

class _PatientFormFilterState extends State<PatientFormFilter> {
  DateTime? _fromDateTimeFilter;
  DateTime? _toDateTimeFilter;
  NoteType? _noteTypeFilter;

  final _textController = TextEditingController();
  final _fromDateTimeController = TextEditingController();
  final _toDateTimeController = TextEditingController();

  Future<DateTime?> _setFromFilter(BuildContext context) async {
    return _fromDateTimeFilter = await _selectDate(context, _fromDateTimeController);
  }

  Future<DateTime?> _setToFilter(BuildContext context) async {
    return _toDateTimeFilter = await _selectDate(context, _toDateTimeController);
  }

  Future<DateTime?> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString().padLeft(4, '0')}";
      });
    }

    return picked;
  }

  @override
  Widget build(BuildContext context) {
    var contextHeight = MediaQuery.of(context).size.height;
    var contextWidth = MediaQuery.of(context).size.width;

    List<DropdownMenuItem<NoteType?>> items = NoteType.values.map((NoteType option) {
      return DropdownMenuItem<NoteType?>(
        value: option,
        child: Text(option.name),
      );
    }).toList();

    items.add(const DropdownMenuItem<NoteType?>(
      value: null,
      child: Text('Tipo'),
    ));

    return Wrap(
      children: [
        SizedBox(width: contextWidth, height: contextHeight * 0.01),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InputText(
            'Título',
            height: 40,
            validator: (_) => null,
            controller: _textController,
            fontSize: 13.5,
          ),
        ),
        SizedBox(width: contextWidth, height: contextHeight * 0.01),
        const SizedBox(width: 10),
        InputText(
          'Desde: ',
          validator: (_) => null,
          controller: _fromDateTimeController,
          width: contextWidth * 0.42,
          height: 40,
          onTap: () => _setFromFilter(context),
          fontSize: 13.5,
        ),
        SizedBox(width: max((contextWidth * 0.16) - 48, 0)),
        // SizedBox(width: contextWidth, height: contextHeight * 0.01),
        InputText(
          'Até: ',
          validator: (_) => null,
          controller: _toDateTimeController,
          width: contextWidth * 0.42,
          height: 40,
          onTap: () => _setToFilter(context),
          fontSize: 13.5,
        ),
        SizedBox(width: contextWidth, height: contextHeight * 0.01),
        const SizedBox(width: 10),
        Container(
          height: 40,
          width: contextWidth * 0.42,
          decoration: BoxDecoration(
            color: Colors.lightBlue[50],
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: const Color(0xFFDEE2E3),
            )
          ),
          child: DropdownButton<NoteType?>(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            style: const TextStyle(color: Colors.black),
            borderRadius: BorderRadius.circular(30.0),
            dropdownColor: Colors.white,
            value: _noteTypeFilter,
            underline: Container(),
            hint: const Text("Tipo", style: TextStyle(color: Colors.black),),
            icon: const Icon(Icons.arrow_drop_down),
            isExpanded: true,
            items: items,
            onChanged: (NoteType? newValue) {
              setState(() {
                _noteTypeFilter = newValue;
              });
            },
          ),
        ),
        SizedBox(width: max((contextWidth * 0.16) - 48, 0)),
        SizedBox(
          width: contextWidth * 0.42,
          height: 40,
          child: ElevatedButton(
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Enviar'),
                Icon(Icons.send)
              ],
            )
          ),
        )
      ],
    );
  }
}