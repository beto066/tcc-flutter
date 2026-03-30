class Patient {
  int? id;
  String? name;
  DateTime? birth;
  String? imageName;
  DateTime? treatmentStartedAt;

  Patient({
    this.id,
    this.name,
    this.birth,
    this.imageName,
    this.treatmentStartedAt
  });

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birth': birth?.toUtc().toIso8601String(),
      'imageName': imageName,
      'treatmentStartedAt': treatmentStartedAt?.toUtc().toIso8601String(),
    };
  }
}