class Patient {
  late final int? id;
  late final String? name;
  late final DateTime? birth;
  late final String? imageName;
  late final DateTime? treatmentStartedAt;

  Patient();

  Patient.factory(Map<String, dynamic> map) {
    id = map['id'] as int?;
    name = map['name'] as String?;
    birth = map['birth'] != null ? DateTime.parse(map['birth']) : null;
    imageName = map['imageName'] as String?;
    treatmentStartedAt = map['treatmentStartedAt'] != null ? DateTime.parse(map['treatmentStartedAt']) : null;
  }

  int? get age {
    if (birth == null) return null;

    final today = DateTime.now();
    int age = today.year - birth!.year;

    if (today.month < birth!.month ||
        (today.month == birth!.month && today.day < birth!.day)) {
      age--;
    }
    return age;
  }

  int? get therapyDuration {
    if (treatmentStartedAt == null) return null;

    final today = DateTime.now();
    int years = today.year - treatmentStartedAt!.year;

    if (today.month < treatmentStartedAt!.month ||
        (today.month == treatmentStartedAt!.month && today.day < treatmentStartedAt!.day)) {
      years--;
    }

    return years;
  }
}