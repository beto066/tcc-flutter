import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tccflutter/models/enums/note_type.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/widgets/molecules/card_list_item.dart';
import 'package:tccflutter/widgets/molecules/detail_note.dart';

class NoteList extends StatelessWidget {
  final List<dynamic> notes;
  final double? height;
  final int? expandedIndex;
  final Map<int, GlobalKey> _keys = {};
  final VoidCallback? onSave;
  final void Function(int)? onExpand;
  final Note? originalNoteExpanded;

  final ScrollController _scrollController = ScrollController();

  NoteList({super.key, required this.notes, this.originalNoteExpanded, this.height, this.expandedIndex, this.onSave, this.onExpand});

  String _formatTitleLabel(NoteType? type) {
    switch (type) {
      case NoteType.table:
        return '(Tabela)';
      case NoteType.training:
        return '(Treinamento)';
      case NoteType.notepad:
        return '(Anotação)';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    var contextHeight = MediaQuery.of(context).size.height;
    var contextWidth = MediaQuery.of(context).size.width;
    var sizeHeight = height ?? contextHeight * 0.53 - 170;

    return SizedBox(
      height: sizeHeight,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: notes.length,
        itemBuilder: (context, index) {
          var note = notes[index];
          final key = _keys[index] ??= GlobalKey();

          if (note is Note) {
            return Container(
              key: key,
              child: CardListItem(
                key: ValueKey(notes[index].id),
                note.title ?? 'Sem título',
                subTitle: note.getSubTitle(),
                titleLabel: _formatTitleLabel(note.type),
                maxLinesTitle: 1,
                textAlign: TextAlign.left,
                initialHeight: 70,
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(note.createdAt != null? DateFormat('dd/MM/yyyy').format(note.createdAt!): ''),
                    const Icon(Icons.expand_more)
                  ],
                ),
                titleOverflow: TextOverflow.ellipsis,
                isExpanded: index == expandedIndex,
                onExpand: () async {
                  await Future.delayed(const Duration(milliseconds: 300));
                  _scrollToItem(index);
                  if (onExpand != null) {
                    onExpand!(index);
                  }
                },
                child: DetailNote(note: note, originalNote: originalNoteExpanded, onSave: onSave),
              ),
            );
          }

          return Container();
        }
      ),
    );

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
}