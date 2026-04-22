import 'package:flutter/material.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/note_pad.dart';
import 'package:tccflutter/models/note_table.dart';
import 'package:tccflutter/models/note_training.dart';
import 'package:tccflutter/widgets/atoms/detail_note_pad_component.dart';
import 'package:tccflutter/widgets/atoms/detail_note_table_component.dart';
import 'package:tccflutter/widgets/atoms/detail_note_training_component.dart';

class NoteContent extends StatelessWidget {
  final Note note;
  final bool isAuthor;
  final double sizeHeight;
  final double multipleOf110;

  final Function({int? listIndex})? openNotePadModal;
  final Function({int? listIndex})? openNoteTableModal;
  final Function({int? listIndex})? openNoteTrainingModal;

  const NoteContent({
    super.key,
    required this.note,
    required this.isAuthor,
    required this.sizeHeight,
    required this.multipleOf110,
    this.openNotePadModal,
    this.openNoteTableModal,
    this.openNoteTrainingModal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: sizeHeight - 80),
      child: Builder(
        builder: (context) {
          if (note is NotePad) {
            return DetailNotePadComponent(
              note: note as NotePad,
              isAuthor: isAuthor,
              onModalOpened: openNotePadModal,
            );
          }

          if (note is NoteTable) {
            return DetailNoteTableComponent(
              note: note as NoteTable,
              isAuthor: isAuthor,
              multipleOf110: multipleOf110,
              onModalOpened: openNoteTableModal,
            );
          }

          if (note is NoteTraining) {
            return DetailNoteTrainingComponent(
              note: note as NoteTraining,
              isAuthor: isAuthor,
              multipleOf110: multipleOf110,
              onModalOpened: openNoteTrainingModal,
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}