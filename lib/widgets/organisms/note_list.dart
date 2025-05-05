import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/widgets/molecules/card_list_item.dart';
import 'package:tccflutter/widgets/molecules/detail_note.dart';

class NoteList extends StatelessWidget {
  final List<dynamic> notes;
  final double? height;
  final Map<int, GlobalKey> _keys = {};

  NoteList({super.key, required this.notes, this.height});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
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
                note.title ?? 'Sem título',
                subTitle: note.getSubTitle(),
                maxLinesTitle: 1,
                textAlign: TextAlign.left,
                initialHeight: 70,
                finalHeight: sizeHeight - 180,
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat('dd/MM/yyyy').format(note.createdAt)),
                    const Icon(Icons.expand_more)
                  ],
                ),
                titleOverflow: TextOverflow.ellipsis,
                child: DetailNote(note: note),
                onExpand: () {
                  _scrollToItem(index);
                },
              ),
            );
          }

          if (kDebugMode) {
            print('object');
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
          duration: Duration(milliseconds: 300),
          alignment: 0, // topo
          curve: Curves.easeInOut,
        );
    }
  }
}