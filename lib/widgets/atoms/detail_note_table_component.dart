import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/note_table.dart';
import 'package:tccflutter/util/training_result_localization.dart';
import 'package:tccflutter/widgets/molecules/select_note_table_value.dart';

class DetailNoteTableComponent extends StatelessWidget {
  final NoteTable note;
  final bool isAuthor;
  final double multipleOf110;
  final Function({int? listIndex})? onModalOpened;

  const DetailNoteTableComponent({
    super.key,
    required this.note,
    required this.isAuthor,
    required this.multipleOf110,
    required this.onModalOpened,
  });

  void _openNoteTableModal({int? listIndex, required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: SelectNoteTableValue(
              note: note,
              index: listIndex,
              onSelect: (value) {
                if (listIndex != null && note.values != null) {
                  note.values![listIndex] = value;
                }

                if (note.values == null) {
                  note.values = [value];
                } else {
                  note.values!.add(value);
                }

                if (Navigator.of(context).mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          );
        });

    onModalOpened?.call(listIndex: listIndex);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    if (note.values == null || note.values!.isEmpty) {
      return Text(localization.note_empty_table);
    }

    final children = note.values!.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value;

      return SizedBox(
        width: isAuthor ? 100 : 70,
        child: ElevatedButton.icon(
          onPressed: () {
            if (isAuthor) {
              _openNoteTableModal(listIndex: index, context: context);
            }
          },
          icon: isAuthor ? const Icon(Icons.edit) : null,
          label: Text(
            localizedTableValueLabel(value, localization),
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
            onPressed: () => onModalOpened?.call(),
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
