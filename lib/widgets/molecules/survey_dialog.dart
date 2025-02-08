import 'package:flutter/material.dart';
import 'package:tccflutter/widgets/molecules/card_list_item.dart';

class SurveyDialog extends StatefulWidget {
  const SurveyDialog({super.key});

  static Future<void> showSurveyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const SurveyDialog();
      },
    );
  }

  @override
  State<SurveyDialog> createState() => _SurveyDialogState();
}

class _SurveyDialogState extends State<SurveyDialog> {
  static redirectTo(BuildContext context, String page) {
    Navigator.of(context).pushNamed(page);
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
              onTap: () => redirectTo(context, 'Done'),
            ),
            CardListItem(
              'Anotações',
              initialHeight: 50,
              onTap: () => redirectTo(context, 'Gone'),
            ),
            CardListItem(
              'Tabela',
              initialHeight: 50,
              onTap: () => redirectTo(context, 'Gone'),
            ),
          ],
        ),
      ),
    );
  }
}

