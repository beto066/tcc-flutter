import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/widgets/atoms/training_card.dart';

class NoteTrainingPage extends StatefulWidget {
  final Patient patient;

  const NoteTrainingPage({super.key, required this.patient});

  @override
  State<StatefulWidget> createState() {
    return NoteTrainingState();
  }
}

class NoteTrainingState extends State<NoteTrainingPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}