import 'dart:ffi';

import 'package:tccflutter/models/enums/role.dart';

abstract class User {
  late final Long?  id;
  late final String? name;
  late final String? email;
  late final List<Role>? roles;
  late final String? imageName;
}