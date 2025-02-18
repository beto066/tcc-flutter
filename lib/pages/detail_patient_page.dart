import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/stores/note_store.dart';
import 'package:tccflutter/widgets/molecules/card_list_item.dart';
import 'package:tccflutter/widgets/molecules/patient_header.dart';
import 'package:tccflutter/widgets/organisms/note_list.dart';
import 'package:tccflutter/widgets/organisms/patient_form_filter.dart';

class DetailPatientPage extends StatefulWidget {
  final Patient patient;

  const DetailPatientPage(this.patient, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _DetailPatientPageState();
  }
}

class _DetailPatientPageState extends State<DetailPatientPage> {
  var isLoading = true;
  List<dynamic> notes = [];

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  Future<List<dynamic>> _fetchNotes() async {
    isLoading = true;

    var fetchedNotes = await NoteStore().fetchNotesByPatient(widget.patient);
    setState(() {
      notes = fetchedNotes;
    });

    return notes;
  }

  @override
  Widget build(BuildContext context) {
    var inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    var contextHeight = MediaQuery.of(context).size.height;
    var contextWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: contextWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: contextHeight * (contextHeight > 600 ? 0.03 : 0.03)),

          Text(widget.patient.name ?? '',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: (contextHeight * 0.05) > 30? (contextHeight * 0.05): 30)
          ),

          SizedBox(height: contextHeight * (contextHeight > 600 ? 0.01 : 0.01)),
          PatientHeader(
            countNotes: '5',
            age: '${widget.patient.age}',
            therapyDuration: '${widget.patient.therapyDuration}'
          ),

          SizedBox(
            height: contextHeight * 0.80 - 150,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CardListItem(
                    'Abrir filtros de pesquisa',
                    initialHeight: max(contextHeight * 0.06, 50),
                    finalHeight: max(contextHeight * 0.06, 50) + 170,
                    child: const PatientFormFilter(),
                  ),

                  NoteList(notes: notes, height: contextHeight * 0.85 - 300)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
