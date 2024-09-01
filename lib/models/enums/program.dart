enum Program {
  matching(id: 1, description: 'Matching'),
  receptive(id: 2, description: 'Receptive'),
  expressive(id: 3, description: 'Expressive');

  const Program({required this.id, required this.description});

  final int id;
  final String description;
}