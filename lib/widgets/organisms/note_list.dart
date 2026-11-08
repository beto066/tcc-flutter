import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/note_table.dart';
import 'package:tccflutter/models/note_training.dart';
import 'package:tccflutter/util/training_result_localization.dart';
import 'package:tccflutter/widgets/molecules/card_list_item.dart';
import 'package:tccflutter/widgets/molecules/detail_note.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;
  final Widget? header;
  final int? expandedId;
  final Map<int, GlobalKey> _keys = {};
  final VoidCallback? onSave;
  final void Function(int?)? onExpand;
  final Note? originalNoteExpanded;

  NoteList(
      {super.key,
      required this.notes,
      this.header,
      this.originalNoteExpanded,
      this.expandedId,
      this.onSave,
      this.onExpand});

  String _formatTitleLabel(NoteType? type, AppLocalizations localization) {
    switch (type) {
      case NoteType.table:
        return '(${localization.note_type_table})';
      case NoteType.training:
        return '(${localization.note_type_training})';
      case NoteType.notepad:
        return '(${localization.note_type_notepad})';
      default:
        return '';
    }
  }

  String? _localizedSubtitle(Note note, AppLocalizations localization) {
    if (note is NoteTraining) {
      return note.results
          ?.take(3)
          .map((result) => '|${localizedTrainingResult(result, localization)}|')
          .join(' ');
    }

    if (note is NoteTable) {
      return note.values
          ?.take(3)
          .map(
              (value) => '|${localizedTableValueSummary(value, localization)}|')
          .join(' ');
    }

    return note.getSubTitle();
  }

  void _scrollToItem(int index) {
    final keyContext = _keys[index]?.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 300),
        alignment: 0,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var contextWidth = MediaQuery.of(context).size.width;
    final localization = AppLocalizations.of(context)!;

    return ListView.builder(
        itemCount: notes.length + (header == null ? 0 : 1),
        itemBuilder: (context, listIndex) {
          if (header != null && listIndex == 0) {
            return header!;
          }

          final index = listIndex - (header == null ? 0 : 1);
          var note = notes[index];
          final key = _keys[index] ??= GlobalKey();

          return Container(
            key: key,
            child: CardListItem(
              key: ValueKey(notes[index].id),
              note.title ?? localization.note_untitled,
              subTitle: _localizedSubtitle(note, localization),
              titleLabel: _formatTitleLabel(note.type, localization),
              maxLinesTitle: 1,
              textAlign: TextAlign.left,
              initialHeight: 70,
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(note.createdAt != null
                      ? DateFormat('dd/MM/yyyy').format(note.createdAt!)
                      : ''),
                  const Icon(Icons.expand_more)
                ],
              ),
              titleOverflow: TextOverflow.ellipsis,
              isExpanded: notes[index].id == expandedId,
              onExpand: () async {
                await Future.delayed(const Duration(milliseconds: 300));
                _scrollToItem(index);
                if (onExpand != null) {
                  onExpand!(note.id);
                }
              },
              child: DetailNote(
                  note: note,
                  originalNote: originalNoteExpanded,
                  onSave: onSave),
            ),
          );
        });
  }
}
