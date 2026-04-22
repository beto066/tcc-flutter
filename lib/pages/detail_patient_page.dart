import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/stores/note_store.dart';
import 'package:tccflutter/stores/patient_store.dart';
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
  Note? originalNoteExpanded;
  List<Note> notes = [];
  int? expandedId;
  File? image;

  @override
  void initState() {
    _fetchNotes();
    _loadImage();
    super.initState();
  }

  void _onTapImage() {
    if (image != null) {
      showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: InteractiveViewer(
                child: ClipRRect(
                  child: Image.file(image!),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void _onEditImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      await PatientStore().saveImage(File(file.path), widget.patient);
      _loadImage();
    }
  }

  Future<void> _loadImage() async {
    var loadedImage = await PatientStore().getImage(widget.patient);
    setState(() {
      image = loadedImage;
    });
  }

  Future<List<dynamic>> _fetchNotes({Map<String, dynamic>? queries}) async {
    isLoading = true;

    var fetchedNotes = await NoteStore().fetchNotesByPatient(widget.patient, queries);
    setState(() {
      notes = fetchedNotes;
      if (expandedId == null) {
        originalNoteExpanded = null;
        return;
      }
      _setOriginalNote(expandedId!);
    });

    return notes;
  }

  void _onExpanded(int? id) {
    if (expandedId == id) {
      expandedId = null;
      originalNoteExpanded = null;
      return;
    }
    _setOriginalNote(id);

    expandedId = id;
  }

  void _setOriginalNote(int? id) {
    setState(() {
      var expandedNote = notes.firstWhere((note) {
        return note.id == id;
      });

      originalNoteExpanded = expandedNote.clone();
    });
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
            therapyDuration: '${widget.patient.therapyDuration}',
            patient: widget.patient,
            image: image,
            onTapImage: _onTapImage,
            onEditImage: _onEditImage,
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
                    child: PatientFormFilter(onSearch: (queries) {
                      _fetchNotes(queries: queries);
                    }),
                  ),

                  NoteList(
                    notes: notes,
                    height: contextHeight * 0.75 - 100,
                    onSave: _fetchNotes,
                    onExpand: _onExpanded,
                    expandedId: expandedId,
                    originalNoteExpanded: originalNoteExpanded,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
