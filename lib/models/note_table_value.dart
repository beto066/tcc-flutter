class NoteTableValue {
  late final int? id;
  late final String? label;
  late final String? value;

  NoteTableValue({this.id = 0, this.label = 'ST', this.value = 'Sucesso com dica'});

  NoteTableValue.factory(Map<String, dynamic> map) {
    id = map['id'] as int?;
    label = map['label'] as String?;
    value = map['value'] as String?;
  }
}