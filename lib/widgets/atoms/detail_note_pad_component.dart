import 'package:flutter/material.dart';
import 'package:tccflutter/models/note_pad.dart';
import 'package:tccflutter/widgets/molecules/text_note_pad.dart';

class DetailNotePadComponent extends StatelessWidget {
  final NotePad note;
  final bool isAuthor;
  final Function({int? listIndex})? onModalOpened;

  const DetailNotePadComponent({
    super.key,
    required this.note,
    required this.isAuthor,
    required this.onModalOpened,
  });

  void _openNotePadModal({int? listIndex, required BuildContext context}) {
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
          child: TextNotePad(note: note, index: listIndex)
        );
      }
    );

    onModalOpened?.call(listIndex: listIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (note.body == null || note.body!.isEmpty) {
      return const Text('Nenhum texto nessa anotação');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: isAuthor
          ? note.body!.length + 1
          : note.body!.length,
      itemBuilder: (context, index) {

        if (isAuthor && index == note.body!.length) {
          return ListTile(
            leading: const Icon(Icons.add),
            onTap: () => onModalOpened?.call(),
            title: const Text("Adicionar texto"),
          );
        }

        return ListTile(
          leading: isAuthor ? const Icon(Icons.edit) : null,
          onTap: () => _openNotePadModal(listIndex: index, context: context),
          title: Text(
            note.body![index],
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 16),
          ),
        );
      },
    );
  }
}