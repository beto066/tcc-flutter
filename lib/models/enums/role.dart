enum Role {
  therapist(id: 1, description: 'Therapist'),
  family(id: 2, description: 'Family'),
  networkAdmin(id: 3, description: 'Network_Admin');

  const Role({required this.id, required this.description});

  final int id;
  final String description;

  static Role? valueOf(String label) {
    List<Role?> rolesValues = values;

    return rolesValues.firstWhere(
          (role) => role!.description == label,
      orElse: () => null,
    );
  }
}