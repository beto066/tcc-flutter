import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tccflutter/widgets/atoms/associative_label.dart';
import 'package:tccflutter/widgets/atoms/button_tile.dart';
import 'package:tccflutter/widgets/atoms/person_image.dart';
import 'package:tccflutter/widgets/molecules/survey_dialog.dart';

class PatientHeader extends StatelessWidget {
  final String countNotes;
  final String age;
  final String therapyDuration;

  const PatientHeader({super.key, required this.countNotes, required this.age, required this.therapyDuration});

  void _showSurveyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const SurveyDialog();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    var contextHeight = MediaQuery.of(context).size.height;
    var contextWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: contextWidth * 0.75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PersonImage(size: contextWidth * 0.25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssociativeLabel(label: 'quant. anotações', data: countNotes),
              AssociativeLabel(label: 'Idade', data: age),
              AssociativeLabel(label: 'Anos de terapia', data: therapyDuration),
              SizedBox(
                width: contextWidth * 0.5,
                child: ButtonTile(
                  'Levantar dados',
                  fontSize: 13.5,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  onTap: () {
                    _showSurveyDialog(context);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}