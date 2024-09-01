import 'package:flutter/material.dart';

class AssociativeLabel extends StatelessWidget {
  final String label;
  final String data;

  const AssociativeLabel({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text("$label: $data");
  }
}