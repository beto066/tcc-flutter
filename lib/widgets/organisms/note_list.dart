import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tccflutter/models/note.dart';
import 'package:tccflutter/models/note_pad.dart';
import 'package:tccflutter/widgets/molecules/card_list_item.dart';

class NoteList extends StatelessWidget {
  final List<dynamic> notes;
  final double? height;

  const NoteList({super.key, required this.notes, this.height});

  @override
  Widget build(BuildContext context) {
    var inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    var contextHeight = MediaQuery.of(context).size.height;
    var contextWidth = MediaQuery.of(context).size.width;

    var sizeHeight = height ?? contextHeight * 0.53 - 170;

    return SizedBox(
      height: sizeHeight,
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          var note = notes[index];
          var expandHeight = 0.0;

          if (note is NotePad) {
            expandHeight = (note.body ?? []).length * 15 + 20;
          }

          if (note is Note) {
            return CardListItem(
              note.title ?? 'Sem título',
              subTitle: note.getSubTitle(),
              maxLinesTitle: 1,
              textAlign: TextAlign.left,
              initialHeight: 70,
              finalHeight: sizeHeight - 90,
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat('dd/MM/yyyy').format(note.createdAt)),
                  const Icon(Icons.expand_more)
                ],
              ),
              titleOverflow: TextOverflow.ellipsis,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                height: sizeHeight - 180,
                child: Builder(
                  builder: (context) {
                    if (note is NotePad) {
                      return ListView.builder(
                        itemCount: (note.body ?? []).length,
                        itemBuilder: (context, listIndex) {
                          return Text(
                            note.body?[listIndex] ?? '',
                            style: const TextStyle(fontSize: 15.0)
                          );
                        }
                      );
                    }
                    return Container();
                  }
                ),
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
}