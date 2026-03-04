enum TrainingResult {
  success(id: 1, label: 'SUC', value: 'Success'),
  successWithTip(id: 2, label: 'TIP', value: 'Success with tip'),
  error(id: 3, label: 'ERR', value: 'Error');

  const TrainingResult({required this.id, required this.label, required this.value});

  final int id;
  final String label;
  final String value;

  static TrainingResult? valueOf(String label) {
    List<TrainingResult?> results = values;
    
    return results.firstWhere(
      (result) => result!.label.toUpperCase() == label.toUpperCase()
    );
  }
}