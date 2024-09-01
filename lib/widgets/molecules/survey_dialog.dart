import 'package:flutter/material.dart';
import 'package:tccflutter/widgets/atoms/card_list_item.dart';

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
      elevation: 50.0,
      title: const Text(
        'Escolha o tipo de levantamento',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 330,
        child: Column(
          children: [
            CardListItem(
              'Testes',
              onTap: () => redirectTo(context, 'Done'),
            ),
            CardListItem(
              'Anotações',
              onTap: () => redirectTo(context, 'Gone'),
            ),
            CardListItem(
              'Tabela',
              onTap: () => redirectTo(context, 'Gone'),
            ),
          ],
        ),
      ),
    );
  }
}

