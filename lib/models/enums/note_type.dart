enum NoteType {
  notepad(id: 1, description: 'Notepad'),
  table(id: 2, description: 'Table'),
  training(id: 3, description: 'Training');

  const NoteType({required this.id, required this.description});

  final int id;
  final String description;
}