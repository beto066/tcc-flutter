import 'package:flutter/material.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/widgets/molecules/card_list_item.dart';

class SurveyDialog extends StatefulWidget {
  final Patient patient;

  const SurveyDialog({super.key, required this.patient});

  static Future<void> showSurveyDialog(
    BuildContext context,
    Patient patient
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SurveyDialog(patient: patient);
      },
    );
  }

  @override
  State<SurveyDialog> createState() => _SurveyDialogState();
}

class _SurveyDialogState extends State<SurveyDialog> {
  static redirectTo(BuildContext context, String page, Patient patient) {
    Navigator.of(context).popAndPushNamed(page, arguments: {
      'patient': patient
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        side: BorderSide(color: Colors.black, width: 3)
      ),
      backgroundColor: Colors.white,
      elevation: 50.0,
      title: const Text(
        'Escolha o tipo de levantamento',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 240,
        child: Column(
          children: [
            CardListItem(
              'Testes',
              initialHeight: 50,
              onTap: () => redirectTo(context, 'Done', widget.patient),
            ),
            CardListItem(
              'Anotações',
              initialHeight: 50,
              onTap: () => redirectTo(context, 'NotePad', widget.patient),
            ),
            CardListItem(
              'Tabela',
              initialHeight: 50,
              onTap: () => redirectTo(context, 'NoteTable', widget.patient),
            ),
          ],
        ),
      ),
    );
  }
}

