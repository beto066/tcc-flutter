import 'package:tccflutter/exceptions/unexpected_exception.dart';
import 'package:tccflutter/models/user.dart';
import 'package:tccflutter/services/auth_service.dart';

class AuthStore {
  String? _token;
  User? _loggedUser;

  static final AuthStore _instance = AuthStore._internal();

  AuthStore._internal();

  factory AuthStore() {
    return _instance;
  }

  Future<void> login(String email, String password) async {
    _token = await AuthService().login(email, password);

    if (_token == null) {
      throw UnexpectedException('Ocorreu um erro inesperado');
    }

    AuthService().saveToken(_token!);
    _loggedUser = await AuthService().getLoggedUser();
  }

  Future<void> logout() async {
    await AuthService().logout();

    _token = null;
    _loggedUser = null;
  }

  Future<String?> get token async {
    return _token ??= await AuthService().getToken();
  }

  Future<User?> get loggedUser async {
    return _loggedUser ??= await AuthService().getLoggedUser();
  }
}