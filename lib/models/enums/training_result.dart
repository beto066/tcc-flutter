enum TrainingResult {
  success(id: 1, label: 'SC', value: 'Success'),
  successWithTip(id: 2, label: 'ST', value: 'Success with tip'),
  error(id: 3, label: 'ER', value: 'Error');

  const TrainingResult({required this.id, required this.label, required this.value});

  final int id;
  final String label;
  final String value;
}