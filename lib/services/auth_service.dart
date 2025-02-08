import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/models/user.dart';
import 'package:tccflutter/util/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  User? user;

  static final AuthService _instance = AuthService._internal();

  AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  Future<String?> login(String email, String password) async {
    var response = await ApiService().post('/auth', data: {'email': email, 'password': password});

    return response.headers['authorization'];
  }

  Future<void> logout() async {
    user = null;

    await removeToken();
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken');
  }

  Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
  }

  Future<User?> getLoggedUser() async {
    if (user != null) {
      return user;
    }
    
    var token = await getToken();
    var secret = dotenv.env['JWT_KEY'] ?? '';

    return jwtDecrypt(token, secret);
  }

  User? jwtDecrypt(String? token, String? secret) {
    if (token == null ||  secret == null) {
      return null;
    }

    try {
      final jwt = JwtDecoder.decode(token);

      if (jwt.isEmpty) {
        return null;
      }

      return User.factory(jwt);
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao decodificar o JWT: $e');
      }
      return null;
    }
  }
}