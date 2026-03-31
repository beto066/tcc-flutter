import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/widgets/atoms/associative_label.dart';
import 'package:tccflutter/widgets/atoms/button_tile.dart';
import 'package:tccflutter/widgets/atoms/person_image.dart';
import 'package:tccflutter/widgets/molecules/survey_dialog.dart';

class PatientHeader extends StatelessWidget {
  final String countNotes;
  final String age;
  final String therapyDuration;
  final Patient patient;
  final File? image;
  final VoidCallback? onTapImage;
  final VoidCallback? onEditImage;

  const PatientHeader({
    super.key,
    required this.countNotes,
    required this.age,
    required this.therapyDuration,
    required this.patient,
    this.image,
    this.onTapImage,
    this.onEditImage,
  });

  void _showSurveyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SurveyDialog(patient: patient);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // var inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    // var contextHeight = MediaQuery.of(context).size.height;
    var contextWidth = MediaQuery.of(context).size.width;
    double imageWidth = (contextWidth * 0.25 > 130)? 130: contextWidth * 0.25;

    return SizedBox(
      width: contextWidth * 0.75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PersonImage(
            size: imageWidth,
            selectedImage: image,
            positionedChild: GestureDetector(
              onTap: onEditImage,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[900]!, width: 1),
                ),
                child: Icon(
                  Icons.edit,
                  size: imageWidth * 0.20,
                  color: Colors.grey[900]!,
                ),
              ),
            ),
          ),
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
