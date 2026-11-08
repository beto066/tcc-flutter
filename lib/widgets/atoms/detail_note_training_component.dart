import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/note_training.dart';
import 'package:tccflutter/util/training_result_localization.dart';
import 'package:tccflutter/widgets/molecules/select_note_training_result.dart';

class DetailNoteTrainingComponent extends StatelessWidget {
  final NoteTraining note;
  final bool isAuthor;
  final double multipleOf110;
  final Function({int? listIndex})? onModalOpened;

  const DetailNoteTrainingComponent({
    super.key,
    required this.note,
    required this.isAuthor,
    required this.multipleOf110,
    required this.onModalOpened,
  });

  void _openNoteTrainingModal({int? listIndex, required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: SelectNoteTrainingResult(note: note, index: listIndex),
          );
        });

    onModalOpened?.call(listIndex: listIndex);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    if (note.results == null || note.results!.isEmpty) {
      return Text(localization.note_empty_training);
    }

    final children = note.results!.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value;

      return SizedBox(
        width: isAuthor ? 100 : 70,
        child: ElevatedButton.icon(
          onPressed: () {
            if (isAuthor) {
              _openNoteTrainingModal(listIndex: index, context: context);
            }
          },
          icon: isAuthor ? const Icon(Icons.edit) : null,
          label: Text(
            localizedTrainingResult(value, localization, compact: true),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }).toList();

    if (isAuthor) {
      children.add(
        SizedBox(
          width: 100,
          child: ElevatedButton.icon(
            onPressed: () => _openNoteTrainingModal(context: context),
            icon: const Icon(Icons.add),
            label: Text(localization.note_new_value),
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: multipleOf110,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: children,
        ),
      ),
    );
  }
}
