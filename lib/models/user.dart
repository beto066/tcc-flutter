import 'dart:ffi';

import 'package:tccflutter/models/enums/role.dart';

class User {
  late final int?  id;
  late final String? name;
  late final String? email;
  late final List<Role?>? roles;
  late final String? imageName;

  User() {
    id = null;
    name = '';
    email = '';
    roles = [];
    imageName = '';
  }

  User.factory(Map<String, dynamic> map) {
    id = map['id'] as int?;
    name = map['name'] as String?;
    email = map['email'] as String?;
    roles = (map['roles'] as List<String>?)?.map((role) => Role.valueOf(role)).toList();
    imageName = map['imageName'] as String?;
  }
}