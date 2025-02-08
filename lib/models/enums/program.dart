enum Program {
  matching(id: 1, description: 'Matching'),
  receptive(id: 2, description: 'Receptive'),
  expressive(id: 3, description: 'Expressive');

  const Program({required this.id, required this.description});

  final int id;
  final String description;

  static Program? valueOf(String value) {
    Program? response;

    for (int i = 0; i < Program.values.length && response == null; i++) {
      if (Program.values[i].description == value) {
        response = Program.values[i];
      }
    }

    return response;
  }
}