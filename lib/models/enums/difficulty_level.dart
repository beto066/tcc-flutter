enum DifficultyLevel {
  massTraining(id: 1, description: 'Mass training'),
  distractPhase(id: 2, description: 'Distract phase'),
  extendedTraining(id: 3, description: 'Extended training'),
  randomRotation(id: 4, description: 'Random Rotation');

  const DifficultyLevel({required this.id, required this.description});

  final int id;
  final String description;

  static DifficultyLevel? valueOf(String value) {
    DifficultyLevel? response;

    for (int i = 0; i < DifficultyLevel.values.length && response == null; i++) {
      if (DifficultyLevel.values[i].description == value) {
        response = DifficultyLevel.values[i];
      }
    }

    return response;
  }
}